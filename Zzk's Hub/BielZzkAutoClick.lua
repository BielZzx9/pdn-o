-- BielZzk's AutoClick - ataque automatico extraido do ToShiro Hub.
-- Equipe uma arma. Jogadores so entram nos alvos quando a opcao estiver ligada.
-- Inicia em espera. Raio automatico ajustavel, com padrao de 120 studs.
-- O botao permite ligar manualmente e desligar. Configuracoes continuam no workspace.
-- Para remover a janela e encerrar: getgenv().ZzkAutoClick:Stop()
-- Os alcances abaixo sao limites de selecao. O servidor decide quais acertos aceita.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local environment = getgenv()
local HttpService = game:GetService("HttpService")

local Modules = ReplicatedStorage:WaitForChild("Modules", 10)
local Net = Modules and Modules:WaitForChild("Net", 10)
local RegisterAttack = Net and Net:WaitForChild("RE/RegisterAttack", 10)
local RegisterHit = Net and Net:WaitForChild("RE/RegisterHit", 10)

if not Player or not Net or not RegisterAttack or not RegisterHit then
    warn("[Zzk] Este jogo nao tem as dependencias de ataque do ToShiro.")
    return
end

if environment.ZzkAutoClick then
    environment.ZzkAutoClick:Stop()
end

local Settings = {
    Enabled = false,
    ManualEnabled = false,
    AutoDetectDistance = 120,
    Distance = 100,
    AttackPlayers = false,
    ValidatedDistance = 60,
    ClickDelay = 0,
    ValidatedInterval = 0.01,
    GuiKey = Enum.KeyCode.F1,
}

local ConfigPath = "BielZzkAutoClick.json"

local function loadConfig()
    if type(readfile) ~= "function" then
        return
    end

    local success, data = pcall(function()
        if type(isfile) == "function" and not isfile(ConfigPath) then
            return nil
        end
        return HttpService:JSONDecode(readfile(ConfigPath))
    end)

    if not success then
        warn("[Zzk] Nao foi possivel ler a configuracao; usando os valores padrao.")
        return
    end
    if type(data) ~= "table" then
        return
    end

    if type(data.AttackPlayers) == "boolean" then
        Settings.AttackPlayers = data.AttackPlayers
    end

    local autoRadius = tonumber(data.AutoDetectDistance)
    if autoRadius and autoRadius == autoRadius and autoRadius ~= math.huge and autoRadius ~= -math.huge then
        Settings.AutoDetectDistance = math.max(1, math.floor(autoRadius + 0.5))
    end

    local distance = tonumber(data.Distance)
    if distance and distance == distance and distance ~= math.huge and distance ~= -math.huge then
        Settings.Distance = math.clamp(math.floor(distance + 0.5), 1, 100)
        Settings.ValidatedDistance = math.min(60, Settings.Distance)
    end

    if type(data.GuiKey) == "string" then
        local valid, key = pcall(function()
            return Enum.KeyCode[data.GuiKey]
        end)
        if valid and key and key ~= Enum.KeyCode.Unknown and key ~= Enum.KeyCode.Escape
            and key.Value < 1000 then
            Settings.GuiKey = key
        end
    end
end

local function saveConfig()
    if type(writefile) ~= "function" then
        warn("[Zzk] O executor nao disponibiliza writefile para salvar a configuracao.")
        return false
    end

    local success = pcall(function()
        writefile(ConfigPath, HttpService:JSONEncode({
            Version = 1,
            Distance = Settings.Distance,
            AutoDetectDistance = Settings.AutoDetectDistance,
            AttackPlayers = Settings.AttackPlayers,
            GuiKey = Settings.GuiKey.Name,
        }))
    end)
    if not success then
        warn("[Zzk] Nao foi possivel salvar a configuracao no workspace.")
    end
    return success
end

loadConfig()

local connections = {}
local workers = {}
local gui
local destroyed = false
local automaticSuppressed = false
local validationRemote
local validationId
local cloneReference = cloneref or function(instance)
    return instance
end

local function cancelWorkers()
    for _, worker in ipairs(workers) do
        if coroutine.status(worker) ~= "dead" then
            pcall(task.cancel, worker)
        end
    end
    workers = {}
end

function Settings:Stop()
    if destroyed then
        return
    end
    destroyed = true
    self.Enabled = false
    cancelWorkers()

    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end

    if gui then
        gui:Destroy()
    end

    if environment.ZzkAutoClick == self then
        environment.ZzkAutoClick = nil
    end
end

environment.ZzkAutoClick = Settings

