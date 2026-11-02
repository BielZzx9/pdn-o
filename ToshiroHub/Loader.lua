-- ToShiro Hub: Sea 2 / Sea 3 loader
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local scripts = {
    [4442272183] = "SecondSea.lua",
    [79091703265657] = "SecondSea.lua",
    [7449423635] = "ThirdSea.lua",
    [100117331123089] = "ThirdSea.lua",
}

local scriptName = scripts[game.PlaceId]
if not scriptName then
    warn("ToShiro Hub: entre no Sea 2 ou no Sea 3 para executar.")
    return
end

local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
character:WaitForChild("HumanoidRootPart")
character:WaitForChild("Humanoid")
character:WaitForChild("Energy")
player:WaitForChild("Data"):WaitForChild("Level")

local url = "https://raw.githubusercontent.com/BielZzx9/pdn-o/main/ToshiroHub/" .. scriptName
local ok, source = pcall(function()
    return game:HttpGet(url)
end)
if not ok then
    error("ToShiro Hub: falha ao baixar " .. scriptName .. ": " .. tostring(source))
end

local run, compileError = loadstring(source, "@ToShiroHub/" .. scriptName)
if not run then
    error("ToShiro Hub: falha ao compilar " .. scriptName .. ": " .. tostring(compileError))
end
return run()
