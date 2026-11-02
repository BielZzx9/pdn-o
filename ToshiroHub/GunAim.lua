return function(tab)
    local env = getgenv()
    if env.__ToshiroSilentGun then return env.__ToshiroSilentGun end
    local players = game:GetService("Players")
    local player = players.LocalPlayer
    local net = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
    net = net and net:FindFirstChild("Net")
    local remote = net and net:FindFirstChild("RE/ShootGunEvent")
    if not remote then return nil end
    local state = {enabled=false, point=nil, part=nil, redirected=0}
    local elapsed = 0
    local function update()
        state.point, state.part = nil, nil
        if not state.enabled then return end
        local character = player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local tool = character and character:FindFirstChildOfClass("Tool")
        if not root or not tool or (tool.ToolTip ~= "Gun" and tool:GetAttribute("WeaponType") ~= "Gun") then return end
        local closest, distance = nil, 1000
        local function consider(model)
            if not model or model == character then return end
            local hum = model:FindFirstChildOfClass("Humanoid")
            local hrp = model:FindFirstChild("HumanoidRootPart")
            if not hum or hum.Health <= 0 or not hrp or not hrp:IsA("BasePart") then return end
            local d = (hrp.Position-root.Position).Magnitude
            if d <= distance then closest, distance = model, d end
        end
        if _G.TargetMode == "Closest NPC" then
            local enemies = workspace:FindFirstChild("Enemies")
            if enemies then for _,npc in ipairs(enemies:GetChildren()) do consider(npc) end end
        elseif _G.TargetMode == "Selected Player" then
            local target = players:FindFirstChild(_G.PlayersList or "")
            if target then consider(target.Character) end
        else
            for _,target in ipairs(players:GetPlayers()) do if target ~= player then consider(target.Character) end end
        end
        if closest then
            local head = closest:FindFirstChild("Head")
            if not head or not head:IsA("BasePart") then head = closest:FindFirstChild("HumanoidRootPart") end
            state.part, state.point = head, head.Position
        end
    end
    state.connection = game:GetService("RunService").Heartbeat:Connect(function(dt)
        elapsed += dt
        if elapsed >= 0.1 then elapsed = 0; update() end
    end)
    -- Only the observed gun event is changed. Resolve Instances outside the hook.
    local sameInstance = compareinstances or function(a,b) return a == b end
    local previous
    local callback = newcclosure(function(self,...)
        if sameInstance(self,remote) and state.enabled and state.point and state.part then
            local args = table.pack(...)
            if typeof(args[1]) == "Vector3" and type(args[2]) == "table" then
                args[1] = state.point
                args[2] = {state.part}
                state.redirected += 1
                return previous(self,table.unpack(args,1,args.n))
            end
        end
        return previous(self,...)
    end)
    previous = hookfunction(remote.FireServer,callback)
    state.previous, state.callback = previous, callback
    state.hookKind = "FireServer"
    state.remote = remote
    env.__ToshiroSilentGun = state
    tab:AddToggle({
        Title = "Aimbot Gun (Silent)",
        Description = "Redireciona o clique. Use com Cam Lock e Aimbot Skills desligados.",
        Default = false,
        Callback = function(enabled)
            state.enabled = enabled
            update()
        end,
    })
    return state
end