local function inspectRemote(instance)
    local id = instance:GetAttribute("Id")
    if instance:IsA("RemoteEvent") and id then
        validationRemote = instance
        validationId = id
    end
end

for _, folderName in ipairs({ "Util", "Common", "Remotes", "Assets", "FX" }) do
    local folder = ReplicatedStorage:FindFirstChild(folderName)
    if folder then
        for _, instance in ipairs(folder:GetChildren()) do
            inspectRemote(instance)
        end
        table.insert(connections, folder.ChildAdded:Connect(inspectRemote))
    end
end

local function isAlive(character)
    local humanoid = character and character:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health > 0
end

local function canTarget(character)
    return Settings.AttackPlayers or Players:GetPlayerFromCharacter(character) == nil
end

-- Primeira rotina do hub: ataque, partes dos alvos e registro validado.
local function validatedAttack()
    local character = Player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local tool = character and character:FindFirstChildOfClass("Tool")
    if not root or not tool then
        return
    end

    local weaponType = tool:GetAttribute("WeaponType")
    if weaponType ~= "Melee" and weaponType ~= "Sword" then
        return
    end

    local targets = {}
    for _, folderName in ipairs({ "Enemies", "Characters" }) do
        local folder = workspace:FindFirstChild(folderName)
        if folder and (folderName ~= "Characters" or Settings.AttackPlayers) then
            for _, enemy in ipairs(folder:GetChildren()) do
                local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
                if enemy ~= character and enemyRoot and isAlive(enemy) and canTarget(enemy)
                    and (enemyRoot.Position - root.Position).Magnitude <= Settings.ValidatedDistance then
                    for _, part in ipairs(enemy:GetChildren()) do
                        if part:IsA("BasePart") then
                            targets[#targets + 1] = { enemy, part }
                        end
                    end
                end
            end
        end
    end

    if #targets == 0 then
        return
    end

    require(Net):RemoteEvent("RegisterHit", true)
    RegisterAttack:FireServer()

    local head = targets[1][1]:FindFirstChild("Head")
    if head and validationRemote and validationId then
        RegisterHit:FireServer(
            head,
            targets,
            {},
            tostring(Player.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
        )

        cloneReference(validationRemote):FireServer(
            string.gsub("RE/RegisterHit", ".", function(characterByte)
                return string.char(bit32.bxor(
                    string.byte(characterByte),
                    math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1
                ))
            end),
            bit32.bxor(validationId + 909090, Net.seed:InvokeServer() * 2),
            head,
            targets
        )
    end
end

-- Segunda rotina do hub, incluida uma vez: FastAttack com alcance de selecao de 100.
local function collectHeads(targets, folder)
    local lastHead
    if folder then
        for _, enemy in ipairs(folder:GetChildren()) do
            local head = enemy:FindFirstChild("Head")
            if enemy ~= Player.Character and head and isAlive(enemy) and canTarget(enemy)
                and Player:DistanceFromCharacter(head.Position) < Settings.Distance then
                targets[#targets + 1] = { enemy, head }
                lastHead = head
            end
        end
    end
    return lastHead
end

local function fastAttack()
    local character = Player.Character
    local tool = isAlive(character) and character:FindFirstChildOfClass("Tool")
    if not tool or tool.ToolTip == "Gun" then
        return
    end

    local targets = {}
    local enemyHead = collectHeads(targets, workspace:FindFirstChild("Enemies"))
    local playerHead
    if Settings.AttackPlayers then
        playerHead = collectHeads(targets, workspace:FindFirstChild("Characters"))
    end
    if #targets == 0 then
        return
    end

    local leftClickRemote = tool:FindFirstChild("LeftClickRemote")
    if leftClickRemote then
        for _, target in ipairs(targets) do
            local enemyRoot = target[1]:FindFirstChild("HumanoidRootPart")
            local root = character:FindFirstChild("HumanoidRootPart")
            if enemyRoot and root then
                local direction = (enemyRoot.Position - character:GetPivot().Position).Unit
                pcall(function()
                    leftClickRemote:FireServer(direction, 1)
                end)
            end
        end
    else
        RegisterAttack:FireServer(Settings.ClickDelay)
        RegisterHit:FireServer(enemyHead or playerHead, targets)
    end
end

local lastError
local lastWarning = 0
local function runAttack(callback)
    local success, message = pcall(callback)
    if not success and (message ~= lastError or os.clock() - lastWarning >= 15) then
        lastError = message
        lastWarning = os.clock()
        warn("[Zzk] Auto Click: " .. tostring(message))
    end
end

-- GUI compacta com controle de distancia e atalho para esconder/mostrar.
local UserInputService = game:GetService("UserInputService")
gui = Instance.new("ScreenGui")
gui.Name = "BielZzkAutoClick"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = gethui and gethui() or Player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.fromOffset(190, 166)
panel.Position = UDim2.new(0.5, -95, 0.3, 0)
panel.BackgroundColor3 = Color3.fromRGB(21, 21, 24)
panel.BorderSizePixel = 0
panel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 10)
panelCorner.Parent = panel

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(54, 54, 62)
outline.Thickness = 1
outline.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -16, 0, 22)
title.Position = UDim2.fromOffset(8, 2)
title.BackgroundTransparency = 1
title.Text = "BielZzk's AutoClick"
title.TextColor3 = Color3.fromRGB(242, 242, 247)
title.Font = Enum.Font.GothamMedium
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.Active = true
title.Parent = panel

local toggle = Instance.new("TextButton")
toggle.Name = "Toggle"
toggle.Size = UDim2.new(1, -16, 0, 26)
toggle.Position = UDim2.fromOffset(8, 27)
toggle.BorderSizePixel = 0
toggle.Font = Enum.Font.GothamMedium
toggle.TextSize = 12
toggle.AutoButtonColor = true
toggle.Parent = panel

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = toggle

local distanceLabel = Instance.new("TextLabel")
distanceLabel.Name = "DistanceLabel"
distanceLabel.Size = UDim2.fromOffset(114, 22)
distanceLabel.Position = UDim2.fromOffset(8, 58)
distanceLabel.BackgroundTransparency = 1
distanceLabel.Text = "Distancia (studs)"
distanceLabel.TextColor3 = Color3.fromRGB(202, 202, 213)
distanceLabel.Font = Enum.Font.Gotham
distanceLabel.TextSize = 11
distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
distanceLabel.Parent = panel

local distanceInput = Instance.new("TextBox")
distanceInput.Name = "DistanceInput"
distanceInput.Size = UDim2.fromOffset(54, 22)
distanceInput.Position = UDim2.fromOffset(128, 58)
distanceInput.BackgroundColor3 = Color3.fromRGB(42, 42, 49)
distanceInput.BorderSizePixel = 0
distanceInput.Font = Enum.Font.GothamMedium
distanceInput.TextSize = 12
distanceInput.TextColor3 = Color3.fromRGB(245, 245, 250)
distanceInput.Text = tostring(Settings.Distance)
distanceInput.ClearTextOnFocus = false
distanceInput.Parent = panel

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = distanceInput

local keyLabel = Instance.new("TextLabel")
keyLabel.Name = "GuiKeyLabel"
keyLabel.Size = UDim2.fromOffset(90, 22)
keyLabel.Position = UDim2.fromOffset(8, 84)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Ocultar GUI"
keyLabel.TextColor3 = Color3.fromRGB(202, 202, 213)
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextSize = 11
keyLabel.TextXAlignment = Enum.TextXAlignment.Left
keyLabel.Parent = panel

local keyButton = Instance.new("TextButton")
keyButton.Name = "GuiKeyButton"
keyButton.Size = UDim2.fromOffset(78, 22)
keyButton.Position = UDim2.fromOffset(104, 84)
keyButton.BackgroundColor3 = Color3.fromRGB(42, 42, 49)
keyButton.BorderSizePixel = 0
keyButton.Font = Enum.Font.GothamMedium
keyButton.TextSize = 11
keyButton.TextScaled = true
keyButton.TextColor3 = Color3.fromRGB(245, 245, 250)
keyButton.Text = Settings.GuiKey.Name
keyButton.AutoButtonColor = true
keyButton.Parent = panel

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 7)
keyCorner.Parent = keyButton

