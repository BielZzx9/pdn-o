-- BielZzk's AutoClick - ataque automatico extraido do ToShiro Hub.
-- Equipe uma arma. As duas rotinas originais selecionam NPCs e jogadores.
-- Inicia ligado. Use o botao para ligar/desligar e o campo para limitar a distancia.
-- Para remover a janela e encerrar: getgenv().ZzkAutoClick:Stop()
-- Os alcances abaixo sao limites de selecao. O servidor decide quais acertos aceita.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local environment = getgenv()

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
    Distance = 100,
    ValidatedDistance = 60,
    ClickDelay = 0,
    ValidatedInterval = 0.01,
}

local connections = {}
local workers = {}
local gui
local destroyed = false
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
        if folder then
            for _, enemy in ipairs(folder:GetChildren()) do
                local enemyRoot = enemy:FindFirstChild("HumanoidRootPart")
                if enemy ~= character and enemyRoot and isAlive(enemy)
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
            if enemy ~= Player.Character and head and isAlive(enemy)
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
    local playerHead = collectHeads(targets, workspace:FindFirstChild("Characters"))
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

-- GUI pequena com apenas um botao.
local UserInputService = game:GetService("UserInputService")
gui = Instance.new("ScreenGui")
gui.Name = "BielZzkAutoClick"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = gethui and gethui() or Player:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.fromOffset(238, 126)
panel.Position = UDim2.new(0.5, -119, 0.3, 0)
panel.BackgroundColor3 = Color3.fromRGB(21, 21, 24)
panel.BorderSizePixel = 0
panel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = panel

local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(54, 54, 62)
outline.Thickness = 1
outline.Parent = panel

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -24, 0, 30)
title.Position = UDim2.fromOffset(12, 3)
title.BackgroundTransparency = 1
title.Text = "BielZzk's AutoClick"
title.TextColor3 = Color3.fromRGB(242, 242, 247)
title.Font = Enum.Font.GothamMedium
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Active = true
title.Parent = panel

local toggle = Instance.new("TextButton")
toggle.Name = "Toggle"
toggle.Size = UDim2.new(1, -24, 0, 33)
toggle.Position = UDim2.fromOffset(12, 41)
toggle.BorderSizePixel = 0
toggle.Font = Enum.Font.GothamMedium
toggle.TextSize = 13
toggle.AutoButtonColor = true
toggle.Parent = panel

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 9)
buttonCorner.Parent = toggle

local distanceLabel = Instance.new("TextLabel")
distanceLabel.Name = "DistanceLabel"
distanceLabel.Size = UDim2.fromOffset(145, 28)
distanceLabel.Position = UDim2.fromOffset(12, 86)
distanceLabel.BackgroundTransparency = 1
distanceLabel.Text = "Distancia (studs)"
distanceLabel.TextColor3 = Color3.fromRGB(202, 202, 213)
distanceLabel.Font = Enum.Font.Gotham
distanceLabel.TextSize = 12
distanceLabel.TextXAlignment = Enum.TextXAlignment.Left
distanceLabel.Parent = panel

local distanceInput = Instance.new("TextBox")
distanceInput.Name = "DistanceInput"
distanceInput.Size = UDim2.fromOffset(60, 28)
distanceInput.Position = UDim2.fromOffset(166, 86)
distanceInput.BackgroundColor3 = Color3.fromRGB(42, 42, 49)
distanceInput.BorderSizePixel = 0
distanceInput.Font = Enum.Font.GothamMedium
distanceInput.TextSize = 13
distanceInput.TextColor3 = Color3.fromRGB(245, 245, 250)
distanceInput.Text = tostring(Settings.Distance)
distanceInput.ClearTextOnFocus = false
distanceInput.Parent = panel

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 8)
inputCorner.Parent = distanceInput

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

    -- Cancela registros em andamento para o novo limite valer no proximo ciclo.
    if self.Enabled then
        self:SetEnabled(true)
    end
end

table.insert(connections, distanceInput.FocusLost:Connect(function()
    Settings:SetDistance(distanceInput.Text)
end))

local function refreshButton()
    toggle.Text = Settings.Enabled and "Desativar" or "Ativar"
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

table.insert(connections, toggle.Activated:Connect(function()
    Settings:SetEnabled(not Settings.Enabled)
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

Settings:SetEnabled(true)