local keyTextSize = Instance.new("UITextSizeConstraint")
keyTextSize.MinTextSize = 8
keyTextSize.MaxTextSize = 11
keyTextSize.Parent = keyButton

local choosingKey = false
table.insert(connections, keyButton.Activated:Connect(function()
    choosingKey = not choosingKey
    keyButton.Text = choosingKey and "Tecla..." or Settings.GuiKey.Name
end))

-- O evento pertence ao UserInputService e continua recebendo a tecla com a GUI desativada.
table.insert(connections, UserInputService.InputBegan:Connect(function(input)
    if destroyed or input.UserInputType ~= Enum.UserInputType.Keyboard
        or input.KeyCode == Enum.KeyCode.Unknown or UserInputService:GetFocusedTextBox() then
        return
    end

    if choosingKey then
        choosingKey = false
        if input.KeyCode ~= Enum.KeyCode.Escape then
            Settings.GuiKey = input.KeyCode
            saveConfig()
        end
        keyButton.Text = Settings.GuiKey.Name
        return
    end

    if input.KeyCode == Settings.GuiKey then
        gui.Enabled = not gui.Enabled
    end
end))

local playersLabel = Instance.new("TextLabel")
playersLabel.Name = "PlayersLabel"
playersLabel.Size = UDim2.fromOffset(90, 22)
playersLabel.Position = UDim2.fromOffset(8, 110)
playersLabel.BackgroundTransparency = 1
playersLabel.Text = "Jogadores"
playersLabel.TextColor3 = Color3.fromRGB(202, 202, 213)
playersLabel.Font = Enum.Font.Gotham
playersLabel.TextSize = 11
playersLabel.TextXAlignment = Enum.TextXAlignment.Left
playersLabel.Parent = panel

local playersButton = Instance.new("TextButton")
playersButton.Name = "PlayersButton"
playersButton.Size = UDim2.fromOffset(78, 22)
playersButton.Position = UDim2.fromOffset(104, 110)
playersButton.BorderSizePixel = 0
playersButton.Font = Enum.Font.GothamMedium
playersButton.TextSize = 11
playersButton.TextColor3 = Color3.fromRGB(245, 245, 250)
playersButton.AutoButtonColor = true
playersButton.Parent = panel

local playersCorner = Instance.new("UICorner")
playersCorner.CornerRadius = UDim.new(0, 7)
playersCorner.Parent = playersButton

local function refreshPlayersButton()
    playersButton.Text = Settings.AttackPlayers and "Ligado" or "Desligado"
    playersButton.BackgroundColor3 = Settings.AttackPlayers
        and Color3.fromRGB(111, 92, 211) or Color3.fromRGB(42, 42, 49)
end

function Settings:SetAttackPlayers(enabled)
    if destroyed then
        return
    end
    self.AttackPlayers = enabled == true
    refreshPlayersButton()
    saveConfig()

    -- Cancela alvos de jogadores ja coletados por um registro ainda em andamento.
    if self.Enabled then
        self:SetEnabled(true)
    end
end

table.insert(connections, playersButton.Activated:Connect(function()
    Settings:SetAttackPlayers(not Settings.AttackPlayers)
end))

refreshPlayersButton()

local autoRadiusLabel = Instance.new("TextLabel")
autoRadiusLabel.Name = "AutoRadiusLabel"
autoRadiusLabel.Size = UDim2.fromOffset(114, 22)
autoRadiusLabel.Position = UDim2.fromOffset(8, 136)
autoRadiusLabel.BackgroundTransparency = 1
autoRadiusLabel.Text = "Raio auto (studs)"
autoRadiusLabel.TextColor3 = Color3.fromRGB(202, 202, 213)
autoRadiusLabel.Font = Enum.Font.Gotham
autoRadiusLabel.TextSize = 11
autoRadiusLabel.TextXAlignment = Enum.TextXAlignment.Left
autoRadiusLabel.Parent = panel

local autoRadiusInput = Instance.new("TextBox")
autoRadiusInput.Name = "AutoRadiusInput"
autoRadiusInput.Size = UDim2.fromOffset(54, 22)
autoRadiusInput.Position = UDim2.fromOffset(128, 136)
autoRadiusInput.BackgroundColor3 = Color3.fromRGB(42, 42, 49)
autoRadiusInput.BorderSizePixel = 0
autoRadiusInput.Font = Enum.Font.GothamMedium
autoRadiusInput.TextSize = 12
autoRadiusInput.TextColor3 = Color3.fromRGB(245, 245, 250)
autoRadiusInput.Text = tostring(Settings.AutoDetectDistance)
autoRadiusInput.ClearTextOnFocus = false
autoRadiusInput.Parent = panel

local autoRadiusCorner = Instance.new("UICorner")
autoRadiusCorner.CornerRadius = UDim.new(0, 7)
autoRadiusCorner.Parent = autoRadiusInput

function Settings:SetAutoDetectDistance(value)
    if destroyed then
        return
    end

    local radius = tonumber(value)
    if not radius or radius ~= radius or radius == math.huge or radius == -math.huge then
        autoRadiusInput.Text = tostring(self.AutoDetectDistance)
        return
    end

    self.AutoDetectDistance = math.max(1, math.floor(radius + 0.5))
    autoRadiusInput.Text = tostring(self.AutoDetectDistance)
    saveConfig()
end

table.insert(connections, autoRadiusInput.FocusLost:Connect(function()
    Settings:SetAutoDetectDistance(autoRadiusInput.Text)
end))

-- O limite escolhido restringe ambas as rotinas sem aumentar seus alcances originais.
function Settings:SetDistance(value)
    if destroyed then
        return
    end

    local distance = tonumber(value)
    if not distance or distance ~= distance or distance == math.huge or distance == -math.huge then
        distanceInput.Text = tostring(self.Distance)
        return
    end

    self.Distance = math.clamp(math.floor(distance + 0.5), 1, 100)
    self.ValidatedDistance = math.min(60, self.Distance)
    distanceInput.Text = tostring(self.Distance)
    saveConfig()

    -- Cancela registros em andamento para o novo limite valer no proximo ciclo.
    if self.Enabled then
        self:SetEnabled(true)
    end
end

table.insert(connections, distanceInput.FocusLost:Connect(function()
    Settings:SetDistance(distanceInput.Text)
end))

local function hasNearbyNPC()
    local character = Player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local enemies = workspace:FindFirstChild("Enemies")
    if not root or not enemies or not isAlive(character) then
        return false
    end

    for _, enemy in ipairs(enemies:GetChildren()) do
        local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
        if enemyRoot and isAlive(enemy) and Players:GetPlayerFromCharacter(enemy) == nil
            and (enemyRoot.Position - root.Position).Magnitude <= Settings.AutoDetectDistance then
            return true
        end
    end
    return false
end

local function refreshButton()
    toggle.Text = Settings.Enabled
        and (Settings.ManualEnabled and "Desativar" or "Desativar (auto)") or "Ativar"
    toggle.BackgroundColor3 = Settings.Enabled
        and Color3.fromRGB(111, 92, 211) or Color3.fromRGB(42, 42, 49)
    toggle.TextColor3 = Color3.fromRGB(245, 245, 250)
end

function Settings:SetEnabled(enabled)
    if destroyed then
        return
    end

    self.Enabled = enabled == true
    cancelWorkers()
    refreshButton()
    if not self.Enabled then
        return
    end

    table.insert(workers, task.spawn(function()
        while self.Enabled and not destroyed do
            task.wait(self.ValidatedInterval)
            if self.Enabled and not destroyed then
                runAttack(validatedAttack)
            end
        end
    end))

    table.insert(workers, task.spawn(function()
        while self.Enabled and not destroyed do
            task.wait(self.ClickDelay)
            if self.Enabled and not destroyed then
                runAttack(fastAttack)
            end
        end
    end))
end

local function updateProximity()
    if destroyed then
        return
    end

    local nearby = hasNearbyNPC()
    if not nearby then
        automaticSuppressed = false
    end
    local shouldAttack = Settings.ManualEnabled or (nearby and not automaticSuppressed)
    if Settings.Enabled ~= shouldAttack then
        Settings:SetEnabled(shouldAttack)
    end
end

table.insert(connections, toggle.Activated:Connect(function()
    if Settings.Enabled then
        Settings.ManualEnabled = false
        -- Respeita o desligamento manual ate nao haver mais NPCs nessa area.
        automaticSuppressed = hasNearbyNPC()
        Settings:SetEnabled(false)
    else
        Settings.ManualEnabled = true
        automaticSuppressed = false
        Settings:SetEnabled(true)
    end
end))

local elapsed = 0
table.insert(connections, game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    elapsed = elapsed + deltaTime
    if elapsed >= 0.25 then
        elapsed = 0
        updateProximity()
    end
end))

-- Arraste pelo titulo com mouse ou toque.
local dragging = false
local dragInput
local dragStart
local startPosition
table.insert(connections, title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragInput = input
        dragStart = input.Position
        startPosition = panel.Position
    end
end))

table.insert(connections, UserInputService.InputChanged:Connect(function(input)
    if not dragging or not dragStart or not startPosition then
        return
    end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement and input ~= dragInput then
        return
    end

    local delta = input.Position - dragStart
    local camera = workspace.CurrentCamera
    if camera then
        local viewport = camera.ViewportSize
        local x = startPosition.X.Scale * viewport.X + startPosition.X.Offset + delta.X
        local y = startPosition.Y.Scale * viewport.Y + startPosition.Y.Offset + delta.Y
        panel.Position = UDim2.fromOffset(
            math.clamp(x, 0, math.max(0, viewport.X - panel.AbsoluteSize.X)),
            math.clamp(y, 0, math.max(0, viewport.Y - panel.AbsoluteSize.Y))
        )
    end
end))

table.insert(connections, UserInputService.InputEnded:Connect(function(input)
    if input == dragInput then
        dragging = false
        dragInput = nil
    end
end))

table.insert(connections, gui.Destroying:Connect(function()
    Settings:Stop()
end))

saveConfig()
refreshButton()
updateProximity()
