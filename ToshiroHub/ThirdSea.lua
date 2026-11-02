local Services = setmetatable({}, {
    __index = function(self, serviceName)
        local service = game:GetService(serviceName)
        rawset(self, serviceName, service)
        return service
    end
})
local HttpService = Services.HttpService
local FolderName = "ToShiro Hub"
local FileName = "Settings.json"
local FullPath = FolderName .. "/" .. FileName
if makefolder and not isfolder(FolderName) then 
    makefolder(FolderName) 
end
_G.SaveData = _G.SaveData or {}
function SaveSettings()
    if not writefile then return false end
    local success = pcall(function()
        local json = HttpService:JSONEncode(_G.SaveData)
        writefile(FullPath, json)
    end)
    return success
end
function LoadSettings()
    if not (isfile and isfile(FullPath)) then return false end
    local success, result = pcall(function()
        local content = readfile(FullPath)
        return HttpService:JSONDecode(content)
    end)
    if success and result then 
        _G.SaveData = result
        return true
    end
    return false
end
function GetSetting(name, default)
    return _G.SaveData[name] ~= nil and _G.SaveData[name] or default
end
LoadSettings()
local Players = Services.Players
local CollectionService = Services.CollectionService
local ReplicatedStorage = Services.ReplicatedStorage
local player = Players.LocalPlayer
local commE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")
_G.AutoKen = true
local function HasKen()
    local char = player.Character
    return char and CollectionService:HasTag(char, "Ken")
end
task.spawn(function()
    while _G.AutoKen do
        task.wait(0.2)
        if not HasKen() then
            pcall(function()
                commE:FireServer("Ken", true)
            end)
        end
    end
end)
local Lighting = Services.Lighting
Lighting.Ambient = Color3.new(0.695, 0.695, 0.695)
Lighting.ColorShift_Bottom = Color3.new(0.695, 0.695, 0.695)
Lighting.ColorShift_Top = Color3.new(0.695, 0.695, 0.695)
Lighting.Brightness = 2
Lighting.FogEnd = 1e10
do
    ply = Services.Players
    plr = ply.LocalPlayer
    Root = plr.Character.HumanoidRootPart
    replicated = Services.ReplicatedStorage
    Lv = plr.Data.Level.Value
    TeleportService = Services.TeleportService
    TW = Services.TweenService
    Lighting = Services.Lighting
    Enemies = workspace.Enemies
    vim1 = Services.VirtualInputManager
    vim2 = Services.VirtualUser
    TeamSelf = plr.Team
    RunSer = Services.RunService
    Stats = Services.Stats
    Energy = plr.Character.Energy.Value
    Boss = {}
    BringConnections = {}
    MaterialList = {}
    NPCList = {}
    shouldTween = false
    SoulGuitar = false
    KenTest = true
    debug = false
    Brazier1 = false
    Brazier2 = false
    Brazier3 = false
    Sec = 0.1
    ClickState = 0
    Num_self = 25
end
repeat
    local loading = plr.PlayerGui:FindFirstChild("Main")
    loading = loading and loading:FindFirstChild("Loading")
    task.wait()
until game:IsLoaded() and not (loading and loading.Visible)
local placeId = game.PlaceId
if placeId == 2753915549 or placeId == 85211729168715 then
    World1 = true
elseif placeId == 4442272183 or placeId == 79091703265657 then
    World2 = true
elseif placeId == 7449423635 or placeId == 100117331123089 then
    World3 = true
else
    plr:Kick("â Error Blox Fruits - World not recognized")
end
Sea = World1 or World2 or World3
Marines = function()
    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end
Pirates = function()
    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end
if World3 then
	Boss = {
			"Stone",
			"Hydra Leader",
			"Kilo Admiral",
			"Captain Elephant",
			"Beautiful Pirate",
			"Cake Queen",
			"Longma",
			"Soul Reaper",
		};
end;
if World3 then
	MaterialList = {
			"Scrap Metal",
			"Demonic Wisp",
			"Conjured Cocoa",
			"Dragon Scale",
			"Gunpowder",
			"Fish Tail",
			"Mini Tusk",
		};
end;
local e = {
		"Flame",
		"Ice",
		"Quake",
		"Light",
		"Dark",
		"String",
		"Rumble",
		"Magma",
		"Human: Buddha",
		"Sand",
		"Bird: Phoenix",
		"Dough",
	};
local K = {
		"Snow Lurker",
		"Arctic Warrior",
		"Hidden Key",
		"Awakened Ice Admiral",
	};
local n = {
		Mob = "Mythological Pirate",
		Mob2 = "Cursed Skeleton",
		"Hell\'s Messenger",
		Mob3 = "Cursed Skeleton",
		"Heaven\'s Guardian",
	};
local d = {
		"Part",
		"SpawnLocation",
		"Terrain",
		"WedgePart",
		"MeshPart",
	};
local z = { "Swan Pirate", "Jeremy" };
local H = { "Forest Pirate", "Captain Elephant" };
local F = { "Fajita", "Jeremy", "Diamond" };
local Q = {
		"Beast Hunter",
		"Lantern",
		"Guardian",
		"Grand Brigade",
		"Dinghy",
		"Sloop",
		"The Sentinel",
	};
local X = { "Cookie Crafter", "Head Baker", "Baking Staff", "Cake Guard" };
local P = { "Reborn Skeleton", "Posessed Mummy", "Demonic Soul", "Living Zombie" };
local w = {
		["Pirate Millionaire"] = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625),
		["Pistol Billionaire"] = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625),
		["Dragon Crew Warrior"] = CFrame.new(7021.5043945312, 55.762702941895, -730.12908935547),
		["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
		["Female Islander"] = CFrame.new(4692.7939453125, 797.97668457031, 858.84802246094),
		["Venomous Assailant"] = CFrame.new(4902, 670, 39),
		["Marine Commodore"] = CFrame.new(2401, 123, -7589),
		["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
		["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
		["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
		["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
		["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
		["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
		["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
		["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
		["Living Zombie"] = CFrame.new(-10227, 421, 6161),
		["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
		["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
		["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
		["Peanut President"] = CFrame.new(-2215, 159, -10474),
		["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
		["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
		["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
		["Cake Guard"] = CFrame.new(-2024, 38, -12026),
		["Baking Staff"] = CFrame.new(-1932, 38, -12848),
		["Head Baker"] = CFrame.new(-1932, 38, -12848),
		["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
		["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
		["Sweet Thief"] = CFrame.new(116, 36, -12478),
		["Candy Rebel"] = CFrame.new(47, 61, -12889),
		Ghost = CFrame.new(5251, 5, 1111),
	};
EquipWeapon = function(I)
		if not I then
			return;
		end;
		if plr.Backpack:FindFirstChild(I) then
			plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(I));
		end;
	end;
weaponSc = function(I)
		for e, K in pairs(plr.Backpack:GetChildren()) do
			if K:IsA("Tool") then
				if K.ToolTip == I then
					EquipWeapon(K.Name);
				end;
			end;
		end;
	end;
-- The optional legacy death effect is absent in some game versions.
do
    local container = ReplicatedStorage:FindFirstChild("EffectContainer")
    local death = container and container:FindFirstChild("Death")
    if death and death:IsA("ModuleScript") and type(hookfunction) == "function" then
        pcall(function()
            local handler = require(death)
            if type(handler) == "function" then
                hookfunction(handler, function() end)
            end
        end)
    end
end
hookfunction((require((game:GetService("ReplicatedStorage")):WaitForChild("GuideModule"))).ChangeDisplayedNPC, function()
end);
hookfunction(error, function()
end);
hookfunction(warn, function()
end);
local O = workspace:FindFirstChild("Rocks");
if O then
	O:Destroy();
end;
gay = (function()
    local I = game:GetService("Lighting");
    local e = I:FindFirstChild("LightingLayers");
    local origin = workspace:FindFirstChild("_WorldOrigin");
    local K = origin and origin:FindFirstChild("Foam;");
    if K then
        K:Destroy();
    end;
end)();
local G = {};
G.__index = G;
G.Alive = function(I)
		if not I then
			return;
		end;
		local e = I:FindFirstChild("Humanoid");
		return e and e.Health > 0;
	end;
G.Pos = function(I, e)
		return (Root.Position - mode.Position).Magnitude <= e;
	end;
G.Dist = function(I, e)
		return (Root.Position - (I:FindFirstChild("HumanoidRootPart")).Position).Magnitude <= e;
	end;
G.DistH = function(I, e)
		return (Root.Position - (I:FindFirstChild("HumanoidRootPart")).Position).Magnitude > e;
	end;
local noclip = false
local CurrentTarget = nil
getgenv().FarmDistance = 25
spawn(function()
    game:GetService("RunService").Stepped:Connect(function()
        if noclip and game.Players.LocalPlayer.Character then
            for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end)
end)
G.Kill = function(I, e)
    if I and e then
        local hrp = I:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        if not I:GetAttribute("Locked") then
            I:SetAttribute("Locked", hrp.CFrame)
        end
        PosMon = (I:GetAttribute("Locked")).Position
        BringEnemy()
        EquipWeapon(_G.SelectWeapon)
        local char = game.Players.LocalPlayer.Character
        local tool = char and char:FindFirstChildOfClass("Tool")
        local dist = getgenv().FarmDistance or 25
        _tp((hrp.CFrame * CFrame.new(0, dist, 0)) * CFrame.Angles(0, math.rad(180), 0))
        if RandomCFrame then
            task.wait(.5)
            _tp(hrp.CFrame * CFrame.new(0, dist + 5, 25))
            task.wait(.5)
            _tp(hrp.CFrame * CFrame.new(25, dist + 5, 0))
            task.wait(.5)
            _tp(hrp.CFrame * CFrame.new(-25, dist + 5, 0))
            task.wait(.5)
            _tp(hrp.CFrame * CFrame.new(0, dist + 5, 25))
            task.wait(.5)
            _tp(hrp.CFrame * CFrame.new(-25, dist + 5, 0))
        end
    end
end
G.KillSea = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			EquipWeapon(_G.SelectWeapon);
			local e = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");
			local K = e.ToolTip;
			if K == "Blox Fruit" then
				_tp((I.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)) * CFrame.Angles(0, math.rad(90), 0));
			else
				notween(I.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8));
				wait(.85);
				notween(I.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0));
				wait(1);
			end;
		end;
	end;
G.Sword = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			weaponSc("Sword");
			_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
			if RandomCFrame then
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
				wait(.1);
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
			end;
		end;
	end;
_G.FruitSkills = {
    Z = false,
    X = false,
    C = false,
    V = false,
    F = false
}
UseFruitSkills = function()
    weaponSc("Blox Fruit")
    if _G.FruitSkills.Z then
        Useskills("Blox Fruit", "Z")
    end
    if _G.FruitSkills.X then
        Useskills("Blox Fruit", "X")
    end
    if _G.FruitSkills.C then
        Useskills("Blox Fruit", "C")
    end
    if _G.FruitSkills.V then
        Useskills("Blox Fruit", "V")
    end
    if _G.FruitSkills.F then
        vim1:SendKeyEvent(true, "F", false, game)
        vim1:SendKeyEvent(false, "F", false, game)
    end
end
G.Mas = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			if I.Humanoid.Health <= HealthM then
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0));
				UseFruitSkills()
			else
				weaponSc("Melee");
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
			end;
		end;
	end;
G.Masgun = function(I, e)
		if I and e then
			if not I:GetAttribute("Locked") then
				I:SetAttribute("Locked", I.HumanoidRootPart.CFrame);
			end;
			PosMon = (I:GetAttribute("Locked")).Position;
			BringEnemy();
			if I.Humanoid.Health <= HealthM then
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8));
				Useskills("Gun", "Z");
				Useskills("Gun", "X");
			else
				weaponSc("Melee");
				_tp(I.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
			end;
		end;
	end;
statsSetings = function(I, e)
		if I == "Melee" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", e);
			end;
		elseif I == "Defense" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", e);
			end;
		elseif I == "Sword" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", e);
			end;
		elseif I == "Gun" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", e);
			end;
		elseif I == "Devil" then
			if plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", e);
			end;
		end;
	end;
local MobsProcessados = {}  
local BringRange = 275
local function BringEnemySmooth(e)  
local root = e:FindFirstChild("HumanoidRootPart")  
local hum = e:FindFirstChild("Humanoid")  
if not root or not hum then return end  
pcall(function()  
plr.SimulationRadius = math.huge  
end)  
if root:FindFirstChild("BringBody") then return end  
local body = Instance.new("BodyPosition")  
body.Name = "BringBody"  
body.Parent = root  
body.MaxForce = Vector3.new(math.huge, math.huge, math.huge)  
local gyro = Instance.new("BodyGyro")  
gyro.Name = "BringGyro"  
gyro.Parent = root  
gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)  
task.spawn(function()  
while root and root.Parent and hum.Health > 0 and _B and typeof(PosMon) == "Vector3" do  
local dist = (root.Position - PosMon).Magnitude  
if dist > BringRange then  
break  
end  
if dist > 5 then  
body.P = 2e9  
body.D = 5e5  
root.CFrame = CFrame.new(PosMon)  
else  
body.P = 5e8  
body.D = 1e6  
end  
local target = PosMon  
if dist <= 1 then  
target = PosMon  
end  
body.Position = target  
gyro.CFrame = CFrame.new(PosMon)  
root.AssemblyLinearVelocity = Vector3.zero  
root.AssemblyAngularVelocity = Vector3.zero  
root.Velocity = Vector3.zero  
root.RotVelocity = Vector3.zero  
root.CanCollide = false  
task.wait(0.02)  
end  
if body then body:Destroy() end  
if gyro then gyro:Destroy() end  
end)  
end  
BringEnemy = function()  
if not _B or typeof(PosMon) ~= "Vector3" then return end  
for _, e in pairs(workspace.Enemies:GetChildren()) do  
if e:FindFirstChild("Humanoid")  
and e.Humanoid.Health > 0  
and not MobsProcessados[e]  
and e.PrimaryPart  
and (e.PrimaryPart.Position - PosMon).Magnitude <= BringRange then  
MobsProcessados[e] = true        
    task.spawn(function()        
        BringEnemySmooth(e)        
        task.wait(9)        
        MobsProcessados[e] = nil        
    end)        
end  
end  
end  
spawn(function()  
while true do  
if _B then  
BringEnemy()  
task.wait(9)  
else  
task.wait(10)  
end  
end  
end)
Useskills = function(I, e)
		if I == "Melee" then
			weaponSc("Melee");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			elseif e == "C" then
				vim1:SendKeyEvent(true, "C", false, game);
				vim1:SendKeyEvent(false, "C", false, game);
			end;
		elseif I == "Sword" then
			weaponSc("Sword");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			end;
		elseif I == "Blox Fruit" then
			weaponSc("Blox Fruit");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			elseif e == "C" then
				vim1:SendKeyEvent(true, "C", false, game);
				vim1:SendKeyEvent(false, "C", false, game);
			elseif e == "V" then
				vim1:SendKeyEvent(true, "V", false, game);
				vim1:SendKeyEvent(false, "V", false, game);
			end;
		elseif I == "Gun" then
			weaponSc("Gun");
			if e == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game);
				vim1:SendKeyEvent(false, "Z", false, game);
			elseif e == "X" then
				vim1:SendKeyEvent(true, "X", false, game);
				vim1:SendKeyEvent(false, "X", false, game);
			end;
		end;
		if I == "nil" and e == "Y" then
			vim1:SendKeyEvent(true, "Y", false, game);
			vim1:SendKeyEvent(false, "Y", false, game);
		end;
	end;
local J = getrawmetatable(game);
local i = J.__namecall;
setreadonly(J, false);
J.__namecall = newcclosure(function(...)
		local I = getnamecallmethod();
		local e = { ... };
		if tostring(I) == "FireServer" then
			if tostring(e[1]) == "RemoteEvent" then
				if tostring(e[2]) ~= "true" and tostring(e[2]) ~= "false" then
					if _G.FarmMastery_G and not SoulGuitar or _G.FarmMastery_Dev or _G.FarmBlazeEM or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials or _G.AimMethod and ABmethod == "AimBots Skill" or _G.AimMethod and ABmethod == "Auto Aimbots" then
						e[2] = MousePos;
						return i(unpack(e));
					end;
				end;
			end;
		end;
		return i(...);
	end);
GetConnectionEnemies = function(I)
		for e, K in pairs(replicated:GetChildren()) do
			if K:IsA("Model") and ((typeof(I) == "table" and table.find(I, K.Name) or K.Name == I) and (K:FindFirstChild("Humanoid") and K.Humanoid.Health > 0)) then
				return K;
			end;
		end;
		for e, K in next, game.Workspace.Enemies:GetChildren() do
			if K:IsA("Model") and ((typeof(I) == "table" and table.find(I, K.Name) or K.Name == I) and (K:FindFirstChild("Humanoid") and K.Humanoid.Health > 0)) then
				return K;
			end;
		end;
	end;
LowCpu = function()
		local I = true;
		local e = game;
		local K = e.Workspace;
		local n = e.Lighting;
		local d = K.Terrain;
		d.WaterWaveSize = 0;
		d.WaterWaveSpeed = 0;
		d.WaterReflectance = 0;
		d.WaterTransparency = 0;
		n.GlobalShadows = false;
		n.FogEnd = 9000000000.0;
		n.Brightness = 1;
		(settings()).Rendering.QualityLevel = "Level01";
		for e, K in pairs(e:GetDescendants()) do
			if K:IsA("Part") or K:IsA("Union") or K:IsA("CornerWedgePart") or K:IsA("TrussPart") then
				K.Material = "Plastic";
				K.Reflectance = 0;
			elseif K:IsA("Decal") or K:IsA("Texture") and I then
				K.Transparency = 1;
			elseif K:IsA("ParticleEmitter") or K:IsA("Trail") then
				K.Lifetime = NumberRange.new(0);
			elseif K:IsA("Explosion") then
				K.BlastPressure = 1;
				K.BlastRadius = 1;
			elseif K:IsA("Fire") or K:IsA("SpotLight") or K:IsA("Smoke") or K:IsA("Sparkles") then
				K.Enabled = false;
			elseif K:IsA("MeshPart") then
				K.Material = "Plastic";
				K.Reflectance = 0;
				K.TextureID = 10385902758728957;
			end;
		end;
		for I, e in pairs(n:GetChildren()) do
			if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
				e.Enabled = false;
			end;
		end;
	end;
CheckF = function()
		if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then
			return true;
		end;
	end;
CheckBoat = function()
		for I, e in pairs(workspace.Boats:GetChildren()) do
			if tostring(e.Owner.Value) == tostring(plr.Name) then
				return e;
			end;
		end;
		return false;
	end;
CheckEnemiesBoat = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "FishBoat" and (e:FindFirstChild("Health")).Value > 0 then
				return true;
			end;
		end;
		return false;
	end;
CheckPirateGrandBrigade = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if (e.Name == "PirateGrandBrigade" or e.Name == "PirateBrigade") and (e:FindFirstChild("Health")).Value > 0 then
				return true;
			end;
		end;
		return false;
	end;
CheckShark = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Shark" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckTerrorShark = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Terrorshark" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckPiranha = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Piranha" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckFishCrew = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if (e.Name == "Fish Crew Member" or e.Name == "Haunted Crew Member") and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckHauntedCrew = function()
		for I, e in pairs(workspace.Enemies:GetChildren()) do
			if e.Name == "Haunted Crew Member" and G.Alive(e) then
				return true;
			end;
		end;
		return false;
	end;
CheckSeaBeast = function()
		if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
			return true;
		end;
		return false;
	end;
CheckLeviathan = function()
		if workspace.SeaBeasts:FindFirstChild("Leviathan") then
			return true;
		end;
		return false;
	end;
UpdStFruit = function()
		for I, e in next, plr.Backpack:GetChildren() do
			StoreFruit = e:FindFirstChild("EatRemote", true);
			if StoreFruit then
				replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(e.Name));
			end;
		end;
	end;
collectFruits = function(I)
		if I then
			local I = plr.Character;
			for e, K in pairs(workspace:GetChildren()) do
				if string.find(K.Name, "Fruit") then
					K.Handle.CFrame = I.HumanoidRootPart.CFrame;
				end;
			end;
		end;
	end;
Getmoon = function()
		if World1 then
			return Lighting.FantasySky.MoonTextureId;
		elseif World2 then
			return Lighting.FantasySky.MoonTextureId;
		elseif World3 then
			return Lighting.Sky.MoonTextureId;
		end;
	end;
DropFruits = function()
		for I, e in next, plr.Backpack:GetChildren() do
			if string.find(e.Name, "Fruit") then
				EquipWeapon(e.Name);
				wait(.1);
				if plr.PlayerGui.Main.Dialogue.Visible == true then
					plr.PlayerGui.Main.Dialogue.Visible = false;
				end;
				EquipWeapon(e.Name);
				(plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop");
			end;
		end;
		for I, e in pairs(plr.Character:GetChildren()) do
			if string.find(e.Name, "Fruit") then
				EquipWeapon(e.Name);
				wait(.1);
				if plr.PlayerGui.Main.Dialogue.Visible == true then
					plr.PlayerGui.Main.Dialogue.Visible = false;
				end;
				EquipWeapon(e.Name);
				(plr.Character:FindFirstChild(e.Name)).EatRemote:InvokeServer("Drop");
			end;
		end;
	end;
GetBP = function(I)
		return plr.Backpack:FindFirstChild(I) or plr.Character:FindFirstChild(I);
	end;
GetIn = function(I)
		for e, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(K) == "table" then
				if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
					return true;
				end;
			end;
		end;
		return false;
	end;
GetM = function(I)
		for e, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(K) == "table" then
				if K.Type == "Material" then
					if K.Name == I then
						return K.Count;
					end;
				end;
			end;
		end;
		return 0;
	end;
GetWP = function(I)
		for e, K in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
			if type(K) == "table" then
				if K.Type == "Sword" then
					if K.Name == I or plr.Character:FindFirstChild(I) or plr.Backpack:FindFirstChild(I) then
						return true;
					end;
				end;
			end;
		end;
		return false;
	end;
getInfinity_Ability = function(I, e)
		if not Root then
			return;
		end;
		if I == "Soru" and e then
			for I, K in next, getgc() do
				if plr.Character.Soru then
					if typeof(K) == "function" and (getfenv(K)).script == plr.Character.Soru then
						for I, K in next, getupvalues(K) do
							if typeof(K) == "table" then
								repeat
									wait(Sec);
									K.LastUse = 0;
								until not e or plr.Character.Humanoid.Health <= 0;
							end;
						end;
					end;
				end;
			end;
		elseif I == "Energy" and e then
			plr.Character.Energy.Changed:connect(function()
				if e then
					plr.Character.Energy.Value = Energy;
				end;
			end);
		elseif I == "Observation" and e then
			local I = plr.VisionRadius;
			I.Value = math.huge;
		end;
	end;
Hop = function()
		pcall(function()
			for I = math.random(1, math.random(40, 75)), 100, 1 do
				local e = replicated.__ServerBrowser:InvokeServer(I);
				for I, e in next, e do
					if tonumber(e.Count) < 12 then
						TeleportService:TeleportToPlaceInstance(game.PlaceId, I);
					end;
				end;
			end;
		end);
	end;
local ItemConfig = require(game:GetService("ReplicatedStorage").ItemConfig)
local itemCache = {}
local lastItemCheck = 0
local function checkItem(itemName)
    if tick() - lastItemCheck < 5 and itemCache[itemName] ~= nil then
        return itemCache[itemName]
    end
    lastItemCheck = tick()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Tiles") then
            local tiles = v.Tiles
            if type(tiles) == "table" then
                for _, tile in pairs(tiles) do
                    if type(tile) == "table" and tile.ItemId then
                        local config = ItemConfig.tryGet(tile.ItemId)
                        if config and config.Index and config.Index.DebugLabel then
                            if string.find(config.Index.DebugLabel, itemName) then
                                itemCache[itemName] = true
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    itemCache[itemName] = false
    return false
end
function CheckNearestTeleporter(aI)
    local targetPos = aI.Position
    local lp = game.Players.LocalPlayer
    if not lp.Character or not lp.Character:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = lp.Character.HumanoidRootPart.Position
    local placeId = game.PlaceId
    local list = {}
    if (targetPos - myPos).Magnitude < 1500 then return nil end  
    if placeId == 7449423635 or placeId == 100117331123089 then  
        if checkItem("Valkyrie Helm") then  
            list = {Vector3.new(-5096.27, 314.74, -3142.80), Vector3.new(-12471.17, 375.14, -7551.68), Vector3.new(5643.49, 1014.52, -341.89)}  
        end  
    elseif placeId == 4442245405 or placeId == 79091703265657 then  
        local myLevel = lp.Data.Level.Value  
        if myLevel > 1000 and checkItem("Swan Glasses") then  
            list = {Vector3.new(2285, 15, 905), Vector3.new(923, 126, 32852), Vector3.new(-6508.55, 83.44, -132.84), Vector3.new(-286.99, 306.35, 597.79), Vector3.new(3028.59, 2281.08, -7324.82), Vector3.new(28286.36, 14896.73, 102.62)}  
        end  
    elseif placeId == 2753915549 or placeId == 85211729168715 then  
        list = {Vector3.new(-4652, 873, -1754), Vector3.new(-7895, 5547, -380), Vector3.new(61164, 5, 1820), Vector3.new(3865, 5, -1926)}  
    end  
    local best, dist = nil, math.huge
    for _, v in ipairs(list) do
        local d = (v - targetPos).Magnitude
        if d < dist then
            dist = d
            best = v
        end
    end
    if best and dist < (targetPos - myPos).Magnitude then
        return best
    end
    return nil
end
function requestEntrance(pos)
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", pos)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
    end
    task.wait(0.35)
end
getgenv().OnFarm = false
getgenv().currentTween = nil
getgenv().currentTarget = nil
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
_tp = function(targetCFrame)
    local lp = Players.LocalPlayer
    local char = lp.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart
    local hum = char:FindFirstChild("Humanoid")
    local driveTarget = hrp
    if hum and hum.Sit then
        for _, boat in pairs(workspace.Boats:GetChildren()) do
            if boat:FindFirstChild("Owner") and tostring(boat.Owner.Value) == tostring(lp.Name) then
                driveTarget = boat:FindFirstChild("VehicleSeat") or boat:FindFirstChild("Engine") or boat.PrimaryPart
                break
            end
        end
    end
    if not driveTarget then return end
    if not (hum and hum.Sit) and not _G.Level then
        local portal = CheckNearestTeleporter(targetCFrame)
        if portal then
            requestEntrance(portal)
            task.wait(0.1)
            char = lp.Character
            hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then driveTarget = hrp end
        end
    end
    getgenv().OnFarm = true
    shouldTween = true
    if driveTarget == hrp and not hrp:FindFirstChild("NightMysticTweenVelocity") then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "NightMysticTweenVelocity"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
    end
    if hum and not hum.Sit then
        hum.Sit = false
    end
    if driveTarget == hrp then
        hrp.Velocity = Vector3.new(0, 0, 0)
    end
    local distance = (targetCFrame.Position - driveTarget.Position).Magnitude
    if getgenv().currentTween and getgenv().currentTarget then
        local targetDiff = (getgenv().currentTarget.Position - targetCFrame.Position).Magnitude
        if targetDiff < 15 and getgenv().currentTween.PlaybackState == Enum.PlaybackState.Playing then
            return
        end
    end
    local minTweenDist = (hum and hum.Sit) and 5 or 150
    if distance > minTweenDist then
        local speed = (hum and hum.Sit) and (_G.SetSpeedBoat or 300) or (distance <= 1000 and (getgenv().TweenSpeedNear or 300) or (getgenv().TweenSpeedFar or 350))
        local timeInfo = distance / speed
        if getgenv().currentTween then
            getgenv().currentTween:Cancel()
        end
        getgenv().currentTarget = targetCFrame
        local uprightCFrame
        if hum and hum.Sit then
            local targetPos = targetCFrame.Position
            local lookDir = (targetPos - driveTarget.Position).Unit
            local flatLook = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
            uprightCFrame = CFrame.new(targetPos, targetPos + flatLook)
        else
            uprightCFrame = CFrame.new(targetCFrame.Position)
        end
        local tween = TweenService:Create(driveTarget, TweenInfo.new(timeInfo, Enum.EasingStyle.Linear), {CFrame = uprightCFrame})
        getgenv().currentTween = tween
        tween:Play()
        task.spawn(function()
            while getgenv().currentTween == tween and tween.PlaybackState == Enum.PlaybackState.Playing do
                if not getgenv().OnFarm or not shouldTween then
                    tween:Cancel()
                    break
                end
                task.wait()
            end
        end)
        local connection
        connection = tween.Completed:Connect(function()
            if connection then connection:Disconnect() end
            if getgenv().currentTween == tween then
                getgenv().currentTween = nil
                getgenv().currentTarget = nil
            end
        end)
    else
        if getgenv().currentTween then
            getgenv().currentTween:Cancel()
            getgenv().currentTween = nil
            getgenv().currentTarget = nil
        end
        if hum and hum.Sit then
            local targetPos = targetCFrame.Position
            local lookDir = (targetPos - driveTarget.Position).Unit
            local flatLook = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
            driveTarget.CFrame = CFrame.new(targetPos, targetPos + flatLook)
        else
            driveTarget.CFrame = targetCFrame
        end
    end
end
TeleportToTarget = function(I) _tp(I) end
notween = function(I) 
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = I end 
end
RunService.Stepped:Connect(function()
    local char = Players.LocalPlayer.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Sit then
            if hrp and hrp:FindFirstChild("NightMysticTweenVelocity") then
                hrp.NightMysticTweenVelocity:Destroy()
            end
            return
        end
        if getgenv().OnFarm or shouldTween then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            if hrp and hrp:FindFirstChild("NightMysticTweenVelocity") then
                hrp.NightMysticTweenVelocity:Destroy()
            end
            if getgenv().currentTween then
                getgenv().currentTween:Cancel()
                getgenv().currentTween = nil
                getgenv().currentTarget = nil
            end
        end
    end
end)
function BTP(I)
	local e = game.Players.LocalPlayer;
	local K = e.Character.HumanoidRootPart;
	local n = e.Character.Humanoid;
	local d = e.PlayerGui.Main;
	local z = I.Position;
	local H = K.Position;
	repeat
		n.Health = 0;
		K.CFrame = I;
		d.Quest.Visible = false;
		if (K.Position - H).Magnitude > 1 then
			H = K.Position;
			K.CFrame = I;
		end;
		task.wait(.5);
	until (I.Position - K.Position).Magnitude <= 2000;
end;
spawn(function()
	while task.wait() do
		pcall(function()
			if _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or (getgenv()).AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.Auto or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.Auto_StartRaid or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S then
				shouldTween = true;
				if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					local I = Instance.new("BodyVelocity");
					I.Name = "BodyClip";
					I.Parent = plr.Character.HumanoidRootPart;
					I.MaxForce = Vector3.new(100000, 100000, 100000);
					I.Velocity = Vector3.new(0, 0, 0);
				end;
				for I, e in pairs(plr.Character:GetDescendants()) do
					if e:IsA("BasePart") then
						e.CanCollide = false;
					end;
				end;
			else
				shouldTween = false;
				if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
					(plr.Character.HumanoidRootPart:FindFirstChild("BodyClip")):Destroy();
				end;
				if plr.Character:FindFirstChild("highlight") then
					(plr.Character:FindFirstChild("highlight")):Destroy();
				end;
			end;
		end);
	end;
end);
QuestB = function()
		if World3 then
			if _G.FindBoss == "Stone" then
				bMon = "Stone";
				Qname = "PiratePortQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625);
				PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438);
			elseif _G.FindBoss == "Hydra Leader" then
				bMon = "Hydra Leader";
				Qname = "AmazonQuest2";
				Qdata = 3;
				PosQBoss = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
				PosB = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
			elseif _G.FindBoss == "Kilo Admiral" then
				bMon = "Kilo Admiral";
				Qname = "MarineTreeIsland";
				Qdata = 3;
				PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938);
				PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125);
			elseif _G.FindBoss == "Captain Elephant" then
				bMon = "Captain Elephant";
				Qname = "DeepForestIsland";
				Qdata = 3;
				PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875);
				PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125);
			elseif _G.FindBoss == "Beautiful Pirate" then
				bMon = "Beautiful Pirate";
				Qname = "DeepForestIsland2";
				Qdata = 3;
				PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375);
				PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285);
			elseif _G.FindBoss == "Cake Queen" then
				bMon = "Cake Queen";
				Qname = "IceCreamIslandQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, .642767608, 0, 1, 0, -0.642767608, 0, -0.766061664);
				PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, .00149294338, .41757378, .00837114919, .999857843, .0146408929, -0.417492568, .0167988986, -0.90852499);
			elseif _G.FindBoss == "Longma" then
				bMon = "Longma";
				Qdata = nil;
				PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125);
				PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125);
			elseif _G.FindBoss == "Soul Reaper" then
				bMon = "Soul Reaper";
				Qdata = nil;
				PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813);
				PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813);
			end;
		end;
	end;
QuestBeta = function()
		local I = QuestB();
		return {
			[0] = _G.FindBoss,
			[1] = bMon,
			[2] = Qdata,
			[3] = Qname,
			[4] = PosB,
		};
	end;
QuestCheck = function()
    local I = game.Players.LocalPlayer.Data.Level.Value
    if World3 then
if I == 1500 or I <= 1524 then
Mon = "Pirate Millionaire"
Qdata = 1
Qname = "PiratePortQuest"
NameMon = "Pirate Millionaire"
PosQ = CFrame.new(-290.07, 42.90, 5581.59)
PosM = CFrame.new(-246.00, 47.31, 5584.10)
elseif I == 1525 or I <= 1574 then
Mon = "Pistol Billionaire"
Qdata = 2
Qname = "PiratePortQuest"
NameMon = "Pistol Billionaire"
PosQ = CFrame.new(-290.07, 42.90, 5581.59)
PosM = CFrame.new(-187.33, 86.24, 6013.51)
		elseif I == 1575 or I <= 1599 then
    Mon = "Dragon Crew Warrior"
    Qdata = 1
    Qname = "DragonCrewQuest"
    NameMon = "Dragon Crew Warrior"
    PosQ = CFrame.new(6737.06055,127.417763,-712.300659,-0.463954359,-7.19574755e-09,0.885859072,7.69187665e-08,1,4.84078626e-08,-0.885859072,9.05982276e-08,-0.463954359)
    PosM = CFrame.new(6709.76367,52.3442993,-1139.02966,-0.763515472,0,0.645789504,0,1,0,-0.645789504,0,-0.763515472)
elseif I == 1600 or I <= 1624 then
    Mon = "Dragon Crew Archer"
    Qdata = 2
    Qname = "DragonCrewQuest"
    NameMon = "Dragon Crew Archer"
    PosQ = CFrame.new(6737.06055,127.417763,-712.300659,-0.463954359,-7.19574755e-09,0.885859072,7.69187665e-08,1,4.84078626e-08,-0.885859072,9.05982276e-08,-0.463954359)
    PosM = CFrame.new(6668.76172,481.376923,329.12207,-0.121787429,0,-0.992556155,0,1,0,0.992556155,0,-0.121787429)
elseif I == 1625 or I <= 1649 then
    Mon = "Hydra Enforcer"
    Qname = "VenomCrewQuest"
    Qdata = 1
    NameMon = "Hydra Enforcer"
    PosQ = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
    PosM = CFrame.new(4547.11523, 1003.10217, 334.194824, 0.388810456, -0, -0.921317935, 0, 1, -0, 0.921317935, 0, 0.388810456)
elseif I == 1650 or I <= 1699 then
    Mon = "Venomous Assailant"
    Qname = "VenomCrewQuest"
    Qdata = 2
    NameMon = "Venomous Assailant"
    PosQ = CFrame.new(5206.40185546875, 1004.10498046875, 748.3504638671875)
    PosM = CFrame.new(4674.92676, 1134.82654, 996.308838, 0.731321394, -0, -0.682033002, 0, 1, -0, 0.682033002, 0, 0.731321394)
		elseif I == 1700 or I <= 1724 then
			Mon = "Marine Commodore"
			Qdata = 1
			Qname = "MarineTreeIsland"
			NameMon = "Marine Commodore"
			PosQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, .258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
			PosM = CFrame.new(2286.0078125, 73.133918762207, -7159.8090820312)
		elseif I == 1725 or I <= 1774 then
			Mon = "Marine Rear Admiral"
			NameMon = "Marine Rear Admiral"
			Qname = "MarineTreeIsland"
			Qdata = 2
			PosQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
			PosM = CFrame.new(3656.7736816406, 160.52406311035, -7001.5986328125)
		elseif I == 1775 or I <= 1799 then
			Mon = "Fishman Raider"
			Qdata = 1
			Qname = "DeepForestIsland3"
			NameMon = "Fishman Raider"
			PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			PosM = CFrame.new(-10407.526367188, 331.76263427734, -8368.5166015625)
		elseif I == 1800 or I <= 1824 then
			Mon = "Fishman Captain"
			Qdata = 2
			Qname = "DeepForestIsland3"
			NameMon = "Fishman Captain"
			PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			PosM = CFrame.new(-10994.701171875, 352.38140869141, -9002.1103515625)
		elseif I == 1825 or I <= 1849 then
			Mon = "Forest Pirate"
			Qdata = 1
			Qname = "DeepForestIsland"
			NameMon = "Forest Pirate"
			PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247)
			PosM = CFrame.new(-13274.478515625, 332.37814331055, -7769.5805664062)
		elseif I == 1850 or I <= 1899 then
			Mon = "Mythological Pirate"
			Qdata = 2
			Qname = "DeepForestIsland"
			NameMon = "Mythological Pirate"
			PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247)
			PosM = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125)
		elseif I == 1900 or I <= 1924 then
			Mon = "Jungle Pirate"
			Qdata = 1
			Qname = "DeepForestIsland2"
			NameMon = "Jungle Pirate"
			PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			PosM = CFrame.new(-12256.16015625, 331.73828125, -10485.836914062)
		elseif I == 1925 or I <= 1974 then
			Mon = "Musketeer Pirate"
			Qdata = 2
			Qname = "DeepForestIsland2"
			NameMon = "Musketeer Pirate"
			PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			PosM = CFrame.new(-13457.904296875, 391.54565429688, -9859.177734375)
		elseif I == 1975 or I <= 1999 then
			Mon = "Reborn Skeleton"
			Qdata = 1
			Qname = "HauntedQuest1"
			NameMon = "Reborn Skeleton"
			PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			PosM = CFrame.new(-8763.7236328125, 165.72299194336, 6159.8618164062)
		elseif I == 2000 or I <= 2024 then
			Mon = "Living Zombie"
			Qdata = 2
			Qname = "HauntedQuest1"
			NameMon = "Living Zombie"
			PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0)
			PosM = CFrame.new(-10144.131835938, 138.6266784668, 5838.0888671875)
		elseif I == 2025 or I <= 2049 then
			Mon = "Demonic Soul"
			Qdata = 1
			Qname = "HauntedQuest2"
			NameMon = "Demonic Soul"
			PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			PosM = CFrame.new(-9505.8720703125, 172.10482788086, 6158.9931640625)
		elseif I == 2050 or I <= 2074 then
			Mon = "Posessed Mummy"
			Qdata = 2
			Qname = "HauntedQuest2"
			NameMon = "Posessed Mummy"
			PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			PosM = CFrame.new(-9582.0224609375, 6.2515273094177, 6205.478515625)
		elseif I == 2075 or I <= 2099 then
			Mon = "Peanut Scout"
			Qdata = 1
			Qname = "NutsIslandQuest"
			NameMon = "Peanut Scout"
			PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			PosM = CFrame.new(-2143.2419433594, 47.721984863281, -10029.995117188)
		elseif I == 2100 or I <= 2124 then
			Mon = "Peanut President"
			Qdata = 2
			Qname = "NutsIslandQuest"
			NameMon = "Peanut President"
			PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			PosM = CFrame.new(-1859.3540039062, 38.103168487549, -10422.4296875)
		elseif I == 2125 or I <= 2149 then
			Mon = "Ice Cream Chef"
			Qdata = 1
			Qname = "IceCreamIslandQuest"
			NameMon = "Ice Cream Chef"
			PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			PosM = CFrame.new(-872.24658203125, 65.81957244873, -10919.95703125)
		elseif I == 2150 or I <= 2199 then
			Mon = "Ice Cream Commander"
			Qdata = 2
			Qname = "IceCreamIslandQuest"
			NameMon = "Ice Cream Commander"
			PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			PosM = CFrame.new(-558.06103515625, 112.04895782471, -11290.774414062)
		elseif I == 2200 or I <= 2224 then
			Mon = "Cookie Crafter"
			Qdata = 1
			Qname = "CakeQuest1"
			NameMon = "Cookie Crafter"
			PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-08, .288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, .957576931)
			PosM = CFrame.new(-2374.13671875, 37.798263549805, -12125.30859375)
		elseif I == 2225 or I <= 2249 then
			Mon = "Cake Guard"
			Qdata = 2
			Qname = "CakeQuest1"
			NameMon = "Cake Guard"
			PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-08, .288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, .957576931)
			PosM = CFrame.new(-1598.3070068359, 43.773197174072, -12244.581054688)
		elseif I == 2250 or I <= 2274 then
			Mon = "Baking Staff"
			Qdata = 1
			Qname = "CakeQuest2"
			NameMon = "Baking Staff"
			PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, .250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
			PosM = CFrame.new(-1887.8099365234, 77.618507385254, -12998.350585938)
		elseif I == 2275 or I <= 2299 then
			Mon = "Head Baker"
			Qdata = 2
			Qname = "CakeQuest2"
			NameMon = "Head Baker"
			PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, .250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446)
			PosM = CFrame.new(-2216.1882324219, 82.884521484375, -12869.293945312)
		elseif I == 2300 or I <= 2324 then
			Mon = "Cocoa Warrior"
			Qdata = 1
			Qname = "ChocQuest1"
			NameMon = "Cocoa Warrior"
			PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438)
			PosM = CFrame.new(-21.553283691406, 80.574996948242, -12352.387695312)
		elseif I == 2325 or I <= 2349 then
			Mon = "Chocolate Bar Battler"
			Qdata = 2
			Qname = "ChocQuest1"
			NameMon = "Chocolate Bar Battler"
			PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438)
			PosM = CFrame.new(582.59057617188, 77.188095092773, -12463.162109375)
		elseif I == 2350 or I <= 2374 then
			Mon = "Sweet Thief"
			Qdata = 1
			Qname = "ChocQuest2"
			NameMon = "Sweet Thief"
			PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688)
			PosM = CFrame.new(165.1884765625, 76.058853149414, -12600.836914062)
		elseif I == 2375 or I <= 2399 then
			Mon = "Candy Rebel"
			Qdata = 2
			Qname = "ChocQuest2"
			NameMon = "Candy Rebel"
			PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688)
			PosM = CFrame.new(134.86563110352, 77.247680664062, -12876.547851562)
		elseif I == 2400 or I <= 2449 then
			Mon = "Candy Pirate"
			Qdata = 1
			Qname = "CandyQuest1"
			NameMon = "Candy Pirate"
			PosQ = CFrame.new(-1150.0400390625, 20.378934860229, -14446.334960938)
			PosM = CFrame.new(-1310.5003662109, 26.016523361206, -14562.404296875)
		elseif I == 2450 or I <= 2474 then
			Mon = "Isle Outlaw"
			Qdata = 1
			Qname = "TikiQuest1"
			NameMon = "Isle Outlaw"
			PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566)
			PosM = CFrame.new(-16479.900390625, 226.6117401123, -300.31143188477)
		elseif I == 2475 or I <= 2499 then
			Mon = "Island Boy"
			Qdata = 2
			Qname = "TikiQuest1"
			NameMon = "Island Boy"
			PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566)
			PosM = CFrame.new(-16849.396484375, 192.86505126953, -150.78532409668)
		elseif I == 2500 or I <= 2524 then
			Mon = "Sun-kissed Warrior"
			Qdata = 1
			Qname = "TikiQuest2"
			NameMon = "kissed Warrior"
			PosM = CFrame.new(-16347, 64, 984)
			PosQ = CFrame.new(-16538, 55, 1049)
		elseif I == 2525 or I <= 2550 then
			Mon = "Isle Champion"
			Qdata = 2
			Qname = "TikiQuest2"
			NameMon = "Isle Champion"
			PosQ = CFrame.new(-16541.0215, 57.3082275, 1051.46118, .0410757065, 0, -0.999156058, 0, 1, 0, .999156058, 0, .0410757065)
			PosM = CFrame.new(-16602.1015625, 130.38734436035, 1087.2456054688)
		elseif I == 2551 or I <= 2574 then
			Mon = "Serpent Hunter"
			Qdata = 1
			Qname = "TikiQuest3"
			NameMon = "Serpent Hunter"
			PosQ = CFrame.new(-16668.03,105.32,1568.60)
			PosM = CFrame.new(-16645.64,163.09,1352.87)
		elseif I >= 2575 and I <= 2599 then 
			Mon = "Skull Slayer"
			Qdata = 2
			Qname = "TikiQuest3"
			NameMon = "Skull Slayer"
			PosQ = CFrame.new(-16668.03,105.32,1568.60)
			PosM = CFrame.new(-16709.49,419.68,1751.09)
		elseif I >= 2600 and I <= 2624 then
			PosQ = CFrame.new(10778.875, -2087.72437, 9265.18359, 0.934615612, -9.33109447e-08, -0.355659455, 9.17655143e-08, 1, -2.12154276e-08, 0.355659455, -1.28090019e-08, 0.934615612)
			if (getgenv().AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, 0.997390985, 1.47309942e-09, -0.0721890926, -4.00651912e-09, 0.99999994, -2.51183763e-09, 0.0721890852, 5.75363091e-10, 0.997390926))
				task.wait(2)
				local args = {"TravelToSubmergedIsland"}
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
				return
			end
			Mon = "Reef Bandit"
			Qdata = 1
			Qname = "SubmergedQuest1"
			NameMon = "Reef Bandit"
			PosM = CFrame.new(11019.1318, -2146.06812, 9342.3916, -0.719955266, -1.74275385e-08, 0.69402045, 5.76556367e-08, 1, 8.49211546e-08, -0.69402045, 1.01153624e-07, -0.719955266)
		elseif I >= 2625 and I <= 2649 then
			PosQ = CFrame.new(10778.875, -2087.72437, 9265.18359, 0.934615612, -9.33109447e-08, -0.355659455, 9.17655143e-08, 1, -2.12154276e-08, 0.355659455, -1.28090019e-08, 0.934615612)
			if (getgenv().AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, 0.997390985, 1.47309942e-09, -0.0721890926, -4.00651912e-09, 0.99999994, -2.51183763e-09, 0.0721890852, 5.75363091e-10, 0.997390926))
				task.wait(2)
				local args = {"TravelToSubmergedIsland"}
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
				return
			end
			Mon = "Coral Pirate"
			Qdata = 2
			Qname = "SubmergedQuest1"
			NameMon = "Coral Pirate"
			PosM = CFrame.new(10808.6006, -2030.36145, 9364.2334, -0.775185347, -0.0359364748, 0.6307109, 0.0615428537, 0.989336014, 0.132010356, -0.628728986, 0.141148239, -0.764707148)
		elseif I >= 2650 and I <= 2674 then
			PosQ = CFrame.new(10880.6855, -2086.20044, 10032.624, -0.321384728, 9.87648434e-08, -0.946948707, 7.13271007e-08, 1, 8.00902953e-08, 0.946948707, -4.18033075e-08, -0.321384728)
			if (getgenv().AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, 0.997390985, 1.47309942e-09, -0.0721890926, -4.00651912e-09, 0.99999994, -2.51183763e-09, 0.0721890852, 5.75363091e-10, 0.997390926))
				task.wait(2)
				local args = {"TravelToSubmergedIsland"}
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
				return
			end
			Mon = "Sea Chanter"
			Qdata = 1
			Qname = "SubmergedQuest2"
			NameMon = "Sea Chanter"
			PosM = CFrame.new(10671.2715, -2057.59155, 10047.2588, -0.846484065, -3.11045447e-08, 0.532414079, -5.55383117e-08, 1, -2.98785316e-08, -0.532414079, -5.48610757e-08, -0.846484065)
		elseif I >= 2675 and I <= 2699 then
			PosQ = CFrame.new(10880.6855, -2086.20044, 10032.624, -0.321384728, 9.87648434e-08, -0.946948707, 7.13271007e-08, 1, 8.00902953e-08, 0.946948707, -4.18033075e-08, -0.321384728)
			if (getgenv().AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, 0.997390985, 1.47309942e-09, -0.0721890926, -4.00651912e-09, 0.99999994, -2.51183763e-09, 0.0721890852, 5.75363091e-10, 0.997390926))
				task.wait(2)
				local args = {"TravelToSubmergedIsland"}
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
				return
			end
			Mon = "Ocean Prophet"
			Qdata = 2
			Qname = "SubmergedQuest2"
			NameMon = "Ocean Prophet"
			PosM = CFrame.new(11008.5195, -2007.72839, 10223.0791, -0.688615739, 2.33523378e-09, -0.725126445, 2.99292546e-09, 1, 3.78221315e-10, 0.725126445, -1.90980032e-09, -0.688615739)
		elseif I >= 2700 and I <= 2724 then
			PosQ = CFrame.new(9640.08789, -1992.44507, 9613.65234, -0.957327187, 4.11991223e-08, 0.289006323, 1.5775445e-08, 1, -9.02985846e-08, -0.289006323, -8.18860855e-08, -0.957327187)
			if (getgenv().AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, 0.997390985, 1.47309942e-09, -0.0721890926, -4.00651912e-09, 0.99999994, -2.51183763e-09, 0.0721890852, 5.75363091e-10, 0.997390926))
				task.wait(2)
				local args = {"TravelToSubmergedIsland"}
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
				return
			end
			Mon = "High Disciple"
			Qdata = 1
			Qname = "SubmergedQuest3"
			NameMon = "High Disciple"
			PosM = CFrame.new(9750.41602, -1966.93884, 9753.36035, -0.749824047, 5.57797613e-08, -0.661637306, 2.03500754e-08, 1, 6.1243199e-08, 0.661637306, 3.24572511e-08, -0.749824047)
		elseif I >= 2725 then
			PosQ = CFrame.new(9640.08789, -1992.44507, 9613.65234, -0.957327187, 4.11991223e-08, 0.289006323, 1.5775445e-08, 1, -9.02985846e-08, -0.289006323, -8.18860855e-08, -0.957327187)
			if (getgenv().AutoFarm or _G.Level) and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
				_tp(CFrame.new(-16269.7041, 25.2288494, 1373.65955, 0.997390985, 1.47309942e-09, -0.0721890926, -4.00651912e-09, 0.99999994, -2.51183763e-09, 0.0721890852, 5.75363091e-10, 0.997390926))
				task.wait(2)
				local args = {"TravelToSubmergedIsland"}
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer(unpack(args))
				return
			end
			Mon = "Grand Devotee"
			Qdata = 2
			Qname = "SubmergedQuest3"
			NameMon = "Grand Devotee"
			PosM = CFrame.new(9611.70508, -1993.47119, 9882.68848, -0.591375351, 4.14332426e-08, -0.806396425, 4.73774868e-08, 1, 1.66361875e-08, 0.806396425, -2.83668058e-08, -0.591375351)
		end
	end
end
MaterialMon = function()
		local I = game.Players.LocalPlayer;
		local e = I.Character and I.Character:FindFirstChild("HumanoidRootPart");
		if not e then
			return;
		end;
		shouldRequestEntrance = function(I, K)
				local n = (e.Position - I).Magnitude;
				if n >= K then
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", I);
				end;
			end;
		if World3 then
			if SelectMaterial == "Scrap Metal" then
				MMon = { "Jungle Pirate", "Forest Pirate" };
				MPos = CFrame.new(-11975.78515625, 331.77340698242, -10620.030273438);
				SP = "Default";
			elseif SelectMaterial == "Fish Tail" then
				MMon = { "Fishman Raider", "Fishman Captain" };
				MPos = CFrame.new(-10993, 332, -8940);
				SP = "Default";
			elseif SelectMaterial == "Conjured Cocoa" then
				MMon = { "Chocolate Bar Battler", "Cocoa Warrior" };
				MPos = CFrame.new(620.63446044922, 78.936447143555, -12581.369140625);
				SP = "Default";
			elseif SelectMaterial == "Dragon Scale" then
				MMon = { "Dragon Crew Archer", "Dragon Crew Warrior" };
				MPos = CFrame.new(6594, 383, 139);
				SP = "Default";
			elseif SelectMaterial == "Gunpowder" then
				MMon = { "Pistol Billionaire" };
				MPos = CFrame.new(-84.855690002441, 85.620613098145, 6132.0087890625);
				SP = "Default";
			elseif SelectMaterial == "Mini Tusk" then
				MMon = { "Mythological Pirate" };
				MPos = CFrame.new(-13545, 470, -6917);
				SP = "Default";
			elseif SelectMaterial == "Demonic Wisp" then
				MMon = { "Demonic Soul" };
				MPos = CFrame.new(-9495.6806640625, 453.58624267578, 5977.3486328125);
				SP = "Default";
			end;
		end;
	end;
QuestNeta = function()
		local I = QuestCheck();
		return {
			[1] = Mon,
			[2] = Qdata,
			[3] = Qname,
			[4] = PosM,
			[5] = NameMon,
			[6] = PosQ,
		};
	end;
	local Library = loadstring(game:HttpGet("https://files.catbox.moe/o8e56a.txt"))():MakeWindow({
    Title = "ToShiro Hub",
    SubTitle = "By Star And Up",
    SaveFolder = "ToShiro.json"
})
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ControlGUI"
screenGui.Parent = game.CoreGui
local imageButton = Instance.new("ImageButton")
imageButton.Size = UDim2.new(0, 50, 0, 50)
imageButton.Position = UDim2.new(0.15, 0, 0.15, 0)
imageButton.Image = "rbxassetid://110835543207036"
imageButton.BackgroundTransparency = 1
imageButton.Parent = screenGui
local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0.5, 0)
uiCorner.Parent = imageButton
local uiStroke = Instance.new("UIStroke", imageButton)
uiStroke.Thickness = 1
uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
uiStroke.Color = Color3.fromRGB(10, 10, 10)
uiStroke.Transparency = 0.2
local dragging = false
local dragInput
local dragStart
local startPos
local function update(input)
    local delta = input.Position - dragStart
    imageButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end
imageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = imageButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)
imageButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)
local isOpen = true
imageButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        Library:Minimize(false)
    else
        Library:Minimize(true)
    end
end)
Library:Notify({
    Title = "Script Loaded",
    Content = "The script has been successfully loaded",
    Icon = "rbxassetid://10734975486",
    Time = 4
})
local Discord = Library:MakeTab({
    Title = "Discord",
    Icon = "rbxassetid://10723407389"
})
local Farm = Library:MakeTab({
    Title = "Farm",
    Icon = "rbxassetid://10734975486"
})
local Others = Library:MakeTab({
    Title = "Quests/Itens",
    Icon = "rbxassetid://10734975692"
})
local Sea = Library:MakeTab({
    Title = "Sea Events",
    Icon = "rbxassetid://10747376931"
})
local Fish = Library:MakeTab({
    Title = "Fish",
    Icon = "rbxassetid://127664059821666"
})
local Event = Library:MakeTab({
    Title = "Islands",
    Icon = "rbxassetid://10734910680"
})
local Esp = Library:MakeTab({
    Title = "Visuals And Stats",
    Icon = "rbxassetid://10723346959"
})
local Player = Library:MakeTab({
    Title = "Pvp",
    Icon = "rbxassetid://10734975692"
})
local Status = Library:MakeTab({
    Title = "Status",
    Icon = "rbxassetid://10734943448"
})
local Teleport = Library:MakeTab({
    Title = "Teleport",
    Icon = "rbxassetid://10734886004"
})
local Fruit = Library:MakeTab({
    Title = "Fruit/Raid",
    Icon = "rbxassetid://10709790875"
})
local Shop = Library:MakeTab({
    Title = "Shop",
    Icon = "rbxassetid://10734952479"
})
local Setting = Library:MakeTab({
    Title = "Misc",
    Icon = "rbxassetid://10734950309"
})
Discord:AddDiscordInvite({
        Name = "ToShiro Hub | Community",
        Description = "Join our discord community to receive information about the next update",
        Logo = "rbxassetid://110835543207036",
        Banner = "rbxassetid://125012509462882",
        Invite = "https://discord.gg/ftaps6hGhF"
    })
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local World1, World2, World3 = false, false, false
local CurrentSea = 1
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
    World1 = true
    CurrentSea = 1
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
    World2 = true
    CurrentSea = 2
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
    World3 = true
    CurrentSea = 3
end
local NPCS = {
    ["Dark Step"] = {
        Pos = {[1]=Vector3.new(-988,13,3996),[2]=Vector3.new(-4750.61,35.08,-4846.33),[3]=Vector3.new(-5043.64,371.35,-3183.40)},
        Args = {"BuyBlackLeg"}
    },
    ["Electric"] = {
        Pos = {[1]=Vector3.new(-5382.27,14.15,-2150.34),[2]=Vector3.new(-4863.81,35.08,-4767.54),[3]=Vector3.new(-4993.20,314.56,-3198.06)},
        Args = {"BuyElectro"}
    },
    ["Water Kung Fu"] = {
        Pos = {[1]=Vector3.new(61584.35,18.85,988.89),[2]=Vector3.new(-4960.04,35.08,-4662.67),[3]=Vector3.new(-5017.39,371.35,-3187.53)},
        Args = {"BuyFishmanKarate"}
    },
    ["Dragon Breath"] = {
        Pos = {[2]=Vector3.new(1514,15,-2982)},
        Args = {"BlackbeardReward","DragonClaw","2"}
    },
    ["Superhuman"] = {
        Pos = {[2]=Vector3.new(1378.05,247.43,-5189.37),[3]=Vector3.new(-4997.53,371.35,-3197.46)},
        Args = {"BuySuperhuman"}
    },
    ["Death Step"] = {
        Pos = {[2]=Vector3.new(6360.04,296.67,-6763.93),[3]=Vector3.new(-4997.64,314.56,-3220.37)},
        Args = {"BuyDeathStep"}
    },
    ["Sharkman Karate"] = {
        Pos = {[2]=Vector3.new(-2602.40,239.22,-10314.75),[3]=Vector3.new(-4970.48,314.56,-3225.04)},
        Args = {"BuySharkmanKarate"}
    },
    ["Electric Claw"] = {
        Pos = {[3]=Vector3.new(-10369.83,331.69,-10126.49)},
        Args = {"BuyElectricClaw"}
    },
    ["Dragon Talon"] = {
        Pos = {[3]=Vector3.new(5662.03,1211.32,858.60)},
        Args = {"BuyDragonTalon"}
    },
    ["Godhuman"] = {
        Pos = {[3]=Vector3.new(-13775.56,334.66,-9877.67)},
        Args = {"BuyGodhuman"}
    },
    ["Sanguine Art"] = {
        Pos = {[3]=Vector3.new(-16514.86,23.18,-190.84)},
        Args = {"BuySanguineArt"}
    }
}
local CurrentRunningStyle = nil
local function HandleStyleMovement(name, state)
    local varName = "AutoBuy" .. name:gsub(" ", "")
    _G[varName] = state
    if state then
        CurrentRunningStyle = name
    elseif CurrentRunningStyle == name then
        CurrentRunningStyle = nil
    end
    spawn(function()
        while _G[varName] and CurrentRunningStyle == name do
            task.wait()
            pcall(function()
                local data = NPCS[name]
                if data and data.Pos[CurrentSea] then
                    local targetPos = data.Pos[CurrentSea]
                    local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local distance = (root.Position - targetPos).Magnitude
                        if distance > 20 then
                            if _tp then
                                _tp(CFrame.new(targetPos))
                            end
                        else
                            ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(data.Args))
                        end
                    end
                end
            end)
        end
    end)
end
Shop:AddSection("Fighting Shop")
local SelectedStyle = nil
local stylesList = {
    "Dark Step","Electric","Water Kung Fu","Dragon Breath",
    "Superhuman","Death Step","Sharkman Karate",
    "Electric Claw","Dragon Talon","Godhuman","Sanguine Art"
}
Shop:AddDropdown({
    Title = "Select Fighting Style",
    Description = "",
    Options = stylesList,
    Default = nil,
    Callback = function(v)
        SelectedStyle = v
    end
})
Shop:AddToggle({
    Title = "Auto Buy Selected Style",
    Description = "",
    Default = false,
    Callback = function(state)
        if SelectedStyle then
            HandleStyleMovement(SelectedStyle, state)
        end
    end
})
Shop:AddSection("Sword")
local swordsList = {
    "Cutlass","Katana","Iron Mace","Dual Katana","Triple Katana",
    "Pipe","Dual-Headed Blade","Bisento","Soul Cane"
}
Shop:AddDropdown({
    Title = "Select Sword",
    Options = swordsList,
    Callback = function(v)
        SelectedSword = v
    end
})
Shop:AddToggle({
    Title = "Auto Buy Sword",
    Default = false,
    Callback = function(state)
        _G.AutoSword = state
        spawn(function()
            while _G.AutoSword do
                task.wait()
                if SelectedSword then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", SelectedSword)
                end
            end
        end)
    end
})
Shop:AddSection("Gun")
local gunsList = {
    "Slingshot","Musket","Flintlock","Refined Flintlock","Cannon"
}
Shop:AddDropdown({
    Title = "Select Gun",
    Options = gunsList,
    Callback = function(v)
        SelectedGun = v
    end
})
Shop:AddToggle({
    Title = "Auto Buy Gun",
    Default = false,
    Callback = function(state)
        _G.AutoGun = state
        spawn(function()
            while _G.AutoGun do
                task.wait()
                if SelectedGun then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", SelectedGun)
                end
            end
        end)
    end
})
Shop:AddSection("Abilities Shop")
local abilitiesList = {
    "Geppo","Buso","Ken","Soru"
}
Shop:AddDropdown({
    Title = "Select Ability",
    Options = abilitiesList,
    Callback = function(v)
        SelectedAbility = v
    end
})
Shop:AddToggle({
    Title = "Auto Buy Ability",
    Default = false,
    Callback = function(state)
        _G.AutoAbility = state
        spawn(function()
            while _G.AutoAbility do
                task.wait()
                if SelectedAbility == "Ken" then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("KenTalk","Buy")
                else
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", SelectedAbility)
                end
            end
        end)
    end
})
Shop:AddSection("Misc Shop")
local miscList = {
    "Refund","Reroll","Ghoul","Cyborg"
}
Shop:AddDropdown({
    Title = "Select Misc",
    Options = miscList,
    Callback = function(v)
        SelectedMisc = v
    end
})
Shop:AddToggle({
    Title = "Auto Buy Misc",
    Default = false,
    Callback = function(state)
        _G.AutoMisc = state
        spawn(function()
            while _G.AutoMisc do
                task.wait()
                if SelectedMisc == "Refund" then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
                elseif SelectedMisc == "Reroll" then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
                elseif SelectedMisc == "Ghoul" then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("Ectoplasm","Change",4)
                elseif SelectedMisc == "Cyborg" then
                    ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer","Buy")
                end
            end
        end)
    end
})
if World3 then
Status:AddSection("Island Status")
local Miragecheck = Status:AddParagraph("Mirage Island", "Status: âï¸")
spawn(function()
    pcall(function()
        while wait() do
            if game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
                Miragecheck:SetDesc("Status: âï¸")
            else
                Miragecheck:SetDesc("Status: âï¸")
            end
        end
    end)
end)
local Kitsunecheck = Status:AddParagraph("Kitsune Island", "Status: âï¸")
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
                Kitsunecheck:SetDesc("Status: âï¸")
            else
                Kitsunecheck:SetDesc("Status: âï¸")
            end
        end
    end)
end)
local CPrehistoriccheck = Status:AddParagraph("Prehistoric Island", "Status: âï¸")
spawn(function()
    pcall(function()
        while wait() do
            if game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
                CPrehistoriccheck:SetDesc("Status: âï¸")
            else
                CPrehistoriccheck:SetDesc("Status: âï¸")
            end
        end
    end)
end)
local FrozenIsland = Status:AddParagraph("Frozen Dimension", "Status: âï¸")
spawn(function()
    pcall(function()
        while wait() do
            if game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                FrozenIsland:SetDesc("Status: âï¸")
            else
                FrozenIsland:SetDesc("Status: âï¸")
            end
        end
    end)
end)
Status:AddSection("Boss Raid Status")
local MobCakePrince = Status:AddParagraph("Dimension Killed", "")
spawn(function()
    while wait() do
        pcall(function()
            local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
            local len = string.len(response)
            if len == 88 then
                MobCakePrince:SetDesc("Kill : " .. string.sub(response, 39, 41))
            elseif len == 87 then
                MobCakePrince:SetDesc("Kill : " .. string.sub(response, 39, 40))
            elseif len == 86 then
                MobCakePrince:SetDesc("Kill : " .. string.sub(response, 39, 39))
            else
                MobCakePrince:SetDesc("Cake Prince : âï¸")
            end
        end)
    end
end)
local TyrantStatus = Status:AddParagraph("Tyrant of the Skies", "Status: âï¸")
spawn(function()
    pcall(function()
        while wait() do
            if game:GetService("Workspace").Enemies:FindFirstChild("Tyrant of the Skies") then
                TyrantStatus:SetDesc("Status: âï¸")
            else
                TyrantStatus:SetDesc("Status: âï¸")
            end
        end
    end)
end)
local CheckRip = Status:AddParagraph("Rip_Indra", "Status: âï¸")
spawn(function()
    while wait() do
        pcall(function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") 
            or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
                CheckRip:SetDesc("Status: âï¸")
            else
                CheckRip:SetDesc("Status: âï¸")
            end
        end)
    end
end)
local CheckDoughKing = Status:AddParagraph("Dough King", "Status: âï¸")
spawn(function()
    while wait() do
        pcall(function()
            if game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") 
            or game:GetService("Workspace").Enemies:FindFirstChild("Dough King") then
                CheckDoughKing:SetDesc("Status: âï¸")
            else
                CheckDoughKing:SetDesc("Status: âï¸")
            end
        end)
    end
end)
end
Status:AddSection("Misc Status")
local FM = Status:AddParagraph("Full Moon", "")
spawn(function()
    while wait() do
        pcall(function()
            local moonId = game:GetService("Lighting").Sky.MoonTextureId
            if moonId == "http://www.roblox.com/asset/?id=9709149431" then
                FM:SetDesc("Moon: 5/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709149052" then
                FM:SetDesc("Moon: 4/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709143733" then
                FM:SetDesc("Moon: 3/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709150401" then
                FM:SetDesc("Moon: 2/5")
            elseif moonId == "http://www.roblox.com/asset/?id=9709149680" then
                FM:SetDesc("Moon: 1/5")
            else
                FM:SetDesc("Moon: 0/5")
            end
        end)
    end
end)
Farm:AddSection("Global Settings")
Farm:AddDropdown({
    Title = "Select Weapon",
    Description = "",
    Options = {"Melee","Sword","Blox Fruit","Gun"},
    Default = "Melee",
    Multi = false,
    Callback = function(I)
        _G.ChooseWP = I
    end,
})
spawn(function()
    while wait(Sec) do
        pcall(function()
            for _, e in pairs(plr.Backpack:GetChildren()) do
                if e.ToolTip == _G.ChooseWP then
                    if plr.Backpack:FindFirstChild(e.Name) then
                        _G.SelectWeapon = e.Name
                    end
                end
            end
        end)
    end
end)
Farm:AddDropdown({
    Title = "UI Size",
    Description = "",
    Options = {"Small","Medium","Big"},
    Default = "Medium",
    Multi = false,
    Callback = function(v)
        if v == "Small" then
            Library:SetUIScale(0.7)
        elseif v == "Medium" then
            Library:SetUIScale(1)
        elseif v == "Big" then
            Library:SetUIScale(1.15)
        end
    end
})
Farm:AddSection("Farm Options")
_G.Level = false
_G.AutoFarm_Bone = false
Farm:AddToggle({
    Title = "Auto Farm Level",
    Description = "Self plain",
    Default = false,
    Callback = function(v)
        _G.Level = v
    end
})
_G.MaxFarmDistance = 325
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
Farm:AddToggle({
    Title = "Auto Farm Nearest Mobs",
    Description = "Farm nearest mobs",
    Default = GetSetting("AutoFarmNear_Save", false),
    Callback = function(I)
        _G.AutoFarmNear = I
        _G.SaveData["AutoFarmNear_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
    while task.wait() do
        pcall(function()
            if not _G.AutoFarmNear then return end
            local Plr = Players.LocalPlayer
            local Char = Plr.Character or Plr.CharacterAdded:Wait()
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if not Root then return end
            local ClosestEnemy = nil
            local ShortestDistance = math.huge
            if workspace:FindFirstChild("Enemies") then
                for _, e in pairs(workspace.Enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid")
                    and e:FindFirstChild("HumanoidRootPart")
                    and e.Humanoid.Health > 0 then
                        local dist = (Root.Position - e.HumanoidRootPart.Position).Magnitude
                        if dist < ShortestDistance then
                            ShortestDistance = dist
                            ClosestEnemy = e
                        end
                    end
                end
            end
            if ReplicatedStorage:FindFirstChild("Enemies") then
                for _, e in pairs(ReplicatedStorage.Enemies:GetChildren()) do
                    if e:IsA("Model") and e:FindFirstChild("Humanoid") then
                        if not ClosestEnemy then
                            ClosestEnemy = e
                        end
                    end
                end
            end
            if ClosestEnemy and (not _G.MaxFarmDistance or ShortestDistance <= _G.MaxFarmDistance) then
                repeat
                    task.wait()
                    if G and G.Kill then
                        G.Kill(ClosestEnemy, _G.AutoFarmNear)
                    end
                until not _G.AutoFarmNear
                or not ClosestEnemy.Parent
                or (ClosestEnemy:FindFirstChild("Humanoid") and ClosestEnemy.Humanoid.Health <= 0)
                or not Root.Parent
            end
        end)
    end
end)
local Sec = 0.5
if World3 then
Farm:AddToggle({
    Title = "Auto Raid Pirate",
    Description = "Auto raid pirate in sea 3",
    Default = GetSetting("AutoRaidCastle_Save", false),
    Callback = function(I)
        _G.AutoRaidCastle = I
        _G.SaveData["AutoRaidCastle_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
    while wait(Sec) do
        if _G.AutoRaidCastle then
            pcall(function()
                local TargetCFrame = CFrame.new(-5496.17432, 313.768921, -2841.53027, .924894512, 7.37058015e-09, .380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, .924894512)
                local CheckCFrame = CFrame.new(-5539.3115234375, 313.80053710938, -2972.3723144531)
                if (CheckCFrame.Position - Root.Position).Magnitude <= 500 then
                    for _, e in pairs(workspace.Enemies:GetChildren()) do
                        if e:FindFirstChild("HumanoidRootPart") and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                            if (e.HumanoidRootPart.Position - Root.Position).Magnitude <= 2000 then
                                repeat
                                    wait()
                                    G.Kill(e, _G.AutoRaidCastle)
                                until not _G.AutoRaidCastle or not e.Parent or e.Humanoid.Health <= 0 or not workspace.Enemies:FindFirstChild(e.Name)
                            end
                        end
                    end
                else
                    local EnemyList = {
                        "Galley Pirate",
                        "Galley Captain",
                        "Raider",
                        "Mercenary",
                        "Vampire",
                        "Zombie",
                        "Snow Trooper",
                        "Winter Warrior",
                        "Lab Subordinate",
                        "Horned Warrior",
                        "Magma Ninja",
                        "Lava Pirate",
                        "Ship Deckhand",
                        "Ship Engineer",
                        "Ship Steward",
                        "Ship Officer",
                        "Arctic Warrior",
                        "Snow Lurker",
                        "Sea Soldier",
                        "Water Fighter",
                    }
                    for _, enemyName in pairs(EnemyList) do
                        if replicated:FindFirstChild(enemyName) then
                            for _, n in pairs(replicated:GetChildren()) do
                                if table.find(EnemyList, n.Name) then
                                    _tp(TargetCFrame)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
end
local TELEPORT_DISTANCE_THRESHOLD = 15 
local function TeleportConditional(hrp, targetCFrame, threshold)
    if not hrp or not targetCFrame then return end
    local dist = (targetCFrame.Position - hrp.Position).Magnitude  
    if dist > threshold then  
        _tp(targetCFrame)  
    end
end
local CurrentMob = nil
local function GetNearestMob(TargetName)
    local plr = game.Players.LocalPlayer
    local Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if not Root then return nil end
    local Closest, Dist = nil, math.huge    
    for _, Mob in pairs(workspace.Enemies:GetChildren()) do    
        if G.Alive(Mob) and Mob.Name == TargetName and Mob:FindFirstChild("HumanoidRootPart") then    
            local d = (Mob.HumanoidRootPart.Position - Root.Position).Magnitude    
            if d < Dist then Dist = d Closest = Mob end    
        end    
    end  
    return Closest
end
spawn(function()
    while task.wait() do
        if _G.Level then
            pcall(function()
                local plr = game.Players.LocalPlayer  
                local Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")  
                if not Root then return end  
                local Q = QuestNeta()  
                if not plr.PlayerGui.Main.Quest.Visible then      
                    TeleportConditional(Root, Q[6], TELEPORT_DISTANCE_THRESHOLD)      
                    if (Root.Position - Q[6].Position).Magnitude <= 50 then      
                        task.wait(1.5)  
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", Q[3], Q[2])      
                    end      
                    return      
                end      
                local Nearest = GetNearestMob(Q[1])  
                if CurrentMob and G.Alive(CurrentMob) and CurrentMob.Parent then      
                    G.Kill(CurrentMob, true)      
                    return      
                else CurrentMob = nil end      
                if not Nearest then TeleportConditional(Root, Q[4], TELEPORT_DISTANCE_THRESHOLD) return end
                CurrentMob = Nearest
                if CurrentMob and CurrentMob:FindFirstChild("HumanoidRootPart") then _tp(CurrentMob.HumanoidRootPart.CFrame) end
                repeat task.wait() G.Kill(CurrentMob, true) until not _G.Level or not CurrentMob.Parent or CurrentMob.Humanoid.Health <= 0      
                CurrentMob = nil      
            end)  
        end  
    end
end)
spawn(function()
    while task.wait() do
        if _G.AutoFarm_Bone then
            pcall(function()
                local plr = game.Players.LocalPlayer  
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")  
                if not hrp then return end  
                local MOBS = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}
                local function GetClosestMob()      
                    local closest, shortest = nil, math.huge      
                    for _, mobName in pairs(MOBS) do      
                        for _, mob in pairs(workspace.Enemies:GetChildren()) do      
                            if mob.Name == mobName and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then      
                                local dist = (mob.PrimaryPart.Position - hrp.Position).Magnitude      
                                if dist < shortest then shortest = dist closest = mob end      
                            end      
                        end      
                    end      
                    return closest      
                end      
                local mob = GetClosestMob()      
                if mob then      
                    _tp(mob.PrimaryPart.CFrame)      
                    EquipWeapon(_G.SelectWeapon)
                    G.Kill(mob, true)
                else      
                    _tp(CFrame.new(-9495.68, 453.58, 5977.34))      
                end      
            end)  
        end  
    end
end)
if World3 then 
Farm:AddSection("Bone")
Farm:AddToggle({
    Title = "Auto Farm Bone",
    Description = "Farm haunted castle mobs",
    Default = false,
    Callback = function(v)
        _G.AutoFarm_Bone = v
    end
})
Farm:AddToggle({
    Title = "Auto Soul Reaper",
    Description = "Farm soul reaper boss",
    Default = false,
    Callback = function(v)
        _G.AutoHytHallow = v
    end,
})
spawn(function()
    while wait(Sec) do
        if _G.AutoHytHallow then
            pcall(function()
                local mob = GetConnectionEnemies("Soul Reaper")
                if mob then
                    repeat task.wait()
                        G.Kill(mob,_G.AutoHytHallow)
                    until mob.Humanoid.Health <= 0 or not _G.AutoHytHallow
                else
                    if not GetBP("Hallow Essence") then
                        repeat task.wait(.1)
                            replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
                        until not _G.AutoHytHallow or GetBP("Hallow Essence")
                    else
                        local pos = CFrame.new(-8932.32,146.83,6062.55)
                        repeat wait(.1)
                            _tp(pos)
                        until not _G.AutoHytHallow or plr.Character.HumanoidRootPart.CFrame == pos
                        EquipWeapon("Hallow Essence")
                    end
                end
            end)
        end
    end
end)
Farm:AddToggle({
    Title = "Auto Random Bone",
    Description = "Trade bone material",
    Default = false,
    Callback = function(v)
        _G.Auto_Random_Bone = v
    end,
})
spawn(function()
    while wait(Sec) do
        if _G.Auto_Random_Bone then
            replicated.Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
        end
    end
end)
end
Farm:AddSection("Collect")
Farm:AddToggle({
Title = "Auto Collect Chest [Tween]",
Description = "",
Default = GetSetting("AutoFarmChest_Save", false),
Callback = function(I)
_G.AutoFarmChest = I
_G.SaveData["AutoFarmChest_Save"] = I
SaveSettings()
end,
})
Farm:AddToggle({
Title = "Auto Collect Chest [Bypass]",
Description = "",
Default = GetSetting("AutoFarmChestBypass_Save", false),
Callback = function(I)
_G.AutoFarmChestBypass = I
_G.SaveData["AutoFarmChestBypass_Save"] = I
SaveSettings()
end,
})
Farm:AddToggle({
Title = "Auto Collect Berry",
Description = "",
Default = GetSetting("AutoBerry_Save", false),
Callback = function(I)
_G.AutoBerry = I
_G.SaveData["AutoBerry_Save"] = I
SaveSettings()
end,
})
spawn(function()
while wait(Sec) do
if _G.AutoBerry then
local I = game:GetService("CollectionService")
local e = game:GetService("Players")
local K = e.LocalPlayer
local n = I:GetTagged("BerryBush")
for i = 1, #n do
local bush = n[i]
for _, attr in pairs(bush:GetAttributes()) do
if not BerryArray or table.find(BerryArray, attr) then
_tp(bush.Parent:GetPivot())
for j = 1, #n do
local bush2 = n[j]
for _, v in pairs(bush2:GetChildren()) do
if not BerryArray or table.find(BerryArray, v) then
_tp(v.WorldPivot)
fireproximityprompt(v.ProximityPrompt, math.huge)
end
end
end
end
end
end
end
end
end)
spawn(function()
while wait(Sec) do
if _G.AutoFarmChest or _G.AutoFarmChestBypass then
pcall(function()
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local pos = char:GetPivot().Position
local Chests = CollectionService:GetTagged("_ChestTagged")
local minDist = math.huge
local nearestChest = nil
for _, chest in pairs(Chests) do
local dist = (chest:GetPivot().Position - pos).Magnitude
if not SelectedIsland or chest:IsDescendantOf(SelectedIsland) then
if not chest:GetAttribute("IsDisabled") and dist < minDist then
minDist = dist
nearestChest = chest
end
end
end
if nearestChest then
if _G.AutoFarmChestBypass then
char:PivotTo(nearestChest:GetPivot())
else
_tp(nearestChest:GetPivot())
end
end
end)
end
end
end)
Farm:AddToggle({
Title = "Stop Collect Item",
Description = "",
Default = GetSetting("StopCollectItem_Save", false),
Callback = function(I)
_G.StopCollectItem = I
_G.SaveData["StopCollectItem_Save"] = I
SaveSettings()
end,
})
spawn(function()
while wait(.2) do
pcall(function()
if (GetBP("God's Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness")) then
if _G.StopWhenChalice and _G.FarmEliteHunt then
_G.FarmEliteHunt = false
end
if _G.StopCollectItem then
_G.AutoFarmChest = false
_G.AutoBerry = false
_G.AutoFarmChestBypass = false
end
end
end)
end
end)
local plr = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local WS = game:GetService("Workspace")
_G.AutoBoss = false       
_G.FarmAllBoss = false    
_G.AutoAcceptQuest = false 
_G.CurrentTargetBoss = nil 
_G.FindBoss = nil
local function EquipWeapon()
    local char = plr.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")  
    if not hum then return end  
    if _G.SelectWeapon then  
        local tool = plr.Backpack:FindFirstChild(_G.SelectWeapon) or char:FindFirstChild(_G.SelectWeapon)  
        if tool and tool.Parent ~= char then  
            hum:EquipTool(tool)  
        end  
    end
end
local function GoToBoss(targetBoss)
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not targetBoss or not hrp or not hum then return end
    local bossHRP = targetBoss:FindFirstChild("HumanoidRootPart") or targetBoss:FindFirstChild("Torso")
    if not bossHRP then return end
    local safeHeight = 22   
    local targetPos = bossHRP.Position + Vector3.new(0, safeHeight, 0)  
    local targetCFrame = CFrame.new(targetPos)  
    local distToSafeSpot = (hrp.Position - targetPos).Magnitude  
    EquipWeapon()  
    if distToSafeSpot <= 5 then  
        hrp.CFrame = targetCFrame  
        hrp.Velocity = Vector3.zero  
        hrp.AssemblyLinearVelocity = Vector3.zero 
        hum.AutoRotate = false 
    else  
        if _tp then _tp(targetCFrame) else hrp.CFrame = targetCFrame end
    end
end
Farm:AddSection("Boss Farm")
Farm:AddButton({
    Title = "Update Boss List",
    Callback = RefreshBossList
})
local BossDropdown = Farm:AddDropdown({
    "Select Boss",
    {"None"},
    "None",
    function(v)
        _G.FindBoss = v
    end
})
local function RefreshBossList()
    local LiveBosses = {}  
    local FoundAny = false  
    for _, obj in pairs(WS:GetDescendants()) do
        if obj:IsA("Model") and obj:GetAttribute("IsBoss") == true then
            if not table.find(LiveBosses, obj.Name) then
                table.insert(LiveBosses, obj.Name)
                FoundAny = true
            end
        end
    end
    for _, obj in pairs(RS:GetDescendants()) do
        if obj:IsA("Model") and obj:GetAttribute("IsBoss") == true then
            if not table.find(LiveBosses, obj.Name) then
                table.insert(LiveBosses, obj.Name)
                FoundAny = true
            end
        end
    end
    if FoundAny then 
        table.sort(LiveBosses)
        BossDropdown.Refresh(LiveBosses, LiveBosses[1])
        _G.FindBoss = LiveBosses[1]
    else 
        BossDropdown.Refresh({"None"}, "None")
    end  
end
Farm:AddToggle({
    Title = "Auto Farm Boss",
    Default = false,
    Callback = function(v)
        _G.AutoBoss = v
        if v then _G.FarmAllBoss = false end
    end
})
Farm:AddToggle({
    Title = "Take Quest Boss",
    Default = false,
    Callback = function(v)
        _G.AutoAcceptQuest = v
    end
})
Farm:AddToggle({
    Title = "Farm All Bosses",
    Default = false,
    Callback = function(v)
        _G.FarmAllBoss = v
        if v then _G.AutoBoss = false end
        _G.CurrentTargetBoss = nil
    end
})
task.spawn(function()
    task.wait(1)
    RefreshBossList()
end)
spawn(function()
    while task.wait() do 
        if not _G.FarmAllBoss then
            task.wait(0.5)
            continue
        end
        if _G.CurrentTargetBoss and _G.CurrentTargetBoss.Parent and _G.CurrentTargetBoss:FindFirstChild("Humanoid") and _G.CurrentTargetBoss.Humanoid.Health > 0 then
            task.wait(0.2) 
            continue
        end
        local char = plr.Character
        local myHrp = char and char:FindFirstChild("HumanoidRootPart")
        if not myHrp then task.wait(0.5) continue end
        local potentialBosses = {}
        local foundInWorkspace = false
        local function FastScan(container, isRS)
            for _, v in pairs(container:GetDescendants()) do
                if v:IsA("Model") and v:GetAttribute("IsBoss") == true then
                    if v.Name ~= "Cursed Skeleton Boss" then
                        local h = v:FindFirstChild("Humanoid")
                        local hrp = v:FindFirstChild("HumanoidRootPart") or v:FindFirstChild("Torso")
                        if h and h.Health > 0 and hrp then
                            local dist = (myHrp.Position - hrp.Position).Magnitude
                            if isRS then
                                table.insert(potentialBosses, {Model = v, Distance = dist + 10000})
                            else
                                table.insert(potentialBosses, {Model = v, Distance = dist})
                                foundInWorkspace = true
                            end
                        end
                    end
                end
            end
        end
        FastScan(WS, false)
        if not foundInWorkspace then FastScan(RS, true) end
        if #potentialBosses > 0 then
            table.sort(potentialBosses, function(a, b) return a.Distance < b.Distance end)
            _G.CurrentTargetBoss = potentialBosses[1].Model
        else
            _G.CurrentTargetBoss = nil
        end
        task.wait(0.2)
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.AutoBoss and _G.FindBoss then
                if QuestB then QuestB() end
                local NeedQuest = false
                local char = plr.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end
                if _G.AutoAcceptQuest and Qname and Qdata and PosQBoss then
                    local playerGui = plr.PlayerGui:FindFirstChild("Main") and plr.PlayerGui.Main:FindFirstChild("Quest")
                    local hasQuest = playerGui and playerGui.Visible
                    if not hasQuest then NeedQuest = true end
                end
                if NeedQuest then
                    if (PosQBoss.Position - char.HumanoidRootPart.Position).Magnitude <= 5 then
                        RS.Remotes.CommF_:InvokeServer("StartQuest", Qname, Qdata)
                    else
                        if _tp then _tp(PosQBoss) else char.HumanoidRootPart.CFrame = PosQBoss end
                    end
                    return
                end
                local specificBoss = WS:FindFirstChild("Enemies") and WS.Enemies:FindFirstChild(_G.FindBoss) or WS:FindFirstChild(_G.FindBoss)
                if specificBoss and specificBoss:FindFirstChild("Humanoid") and specificBoss.Humanoid.Health > 0 then 
                    GoToBoss(specificBoss)
                elseif PosB then 
                    if _tp then _tp(PosB) else char.HumanoidRootPart.CFrame = PosB end
                end
            elseif _G.FarmAllBoss then
                if _G.CurrentTargetBoss then
                    GoToBoss(_G.CurrentTargetBoss)
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait(0.5) do
        if plr.Backpack and _G.ChooseWP then
            for _, e in pairs(plr.Backpack:GetChildren()) do
                if e.ToolTip == _G.ChooseWP then _G.SelectWeapon = e.Name end
            end
        end
    end
end)
do
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local VIM = game:GetService("VirtualInputManager")
    local UserInputService = game:GetService("UserInputService")
    local player = Players.LocalPlayer
    local PredictionEnabled = true
    local PredictionAmount = 0.1
    local maxRange = 1000
    local currentTool = nil
    local PlayersPosition = nil
    local characterConnections = {}
    local screenCenter = nil
    _G.SelectIsland = _G.SelectIsland or "Bone"
    _G.MasteryMode = "Fruit"
    _G.AutoFarmMastery = false
    _G.MasteryHealthPercent = 70
    _G.FruitSkills = {Z = false, X = false, C = false, V = false, F = false}
    task.spawn(function()
        while not screenCenter do
            task.wait()
            local cam = workspace.CurrentCamera
            if cam then screenCenter = cam.ViewportSize / 2 end
        end
    end)
    local function getClosestPlayer(lpHRP)
        local closest, dist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                if hum and hum.Health > 0 and hrp then
                    local d = (hrp.Position - lpHRP.Position).Magnitude
                    if d < dist and d <= maxRange then
                        dist = d
                        closest = plr
                    end
                end
            end
        end
        return closest
    end
    local function getPredictedPosition(hrp)
        if not hrp then return nil end
        local hum = hrp.Parent:FindFirstChildWhichIsA("Humanoid")
        if not hum or not PredictionEnabled or hum.WalkSpeed < 5 then
            return hrp.Position
        end
        return hrp.Position + (hrp.Velocity * PredictionAmount)
    end
    local function isSkillReadyForTool(toolName)
        if not toolName then return false end
        local gui = player:FindFirstChild("PlayerGui")
        local skills = gui and gui:FindFirstChild("Main") and gui.Main:FindFirstChild("Skills")
        local tool = skills and skills:FindFirstChild(toolName)
        if not tool then return false end
        for _, key in ipairs({"Z","X","C","V"}) do
            local skill = tool:FindFirstChild(key)
            if skill and skill:FindFirstChild("Cooldown") and skill.Cooldown.Size.X.Scale == 1 then
                return true
            end
        end
        return false
    end
    local function ResetGunCooldown(tool)
        pcall(function()
            local cd = tool:FindFirstChild("Cooldown")
            if cd then cd.Value = 0 end
            local holding = tool:FindFirstChild("Holding")
            if holding then holding.Value = true end
            tool:SetAttribute("Overheat", 0)
            tool:SetAttribute("LocalOverheat", 0)
        end)
    end
    local function StopAnimations()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local animator = hum and hum:FindFirstChildOfClass("Animator")
        if not animator then return end
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local name = (track.Name or ""):lower()
            if name:find("shoot") or name:find("gun") or name:find("fire") or name:find("attack") then
                pcall(function() track:Stop(0) end)
            end
        end
    end
    local function GetNearestMobFromList(list)
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return nil end
        local percent = (_G.MasteryHealthPercent or 70) / 100
        local lowTarget, lowDist = nil, math.huge
        local normalTarget, normalDist = nil, math.huge
        for _, mob in pairs(workspace.Enemies:GetChildren()) do
            if table.find(list, mob.Name)
                and mob:FindFirstChild("HumanoidRootPart")
                and mob:FindFirstChild("Humanoid")
                and mob.Humanoid.Health > 0 then
                local d = (mob.HumanoidRootPart.Position - root.Position).Magnitude
                if mob.Humanoid.Health <= (mob.Humanoid.MaxHealth * percent) then
                    if d < lowDist then
                        lowDist = d
                        lowTarget = mob
                    end
                else
                    if d < normalDist then
                        normalDist = d
                        normalTarget = mob
                    end
                end
            end
        end
        return lowTarget or normalTarget
    end
    RunService.RenderStepped:Connect(function()
        if not SilentAim_Enabled and not _G.LockMob and not _G.AutoFarmMastery then
            PlayersPosition = nil
            return
        end
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local target
        if (_G.LockMob or _G.AutoFarmMastery) and _G.CurrentMob
            and _G.CurrentMob:FindFirstChild("HumanoidRootPart")
            and _G.CurrentMob:FindFirstChild("Humanoid")
            and _G.CurrentMob.Humanoid.Health > 0 then
            target = _G.CurrentMob
        elseif SilentAim_Enabled then
            if _G.TargetMode == "Selected Player" then
                target = Players:FindFirstChild(_G.PlayersList)
            else
                target = getClosestPlayer(hrp)
            end
        end
        if target then
            local thrp = target:FindFirstChild("HumanoidRootPart") or (target.Character and target.Character:FindFirstChild("HumanoidRootPart"))
            if thrp then
                PlayersPosition = getPredictedPosition(thrp)
                if currentTool and isSkillReadyForTool(currentTool.Name) then
                    local look = (Vector3.new(PlayersPosition.X, hrp.Position.Y, PlayersPosition.Z) - hrp.Position).Unit
                    hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + look)
                end
            else
                PlayersPosition = nil
            end
        else
            PlayersPosition = nil
        end
        if _G.AutoFarmMastery then
            pcall(function()
                for _, e in pairs(player.PlayerGui.Notifications:GetChildren()) do
                    if e.Name == "NotificationTemplate" and string.find(e.Text, "Skill locked!") then
                        e:Destroy()
                    end
                end
            end)
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool and tool.Name == "Dragonstorm" and _G.MasteryMode == "Gun" then
                UserInputService.MouseIconEnabled = true
            else
                UserInputService.MouseIconEnabled = false
            end
        else
            UserInputService.MouseIconEnabled = true
        end
    end)
    player.CharacterAdded:Connect(function(char)
        for _, c in ipairs(characterConnections) do
            pcall(function() c:Disconnect() end)
        end
        characterConnections = {}
        table.insert(characterConnections, char.ChildAdded:Connect(function(obj)
            if obj:IsA("Tool") then
                currentTool = obj
            end
        end))
        table.insert(characterConnections, char.ChildRemoved:Connect(function(obj)
            if obj == currentTool then
                currentTool = nil
            end
        end))
    end)
    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if (method == "FireServer" or method == "InvokeServer")
                and (_G.LockMob or SilentAim_Enabled or _G.AutoFarmMastery)
                and PlayersPosition
                and typeof(args[1]) == "Vector3" then
                args[1] = PlayersPosition
                return old(self, unpack(args))
            end
            return old(self, ...)
        end)
        setreadonly(mt, true)
    end)
    task.spawn(function()
        while task.wait() do
            pcall(function()
                if _G.AimCam or _G.LockMob or _G.AutoFarmMastery then
                    local cam = workspace.CurrentCamera
                    local targetPlr
                    if (_G.LockMob or _G.AutoFarmMastery) and _G.CurrentMob
                        and _G.CurrentMob:FindFirstChild("HumanoidRootPart")
                        and _G.CurrentMob:FindFirstChild("Humanoid")
                        and _G.CurrentMob.Humanoid.Health > 0 then
                        targetPlr = _G.CurrentMob
                    elseif _G.AimCam then
                        if _G.TargetMode == "Selected Player" then
                            targetPlr = Players:FindFirstChild(_G.PlayersList)
                        else
                            local lpHRP = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                            if lpHRP then
                                targetPlr = getClosestPlayer(lpHRP)
                            end
                        end
                    end
                    if targetPlr then
                        local thrp = targetPlr:FindFirstChild("HumanoidRootPart") or (targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart"))
                        if thrp then
                            cam.CFrame = CFrame.new(cam.CFrame.Position, thrp.Position)
                        end
                    end
                end
            end)
        end
    end)
    task.spawn(function()
        while task.wait() do
            if _G.AutoFarmMastery then
                pcall(function()
                    local list = (_G.SelectIsland == "Cake" and X or P)
                    local mob = GetNearestMobFromList(list)
                    if mob then
                        _G.CurrentMob = mob
                        local percent = (_G.MasteryHealthPercent or 70) / 100
                        HealthM = mob.Humanoid.MaxHealth * percent
                        MousePos = mob.HumanoidRootPart.Position
                        if _G.MasteryMode == "Fruit" then
                            G.Mas(mob, _G.AutoFarmMastery)
                        elseif _G.MasteryMode == "Gun" then
                            G.Masgun(mob, _G.AutoFarmMastery)
                            local modules = ReplicatedStorage:FindFirstChild("Modules")
                            local K = modules:FindFirstChild("Net")
                            local shoot = K:FindFirstChild("RE/ShootGunEvent")
                            local tool = player.Character:FindFirstChildOfClass("Tool")
                            if tool then
                                if tool.Name == "Dragonstorm" then
                                    ResetGunCooldown(tool)
                                    StopAnimations()
                                    if screenCenter then
                                        VIM:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, true, game, 0)
                                        VIM:SendMouseButtonEvent(screenCenter.X, screenCenter.Y, 0, false, game, 0)
                                    end
                                    if shoot then
                                        shoot:FireServer(MousePos, { mob.HumanoidRootPart })
                                    end
                                elseif tool.Name == "Skull Guitar" then
                                    tool.RemoteEvent:FireServer("TAP", MousePos)
                                else
                                    if shoot then
                                        shoot:FireServer(MousePos, { mob.HumanoidRootPart })
                                    end
                                end
                            end
                        end
                    else
                        _G.CurrentMob = nil
                        if _G.SelectIsland == "Cake" then
                            _tp(CFrame.new(-1943.6765, 251.5095, -12337.8808))
                        else
                            _tp(CFrame.new(-9495.6806, 453.5862, 5977.3486))
                        end
                    end
                end)
            else
                _G.CurrentMob = nil
            end
        end
    end)
    Farm:AddSection("Mastery")
    Farm:AddDropdown({
        Title = "Select Island",
        Options = {"Cake", "Bone"},
        Default = _G.SelectIsland or "Bone",
        Callback = function(I)
            _G.SelectIsland = I
        end
    })
    Farm:AddDropdown({
        Title = "Mastery Mode",
        Options = {"Fruit", "Gun"},
        Default = "Fruit",
        Callback = function(v)
            _G.MasteryMode = v
        end
    })
    Farm:AddToggle({
        Title = "Auto Farm Mastery",
        Default = false,
        Callback = function(I)
            _G.AutoFarmMastery = I
        end
    })
    Farm:AddToggle({
        Title = "Lock Cam On Mob",
        Default = false,
        Callback = function(I)
            _G.LockMob = I
        end
    })
    Farm:AddDropdown({
        Title = "Select Skills",
        Options = {"Z", "X", "C", "V", "F"},
        Default = {},
        MultiSelect = true,
        Callback = function(Table)
            _G.FruitSkills = {Z = false, X = false, C = false, V = false, F = false}
            for i, v in pairs(Table) do
                if type(i) == "string" then
                    if v == true then _G.FruitSkills[i] = true end
                else
                    _G.FruitSkills[v] = true
                end
            end
        end
    })
    Farm:AddSlider({
        Title = "Skill Usage HP (%)",
        Min = 10,
        Max = 100,
        Default = 70,
        Increment = 1,
        Callback = function(Value)
            _G.MasteryHealthPercent = Value
        end
    })
end
Farm:AddSection("Material")
Farm:AddDropdown({
	Title = "Material List",
	Description = "",
	Options = MaterialList,
	Default = GetSetting("SelectMaterial_Save", nil),
	Multi = false,
	Callback = function(I)
		(getgenv()).SelectMaterial = I
        _G.SaveData["SelectMaterial_Save"] = I
        SaveSettings()
	end,
})
Farm:AddToggle({
	Title = "Auto Farm Material",
	Description = "",
	Default = GetSetting("AutoMaterial_Save", false),
	Callback = function(I)
		(getgenv()).AutoMaterial = I
        _G.SaveData["AutoMaterial_Save"] = I
        SaveSettings()
	end,
})
spawn(function()
	local function I(I, e)
		if I:FindFirstChild("Humanoid") and (I:FindFirstChild("HumanoidRootPart") and I.Humanoid.Health > 0) then
			if I.Name == e then
				repeat
					wait();
					G.Kill(I, (getgenv()).AutoMaterial);
				until not (getgenv()).AutoMaterial or not I.Parent or I.Humanoid.Health <= 0;
			end;
		end;
	end;
	local function e()
		for I, e in pairs((game:GetService("Workspace"))._WorldOrigin.EnemySpawns:GetChildren()) do
			for I, K in ipairs(MMon) do
				if string.find(e.Name, K) then
					if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - e.Position).Magnitude >= 10 then
						_tp(e.CFrame * Pos);
					end;
				end;
			end;
		end;
	end;
	while wait() do
		if (getgenv()).AutoMaterial then
			pcall(function()
				if (getgenv()).SelectMaterial then
					MaterialMon((getgenv()).SelectMaterial);
					_tp(MPos);
				end;
				for e, K in ipairs(MMon) do
					for e, n in pairs(workspace.Enemies:GetChildren()) do
						I(n, K);
					end;
				end;
				e();
			end);
		end;
	end;
end);
Setting:AddSection("Server")
local JobIdInput = ""
Setting:AddTextBox({
    Title = "Enter JobId",
    Placeholder = "Paste server JobId here...",
    Callback = function(text)
        JobIdInput = text
    end
})
Setting:AddButton({
    Title = "Join Server",
    Callback = function()
        if JobIdInput ~= "" then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, JobIdInput, game.Players.LocalPlayer)
        end
    end
})
Setting:AddButton({
    Title = "Copy Current JobId",
    Callback = function()
        setclipboard(game.JobId)
    end
})
Setting:AddSection("Setting")
Setting:AddToggle({
    Title = "Auto Attack",
    Description = "",
    Default = GetSetting("OtherAutoAttack_Save", true),
    Callback = function(state)
        _G.OtherAutoAttack = state
        _G.SaveData["OtherAutoAttack_Save"] = state
        SaveSettings()
    end
})
local v1 = next
local v2 = {
    game.ReplicatedStorage.Util,
    game.ReplicatedStorage.Common,
    game.ReplicatedStorage.Remotes,
    game.ReplicatedStorage.Assets,
    game.ReplicatedStorage.FX,
}
local v3 = nil
local u4 = nil
local u5 = nil
task.spawn(function()
    while true do
        local v6
        v3, v6 = v1(v2, v3)
        if v3 == nil then break end
        local v7 = next
        local v8, v9 = v6:GetChildren()
        while true do
            local v10
            v9, v10 = v7(v8, v9)
            if v9 == nil then break end
            if v10:IsA('RemoteEvent') and v10:GetAttribute('Id') then
                u5 = v10:GetAttribute('Id')
                u4 = v10
            end
        end
        v6.ChildAdded:Connect(function(p11)
            if p11:IsA('RemoteEvent') and p11:GetAttribute('Id') then
                u5 = p11:GetAttribute('Id')
                u4 = p11
            end
        end)
    end
end)
task.spawn(function()
    local cloneref = cloneref or function(o) return o end
    while true do
        if not _G.OtherAutoAttack then
            task.wait(1)
        else
            task.wait(0.01)
            pcall(function()
                local _Character = game.Players.LocalPlayer.Character
                local v13 = _Character and _Character:FindFirstChild('HumanoidRootPart')
                if v13 then
                    local v14, v15, v16 = ipairs({workspace.Enemies, workspace.Characters})
                    local u17 = {}
                    while true do
                        local v18
                        v16, v18 = v14(v15, v16)
                        if v16 == nil then break end
                        local v19, v20, v21 = ipairs(v18 and v18:GetChildren() or {})
                        while true do
                            local v22
                            v21, v22 = v19(v20, v21)
                            if v21 == nil then break end
                            local _HumanoidRootPart = v22:FindFirstChild('HumanoidRootPart')
                            local _Humanoid = v22:FindFirstChild('Humanoid')
                            if v22 ~= _Character and _HumanoidRootPart and _Humanoid and _Humanoid.Health > 0 then
                                if (_HumanoidRootPart.Position - v13.Position).Magnitude <= 60 then
                                    local v25, v26, v27 = ipairs(v22:GetChildren())
                                    while true do
                                        local v28
                                        v27, v28 = v25(v26, v27)
                                        if v27 == nil then break end
                                        if v28:IsA('BasePart') then
                                            u17[#u17 + 1] = {v22, v28}
                                        end
                                    end
                                end
                            end
                        end
                    end
                    local _Tool = _Character:FindFirstChildOfClass('Tool')
                    if #u17 > 0 and _Tool and (_Tool:GetAttribute('WeaponType') == 'Melee' or _Tool:GetAttribute('WeaponType') == 'Sword') then
                        require(game.ReplicatedStorage.Modules.Net):RemoteEvent('RegisterHit', true)
                        game.ReplicatedStorage.Modules.Net['RE/RegisterAttack']:FireServer()
                        local _Head = u17[1][1]:FindFirstChild('Head')
                        if _Head and u4 and u5 then
                            game.ReplicatedStorage.Modules.Net['RE/RegisterHit']:FireServer(
                                _Head, 
                                u17, 
                                {}, 
                                tostring(game.Players.LocalPlayer.UserId):sub(2, 4) .. tostring(coroutine.running()):sub(11, 15)
                            )
                            cloneref(u4):FireServer(
                                string.gsub('RE/RegisterHit', '.', function(p31)
                                    return string.char(bit32.bxor(string.byte(p31), math.floor(workspace:GetServerTimeNow() / 10 % 10) + 1))
                                end), 
                                bit32.bxor(u5 + 909090, game.ReplicatedStorage.Modules.Net.seed:InvokeServer() * 2), 
                                _Head, 
                                u17
                            )
                        end
                    end
                end
            end)
        end
    end
end)
Setting:AddToggle({
	Title = "Fruit Attack",
	Description = "",
	Default = GetSetting("AutoAttack_Save", false),
	Callback = function(I)
		_G.Seriality = I
        _G.SaveData["AutoAttack_Save"] = I
        SaveSettings()
	end,
})
Setting:AddToggle({
	Title = "Bring Mobs",
	Description = "",
	Default = GetSetting("BringMobs_Save", true),
	Callback = function(I)
		_B = I
        _G.SaveData["BringMobs_Save"] = I
        SaveSettings()
	end,
})
Setting:AddSection("Select Settings")
getgenv().FarmDistance = 25
getgenv().BringRange = 300
getgenv().TweenSpeedFar = 325
Setting:AddSlider({
    Title = "Farm Distance",
    Min = 5,
    Max = 50,
    Default = getgenv().FarmDistance,
    Increment = 1,
    Callback = function(value)
        getgenv().FarmDistance = value
    end
})
Setting:AddSlider({
    Title = "Bring Mobs Range",
    Min = 50,
    Max = 500,
    Default = getgenv().BringRange,
    Increment = 5,
    Callback = function(num)
        getgenv().BringRange = num
    end
})
Setting:AddSlider({
    Title = "Tween Speed",
    Min = 50,
    Max = 600,
    Default = getgenv().TweenSpeedFar,
    Increment = 10,
    Callback = function(I)
        getgenv().TweenSpeedFar = tonumber(I)
    end
})
Setting:AddSection("Active")
Setting:AddToggle({
    Title = "Auto Active Ken",
    Default = GetSetting("AutoKen_Save", false),
    Callback = function(v)
        _G.AutoKen = v
        _G.SaveData["AutoKen_Save"] = v
        SaveSettings()
    end
})
local player = Players.LocalPlayer
local commE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")
local function HasKen()
    local char = player.Character
    if not char then return false end
    return CollectionService:HasTag(char, "Ken")
end
task.spawn(function()
    while task.wait(0.2) do
        if _G.AutoKen and HasKen() then
            pcall(function()
                commE:FireServer("Ken", true)
            end)
        end
    end
end)
Setting:AddToggle({
	Title = "Auto Active Haki",
	Description = "",
	Default = GetSetting("AutoHaki_Save", true),
	Callback = function(I)
		Boud = I
        _G.SaveData["AutoHaki_Save"] = I
        SaveSettings()
	end,
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if Boud then
				local I = { "HasBuso", "Buso" };
				if not plr.Character:FindFirstChild(I[1]) then
					replicated.Remotes.CommF_:InvokeServer(I[2]);
				end;
			end;
		end);
	end;
end);
Setting:AddSection("Race")
Setting:AddToggle({
	Title = "Auto Active V3",
	Description = "",
	Default = GetSetting("AutoActiveV3_Save", false),
	Callback = function(I)
		_G.RaceClickAutov3 = I
        _G.SaveData["AutoActiveV3_Save"] = I
        SaveSettings()
	end,
})
Setting:AddToggle({
	Title = "Auto Active V4",
	Description = "",
	Default = GetSetting("AutoActiveV4_Save", false),
	Callback = function(I)
		_G.RaceClickAutov4 = I
        _G.SaveData["AutoActiveV4_Save"] = I
        SaveSettings()
	end,
})
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.RaceClickAutov3 then
				repeat
					replicated.Remotes.CommE:FireServer("ActivateAbility");
					wait(30);
				until not _G.RaceClickAutov3;
			end;
		end);
	end;
end);
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.RaceClickAutov4 then
				if plr.Character:FindFirstChild("RaceEnergy") then
					if (plr.Character:FindFirstChild("RaceEnergy")).Value == 1 then
						Useskills("nil", "Y");
					end;
				end;
			end;
		end);
	end;
end);
_G.AutoTyrant = false
_G.AutoFarm_Cake = false
_G.StartFarm = false
_G.AcceptQuest = false
_G.UseSkullSummon = false
local TELEPORT_DISTANCE_THRESHOLD = 15
local function TeleportConditional(hrp, targetCFrame, threshold)
    if not hrp or not targetCFrame then return end
    local dist = (targetCFrame.Position - hrp.Position).Magnitude  
    if dist > threshold then  
        _tp(targetCFrame)  
    end
end
local function GetTargetByLevel()
    local myLevel = game.Players.LocalPlayer.Data.Level.Value
    if myLevel >= 2575 then
        return {
            Name = "Skull Slayer",
            QuestArgs = {"StartQuest", "TikiQuest3", 2},
            QuestPos = CFrame.new(-16665.0879, 105.27478, 1577.61743, -0.999621451, 3.5280582e-08, 0.0275127869, 3.5990368e-08, 1, 2.53032191e-08, -0.0275127869, 2.62838356e-08, -0.999621451),
            FarmPos = CFrame.new(-16709.49, 419.68, 1751.09)
        }
    elseif myLevel > 2550 then
        return {
            Name = "Serpent Hunter",
            QuestArgs = {"StartQuest", "TikiQuest3", 1},
            QuestPos = CFrame.new(-16665.0879, 105.27478, 1577.61743, -0.999621451, 3.5280582e-08, 0.0275127869, 3.5990368e-08, 1, 2.53032191e-08, -0.0275127869, 2.62838356e-08, -0.999621451),
            FarmPos = CFrame.new(-16645.64, 163.09, 1352.87)
        }
    elseif myLevel >= 2525 then
        return {
            Name = "Isle Champion",
            QuestArgs = {"StartQuest", "TikiQuest2", 2},
            QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-08, 0.998227954, -5.3272025e-08, 1, -2.77677703e-08, -0.998227954, -5.48299717e-08, -0.0595058464),
            FarmPos = CFrame.new(-16602.1015625, 130.38734436035, 1087.2456054688)
        }
    elseif myLevel >= 2500 then
        return {
            Name = "Sun-kissed Warrior",
            QuestArgs = {"StartQuest", "TikiQuest2", 1},
            QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-08, 0.998227954, -5.3272025e-08, 1, -2.77677703e-08, -0.998227954, -5.48299717e-08, -0.0595058464),
            FarmPos = CFrame.new(-16347, 64, 984)
        }
    elseif myLevel >= 2475 then
        return {
            Name = "Island Boy",
            QuestArgs = {"StartQuest", "TikiQuest1", 2},
            QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-08, 0.998227954, -5.3272025e-08, 1, -2.77677703e-08, -0.998227954, -5.48299717e-08, -0.0595058464),
            FarmPos = CFrame.new(-16670, 43, -270)
        }
    else
        return {
            Name = "Isle Outlaw",
            QuestArgs = {"StartQuest", "TikiQuest1", 1},
            QuestPos = CFrame.new(-16546.748, 55.7216759, -172.865311, -0.0595058464, 2.45485676e-08, 0.998227954, -5.3272025e-08, 1, -2.77677703e-08, -0.998227954, -5.48299717e-08, -0.0595058464),
            FarmPos = CFrame.new(-16350, 45, -180)
        }
    end
end
local function GetEyesCount()
    local model = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("TikiOutpost") and workspace.Map.TikiOutpost:FindFirstChild("IslandModel")
    local count = 0
    if model then
        local eye1 = model:FindFirstChild("Eye1")
        local eye2 = model:FindFirstChild("Eye2")
        local chunks = model:FindFirstChild("IslandChunks")
        local eye3 = chunks and chunks:FindFirstChild("E") and chunks.E:FindFirstChild("Eye3")
        local eye4 = chunks and chunks:FindFirstChild("E") and chunks.E:FindFirstChild("Eye4")
        if eye1 and eye1.Transparency == 0 then count = count + 1 end
        if eye2 and eye2.Transparency == 0 then count = count + 1 end
        if eye3 and eye3.Transparency == 0 then count = count + 1 end
        if eye4 and eye4.Transparency == 0 then count = count + 1 end
    end
    return count
end
local function UseAllCategorySkills()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    local VirtualUser = game:GetService("VirtualUser")
    local categories = {"Melee", "Blox Fruit", "Sword", "Gun"}
    local skills = {"Z", "X", "C"}
    pcall(function()  
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "RightControl", false, game)  
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + Vector3.new(0,-1,0))  
    end)  
    for _, toolType in ipairs(categories) do  
        local tool = nil  
        for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
            if v:IsA("Tool") and v.ToolTip == toolType then tool = v break end  
        end  
        if not tool then  
            local charTool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")  
            if charTool and charTool.ToolTip == toolType then tool = charTool end  
        end  
        if tool then  
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)  
            task.wait(0.1)  
            for i = 1, 3 do  
                VirtualUser:CaptureController()  
                VirtualUser:ClickButton1(Vector2.new(851, 158))  
                local skillKey = skills[i]  
                if skillKey then  
                    VirtualInputManager:SendKeyEvent(true, skillKey, false, game)  
                    task.wait(0.05)  
                    VirtualInputManager:SendKeyEvent(false, skillKey, false, game)  
                end  
                task.wait(0.1)   
            end  
        end  
    end
end
Others:AddSection("Raid Bosses");
if World3 then 
Others:AddToggle({
	Title = "Auto Elite Hunter Quest",
	Description = "Take quest elite hunter and farm",
	Default = GetSetting("AutoEliteQuest_Save", false),
	Callback = function(I)
		_G.FarmEliteHunt = I
        _G.SaveData["AutoEliteQuest_Save"] = I
        SaveSettings()
	end,
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.FarmEliteHunt then
				if plr.PlayerGui.Main.Quest.Visible == true then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Diablo") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Urban") or string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Deandre") then
						for I, e in pairs(replicated:GetChildren()) do
							if string.find(e.Name, "Diablo") or string.find(e.Name, "Urban") or string.find(e.Name, "Deandre") then
								_tp(e.HumanoidRootPart.CFrame);
							end;
						end;
						for I, e in pairs(Enemies:GetChildren()) do
							if (string.find(e.Name, "Diablo") or string.find(e.Name, "Urban") or string.find(e.Name, "Deandre")) and G.Alive(e) then
								repeat
									wait();
									G.Kill(e, _G.FarmEliteHunt);
								until not _G.FarmEliteHunt or plr.PlayerGui.Main.Quest.Visible == false or not e.Parent or e.Humanoid.Health <= 0;
							end;
						end;
					end;
				else
					replicated.Remotes.CommF_:InvokeServer("EliteHunter");
				end;
			end;
		end);
	end;
end);
Others:AddToggle({
    Title = "Auto Farm Rip Indra",
    Description = "Auto farm raid boss rip indra",
    Default = GetSetting("AutoRipIndra_Save", false),
    Callback = function(I)
        _G.AutoRipIndra = I
        _G.SaveData["AutoRipIndra_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
    while task.wait() do
        pcall(function()
            if not _G.AutoRipIndra then return end
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Workspace = game:GetService("Workspace")
            local Plr = Players.LocalPlayer
            local Char = Plr.Character or Plr.CharacterAdded:Wait()
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if not Root then return end
            local Boss = nil
            if Workspace:FindFirstChild("Enemies") then
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v.Name == "rip_indra" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        Boss = v
                        break
                    end
                end
            end
            if not Boss then
                if ReplicatedStorage:FindFirstChild("rip_indra True Form") then
                    for _, v in pairs(Workspace:GetChildren()) do
                        if v.Name == "rip_indra" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            Boss = v
                            break
                        end
                    end
                end
            end
            if Boss and Boss:FindFirstChild("HumanoidRootPart") then
                repeat
                    task.wait()
                    if _tp then
                        _tp(Boss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
                    else
                        Root.CFrame = Boss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
                    end
                    if G and G.Kill then
                        G.Kill(Boss, true)
                    end
                until not _G.AutoRipIndra 
                or not Boss.Parent 
                or Boss.Humanoid.Health <= 0 
                or not Root.Parent
            end
        end)
    end
end)
Others:AddToggle({
    Title = "Auto Farm Tyrant of the Skies",
    Description = "Automatically farm Tiki mobs to summon and kill the Tyrant boss",
    Default = false,
    Callback = function(v)
        _G.AutoTyrant = v
        _G.StartFarm = v
    end
})
Others:AddToggle({
    Title = "Auto Farm Cake Prince",
    Description = "Automatically kill mobs to open the portal and farm Cake Prince / Dough King",
    Default = false,
    Callback = function(v)
        _G.AutoFarm_Cake = v
        _G.StartFarm = v
    end
})
spawn(function()
    local VaseIndex = 1 
    while task.wait() do
        pcall(function()
            if not _G.AutoTyrant or not _G.StartFarm then return end
            local Plr = game.Players.LocalPlayer
            local Char = Plr.Character or Plr.CharacterAdded:Wait()
            local Root = Char:FindFirstChild("HumanoidRootPart")
            local Hum = Char:FindFirstChild("Humanoid")
            if not Root or not Hum or Hum.Health <= 0 then return end
            local boss = workspace.Enemies:FindFirstChild("Tyrant of the Skies")
            local eyes = GetEyesCount()
            if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and boss:FindFirstChild("HumanoidRootPart") then
                repeat
                    task.wait()
                    if G and G.Kill then
                        G.Kill(boss, _G.AutoTyrant)
                    end
                until not _G.StartFarm 
                or not _G.AutoTyrant 
                or not boss.Parent 
                or (boss:FindFirstChild("Humanoid") and boss.Humanoid.Health <= 0) 
                or not Root.Parent 
                or (Hum and Hum.Health <= 0)
            elseif eyes == 4 then
                local targetsty = {  
                    CFrame.new(-16335.1, 158.1, 1465.6), CFrame.new(-16288.6, 158.1, 1470.3),  
                    CFrame.new(-16258.0, 156.7, 1461.4), CFrame.new(-16212.4, 158.1, 1466.3),  
                    CFrame.new(-16335.0, 159.3, 1324.8), CFrame.new(-16286.0, 155.9, 1323.8),  
                    CFrame.new(-16250.3, 159.3, 1316.3)  
                }  
                local pos = targetsty[VaseIndex]  
                if pos then  
                    if (Root.Position - pos.Position).Magnitude < 10 then  
                        Root.CFrame = pos
                        if _G.UseSkullSummon then
                            local guitar = Char:FindFirstChild("Skull Guitar")
                            if not guitar then
                                guitar = Plr.Backpack:FindFirstChild("Skull Guitar")
                                if guitar then Hum:EquipTool(guitar) else game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", "Skull Guitar") end
                            end
                            if guitar and guitar.Parent == Char and guitar:FindFirstChild("RemoteEvent") then
                                guitar.RemoteEvent:FireServer("TAP", pos.Position)
                                game:GetService("ReplicatedStorage").Remotes.Validator2:FireServer(8359618, 0)
                            end
                        else
                            UseAllCategorySkills()  
                        end
                        VaseIndex = VaseIndex + 1  
                        if VaseIndex > #targetsty then VaseIndex = 1 end  
                    else
                        if _tp then _tp(pos) end
                    end  
                end  
            else
                local TargetData = GetTargetByLevel()   
                local QuestUI = Plr.PlayerGui.Main.Quest  
                if _G.AcceptQuest and not QuestUI.Visible then  
                    if (Root.Position - TargetData.QuestPos.Position).Magnitude <= 5 then  
                        Root.CFrame = TargetData.QuestPos  
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(TargetData.QuestArgs))  
                        task.wait(0.3)  
                    else
                        if _tp then _tp(TargetData.QuestPos) end 
                    end  
                else  
                    local ClosestEnemy = nil  
                    local ShortestDistance = math.huge   
                    local AllMobs = {"Skull Slayer", "Serpent Hunter", "Isle Champion", "Sun-kissed Warrior", "Island Boy", "Isle Outlaw"}  
                    if workspace:FindFirstChild("Enemies") then
                        for _, e in pairs(workspace.Enemies:GetChildren()) do  
                            if table.find(AllMobs, e.Name) and e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 and e:FindFirstChild("HumanoidRootPart") then  
                                local dist = (Root.Position - e.HumanoidRootPart.Position).Magnitude  
                                if dist < ShortestDistance then ShortestDistance = dist ClosestEnemy = e end  
                            end  
                        end  
                    end
                    if ClosestEnemy then  
                        repeat
                            task.wait()
                            if G and G.Kill then G.Kill(ClosestEnemy, _G.AutoTyrant) end
                        until not _G.StartFarm or not _G.AutoTyrant or not ClosestEnemy.Parent or (ClosestEnemy:FindFirstChild("Humanoid") and ClosestEnemy.Humanoid.Health <= 0) or not Root.Parent or (Hum and Hum.Health <= 0)
                    else  
                        if _tp then _tp(TargetData.FarmPos) end
                    end  
                end  
            end  
        end)
    end
end)
local lastAirCFrame = nil
spawn(function()
    while task.wait() do
        if _G.AutoFarm_Cake and _G.StartFarm then
            pcall(function()
                local plr = game.Players.LocalPlayer
                local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local enemies = workspace:FindFirstChild("Enemies")
                if not enemies then return end
                local CakePos = CFrame.new(-2091.91, 70.00, -12142.83)
                local PortalEntrance = CFrame.new(-2151.82, 149.32, -12404.91)
                local mirror = workspace.Map:FindFirstChild("CakeLoaf")
                mirror = mirror and mirror:FindFirstChild("BigMirror")
                local other = mirror and mirror:FindFirstChild("Other")
                local portalOpen = other and other.Transparency == 0
                local boss = enemies:FindFirstChild("Cake Prince") or enemies:FindFirstChild("Dough King")
                if not boss and not portalOpen and (hrp.Position - CakePos.Position).Magnitude > 3000 then
                    _tp(CakePos)
                    return
                end
                if boss or portalOpen then
                    lastAirCFrame = nil
                    if boss and boss:FindFirstChild("Humanoid") and boss.Humanoid.Health > 0 and boss.PrimaryPart then
                        local bossPos = boss.PrimaryPart.CFrame * CFrame.new(0, 25, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                        _tp(bossPos)
                        G.Kill(boss, _G.AutoFarm_Cake)
                        return
                    end
                    if (hrp.Position - PortalEntrance.Position).Magnitude < 500 then
                        TeleportConditional(hrp, PortalEntrance, TELEPORT_DISTANCE_THRESHOLD)
                    end
                    return
                end
                local CAKE_MOBS = {"Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"}
                if _G.AcceptQuest and not plr.PlayerGui.Main.Quest.Visible then
                    lastAirCFrame = nil
                    local questPos = CFrame.new(-1927.92, 37.80, -12842.54)
                    TeleportConditional(hrp, questPos, TELEPORT_DISTANCE_THRESHOLD)
                    if (hrp.Position - questPos.Position).Magnitude <= 40 then
                        local q = {{"StartQuest", "CakeQuest2", 2}, {"StartQuest", "CakeQuest2", 1}, {"StartQuest", "CakeQuest1", 1}, {"StartQuest", "CakeQuest1", 2}}
                        game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(q[math.random(1, 4)]))
                    end
                    return
                end
                local bestMob, bestDist = nil, math.huge
                for _, mob in ipairs(enemies:GetChildren()) do
                    if table.find(CAKE_MOBS, mob.Name) and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 and mob:FindFirstChild("HumanoidRootPart") then
                        local dist = (mob.HumanoidRootPart.Position - hrp.Position).Magnitude
                        if dist < bestDist then bestDist = dist bestMob = mob end
                    end
                end
                if bestMob then
                    repeat
                        task.wait()
                        if (workspace.Map.CakeLoaf.BigMirror.Other.Transparency == 0) or enemies:FindFirstChild("Cake Prince") then break end
                        if bestMob.Parent and bestMob.Humanoid.Health > 0 then
                            local mobHRP = bestMob.HumanoidRootPart
                            local targetCFrame = mobHRP.CFrame * CFrame.new(0, 20, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            if lastAirCFrame then targetCFrame = CFrame.new(targetCFrame.Position.X, lastAirCFrame.Position.Y, targetCFrame.Position.Z) * CFrame.Angles(math.rad(-90), 0, 0) end
                            _tp(targetCFrame)
                            hrp.Velocity = Vector3.zero
                            hrp.AssemblyLinearVelocity = Vector3.zero
                            if not lastAirCFrame or targetCFrame.Position.Y > lastAirCFrame.Position.Y then lastAirCFrame = targetCFrame end
                            G.Kill(bestMob, _G.AutoFarm_Cake)
                        else break end
                    until not _G.StartFarm or not _G.AutoFarm_Cake or not bestMob.Parent or bestMob.Humanoid.Health <= 0
                else
                    lastAirCFrame = nil
                    TeleportConditional(hrp, CFrame.new(-1927.92, 37.80, -12842.54), TELEPORT_DISTANCE_THRESHOLD)
                end
            end)
        end
    end
end)
end 
if World3 then 
Others:AddSection("Quests Settings");
Others:AddToggle({
    Title = "Stop when got God Chalice",
    Description = "",
    Default = GetSetting("StopChalice_Save", true),
    Callback = function(I)
        _G.StopWhenChalice = I
        _G.SaveData["StopChalice_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(.2) do
		if _G.StopWhenChalice and _G.FarmEliteHunt then
			pcall(function()
				if GetBP("God\'s Chalice") or GetBP("Sweet Chalice") or GetBP("Fist of Darkness") then
					_G.FarmEliteHunt = false;
				end;
			end);
		end;
	end;
end);
Others:AddToggle({
    Title = "Auto Active Colors Rip Indra",
    Description = "Activate colors rip indra",
    Default = GetSetting("AutoActiveCores_Save", false),
    Callback = function(I)
        _G.AutoUnHaki = I
        _G.SaveData["AutoActiveCores_Save"] = I
        SaveSettings()
    end,
})
AuraSkin = function(I)
		local e = { [1] = { StorageName = I, Type = "AuraSkin", Context = "Equip" } };
		(((replicated:WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/FruitCustomizerRF")):InvokeServer(unpack(e));
	end;
VaildColor = function(I)
		if I and I.BrickColor then
			return tostring(I.BrickColor) == "Lime green";
		end;
	end;
HakiCalculate = function(I)
		local e = { ["Really red"] = "Pure Red", Oyster = "Snow White", ["Hot pink"] = "Winter Sky" };
		if I and I.BrickColor then
			return e[tostring(I.BrickColor)];
		end;
	end;
spawn(function()
	while wait(Sec) do
		if _G.AutoUnHaki then
			pcall(function()
				local I = workspace.Map["Boat Castle"]:FindFirstChild("Summoner");
				if I and I:FindFirstChild("Circle") then
					for I, e in pairs((I:FindFirstChild("Circle")):GetChildren()) do
						if e.Name == "Part" then
							local I = e:FindFirstChild("Part");
							if VaildColor(I) == false then
								AuraSkin(HakiCalculate(e));
								repeat
									wait();
									_tp(e.CFrame);
								until VaildColor(I) == true or not _G.AutoUnHaki;
							end;
						end;
					end;
				end;
			end);
		end;
	end;
end);
end
Others:AddSection("Cursed Swords");
local verificado = false
local lastNotify = 0
Others:AddToggle({
    Title = "Auto Yama Sword",
    Description = "Automatically completes Yama quest and obtains the sword",
    Default = GetSetting("AutoYama_Save", false),
    Callback = function(Value)
        _G.AutoYama = Value
        _G.SaveData["AutoYama_Save"] = Value
        if Value then
            verificado = false
        end
        SaveSettings()
    end,
})
local ItemConfig = require(game:GetService("ReplicatedStorage").ItemConfig)
local function temYama()
    local encontrou = false
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Tiles") then
            local tiles = v.Tiles
            if type(tiles) == "table" then
                for _, tile in pairs(tiles) do
                    if type(tile) == "table" and tile.ItemId then
                        local config = ItemConfig.tryGet(tile.ItemId)
                        if config and string.find(config.Index.DebugLabel, "Yama") then
                            encontrou = true
                            break
                        end
                    end
                end
            end
        end
        if encontrou then break end
    end
    return encontrou
end
spawn(function()
local lastP = 0
local prog = 0
while task.wait() do
pcall(function()
if not _G.AutoYama then return end
if not verificado then
    if temYama() then
        Library:Notify({
            Title = "Auto Yama",
            Content = "Done",
            Icon = "rbxassetid://10734975486",
            Time = 4
        })
        _G.AutoYama = false
        verificado = true
        return
    end
    verificado = true
end
local rs = game:GetService("ReplicatedStorage")
local ws = game:GetService("Workspace").Enemies
local vim = game:GetService("VirtualInputManager")
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
if tick() - lastP > 3 then
lastP = tick()
local progress = rs.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")
prog = tonumber(progress) or 0
end
if prog >= 30 then
_G.FarmEliteHunt = false
local targetCFrame = CFrame.new(
5248.48828, 16.9484062, 453.278839,
0.0454210564, -9.33278059e-08, -0.998967946,
-4.74314845e-08, 1, -9.61904192e-08,
0.998968005, 5.12186276e-08, 0.0454210676
)
local distance = (hrp.Position - targetCFrame.Position).Magnitude
if distance > 5 then
_tp(targetCFrame)
else
local katana = workspace.Map.Waterfall:FindFirstChild("SealedKatana")
if katana and katana:FindFirstChild("Hitbox") then
local hitbox = katana.Hitbox
hitbox.CFrame = hrp.CFrame
fireclickdetector(hitbox.ClickDetector)
vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
task.wait(0.05)
vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
end
end
else
_G.FarmEliteHunt = true
if not (rs:FindFirstChild("Diablo") or rs:FindFirstChild("Deandre") or rs:FindFirstChild("Urban") or ws:FindFirstChild("Diablo") or ws:FindFirstChild("Deandre") or ws:FindFirstChild("Urban")) then
    if tick() - lastNotify > 10 then
        lastNotify = tick()
        Library:Notify({
            Title = "Auto Yama",
            Content = "Waiting Elite Hunter...",
            Icon = "rbxassetid://10734975486",
            Time = 4
        })
    end
end
end
end)
end
end)
Others:AddSection("Draco");
Others:AddToggle({
    Title = "Auto Dragon Hunter",
    Description = "turn on for farm blaze ember And auto collect blaze ember",
    Default = false,
    Callback = function(I)
        _G.FarmBlazeEM = I;
        if I then
            getgenv().UsePortals = false
        end
    end,
});
checkQuesta = function()
    local I = { [1] = { Context = "Check" } };
    local e = nil;
    pcall(function()
        local I = { [1] = { Context = "RequestQuest" } };
        ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer(unpack(I));
    end);
    local K, n = pcall(function()
        e = ((((game:GetService("ReplicatedStorage")):WaitForChild("Modules")):WaitForChild("Net")):WaitForChild("RF/DragonHunter")):InvokeServer(unpack(I));
    end);
    local d = false;
    local z;
    local H;
    local F;
    if e then
        if e.Text then
            d = true;
            local I = e.Text;
            if string.find(tostring(I), "Defeat") then
                F = 1;
                z = string.sub(tostring(I), 8, 9);
                z = tonumber(z);
                local e = { "Hydra Enforcer", "Venomous Assailant" };
                for e, K in pairs(e) do
                    if string.find(I, K) then
                        H = K;
                        break;
                    end;
                end;
            elseif string.find(tostring(I), "Destroy") then
                z = 10;
                F = 2;
                H = nil;
            end;
        end;
    end;
    return d, H, z, F;
end;
BackTODoJo = function()
    for I, e in pairs((game:GetService("Players")).LocalPlayer.PlayerGui.Notifications:GetChildren()) do
        if e.Name == "NotificationTemplate" then
            if string.find(e.Text, "Head back to the Dojo to complete more tasks") then
                return true;
            end;
        end;
    end;
    return false;
end;
DragonMobClear = function(I, e, K)
    local target = nil
    for _, n in pairs(workspace.Enemies:GetChildren()) do
        if n.Name == e and G.Alive(n) then
            target = n
            break 
        end
    end
    if target then
        if I then
            G.Kill(target, I);
        end
    else
        _tp(K);
    end
end;
spawn(function()
    while wait() do
        if _G.FarmBlazeEM then
            pcall(function()
                local I, e, K, n = checkQuesta();
                if I == true and not BackTODoJo() then
                    if n == 1 then
                        if e == "Hydra Enforcer" or e == "Venomous Assailant" then
                            repeat
                                wait();
                                DragonMobClear(true, e, CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492));
                            until not _G.FarmBlazeEM or not I or BackTODoJo();
                        end;
                    elseif n == 2 then
                        local TreeCFrames = {
                            CFrame.new(5265.47314, 1004.37518, 352.914764),
                            CFrame.new(5256.42334, 1005.57532, 422.089752),
                            CFrame.new(5318.1333, 1004.37518, 439.733185),
                            CFrame.new(5343.82959, 1004.37518, 361.999359)
                        }
                        repeat
                            wait()
                            for _, cf in pairs(TreeCFrames) do
                                if not _G.FarmBlazeEM or not I or BackTODoJo() then break end
                                _tp(cf)
                                wait(0.3)
                                Useskills("Melee", "Z")
                                Useskills("Melee", "X")
                                Useskills("Melee", "C")
                                wait(0.3)
                                Useskills("Sword", "Z")
                                Useskills("Sword", "X")
                                wait(0.3)
                                Useskills("Blox Fruit", "Z")
                                Useskills("Blox Fruit", "X")
                                Useskills("Blox Fruit", "C")
                                wait(0.3)
                                Useskills("Gun", "Z")
                                Useskills("Gun", "X")
                                wait(0.5)
                            end
                        until not _G.FarmBlazeEM or not I or BackTODoJo()
                    end;
                else
                    _tp(CFrame.new(5813, 1208, 884));
                    DragonMobClear(false, nil, nil);
                end;
            end);
        end;
    end;
end);
spawn(function()
    while wait(.1) do
        if _G.FarmBlazeEM then
            pcall(function()
                if workspace.EmberTemplate:FindFirstChild("Part") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame;
                end;
            end);
        end;
    end;
end);
Others:AddSection("Sword");
local TargetMobs = {
	"Reborn Skeleton",
	"Living Zombie",
	"Demonic Soul",
	"Posessed Mummy"
}
local FarmPos = CFrame.new(
	-9513.63867, 164.010269, 5786.66895,
	-0.0950724334, 9.31791888e-08, 0.995470345,
	7.18874515e-09, 1, -9.29166148e-08,
	-0.995470345, -1.67762626e-09, -0.0950724334
)
local function GetClosestMob()
	local closestDist = math.huge
	local target = nil
	local hrp = game.Players.LocalPlayer.Character
		and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not hrp then return nil end
	local playerPos = hrp.Position
	for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		local isTarget = false
		for _, name in pairs(TargetMobs) do
			if v.Name == name then
				isTarget = true
				break
			end
		end
		if isTarget
			and v:FindFirstChild("Humanoid")
			and v.Humanoid.Health > 0
			and v:FindFirstChild("HumanoidRootPart") then
			local dist = (v.HumanoidRootPart.Position - playerPos).Magnitude
			if dist < closestDist then
				closestDist = dist
				target = v
			end
		end
	end
	return target
end
Others:AddToggle({
	Title = "Auto Farm All Swords To 600 Mastery",
	Description = "Automatically farm all swords until they reach 600 mastery",
	Default = false,
	Callback = function(I)
		_G.FarmMastery_S = I
	end,
})
spawn(function()
	while wait(0.1) do
		if _G.FarmMastery_S then
			pcall(function()
				local character = game.Players.LocalPlayer.Character
				if not character or not character:FindFirstChild("HumanoidRootPart") then return end
				local Target = GetClosestMob()
				if not Target then
					local distToArea = (character.HumanoidRootPart.Position - FarmPos.Position).Magnitude
					if distToArea > 150 then
						_tp(FarmPos)
						wait(0.5)
					end
				end
				for _, e in next, replicated.Remotes.CommF_:InvokeServer("getInventory") do
					if type(e) == "table" and e.Type == "Sword" then
						local SwordName = e.Name
						local Mastery = tonumber(e.Mastery) or 0
						if Mastery < 600 then
							if GetBP(SwordName) then
								if Target then
									repeat
										wait()
										if _G.FarmMastery_S
											and Target
											and Target:FindFirstChild("HumanoidRootPart")
											and Target.Humanoid.Health > 0 then
											G.Sword(Target, _G.FarmMastery_S)
										end
									until not _G.FarmMastery_S
										or not Target.Parent
										or Target.Humanoid.Health <= 0
								end
							else
								replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
							end
							break
						end
					end
				end
			end)
		end
	end
end)
Others:AddSection("Haki Observation")
 Others:AddToggle({
    Title = "Auto Farm Haki Observation",
    Description = "",
    Default = GetSetting("AutoObsFarm_Save", false),
    Callback = function(I)
        _G.obsFarm = I
        _G.SaveData["AutoObsFarm_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.obsFarm then
				replicated.Remotes.CommE:FireServer("Ken", true);
				if plr:GetAttribute("KenDodgesLeft") == 0 then
					KenTest = false;
				elseif plr:GetAttribute("KenDodgesLeft") > 0 then
					replicated.Remotes.CommE:FireServer("Ken", true);
					KenTest = true;
				end;
			end;
		end);
	end;
end);
spawn(function()
	while wait(.2) do
		pcall(function()
			if _G.obsFarm then
				if World1 then
					if workspace.Enemies:FindFirstChild("Galley Captain") then
						if KenTest then
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Galley Captain")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
							until _G.obsFarm == false or KenTest == false;
						else
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Galley Captain")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
							until _G.obsFarm == false or KenTest;
						end;
					else
						_tp(CFrame.new(5533.29785, 88.1079102, 4852.3916));
					end;
				elseif World2 then
					if workspace.Enemies:FindFirstChild("Lava Pirate") then
						if KenTest then
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0);
							until _G.obsFarm == false or KenTest == false;
						else
							repeat
								wait();
								plr.Character.HumanoidRootPart.CFrame = (workspace.Enemies:FindFirstChild("Lava Pirate")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0);
							until _G.obsFarm == false or KenTest;
						end;
					else
						_tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126));
					end;
				elseif World3 then
					if workspace.Enemies:FindFirstChild("Venomous Assailant") then
						if KenTest then
							repeat
								wait();
								_tp((workspace.Enemies:FindFirstChild("Venomous Assailant")).HumanoidRootPart.CFrame * CFrame.new(3, 0, 0));
							until _G.obsFarm == false or KenTest == false;
						else
							repeat
								wait();
								_tp((workspace.Enemies:FindFirstChild("Venomous Assailant")).HumanoidRootPart.CFrame * CFrame.new(0, 50, 0));
							until _G.obsFarm == false or KenTest;
						end;
					else
						_tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789));
					end;
				end;
			end;
		end);
	end;
end);
if World3 then
Others:AddToggle({
	Title = "Auto Haki Observation V2",
	Description = "",
	Default = GetSetting("AutoKenV2_Save", false),
	Callback = function(I)
		_G.AutoKenVTWO = I
        _G.SaveData["AutoKenV2_Save"] = I
        SaveSettings()
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.AutoKenVTWO then
			pcall(function()
				local I = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625);
				local e = "Kuy";
				local K = CFrame.new(-10920.125, 624.20275878906, -10266.995117188);
				local n = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625);
				local d = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875);
				if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
					local I = GetConnectionEnemies("Forest Pirate");
					if I then
						repeat
							wait();
							G.Kill(I, _G.AutoKenVTWO);
						until not _G.AutoKenVTWO or I.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
					else
						_tp(n);
					end;
				elseif plr.PlayerGui.Main.Quest.Visible == true then
					local I = GetConnectionEnemies("Captain Elephant");
					if I then
						repeat
							wait();
							G.Kill(I, _G.AutoKenVTWO);
						until not _G.AutoKenVTWO or I.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false;
					else
						_tp(d);
					end;
				elseif plr.PlayerGui.Main.Quest.Visible == false then
					replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
					wait(.1);
					replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1);
				end;
				if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
					_tp(CFrame.new(-12513.51953125, 340.11373901367, -9873.048828125));
				end;
				if not plr.Backpack:FindFirstChild("Fruit Bowl") or not plr.Character:FindFirstChild("Fruit Bowl") then
					if not GetBP("Fruit Bowl") then
						if not GetBP("Apple") then
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375));
							for I, e in pairs(workspace:GetDescendants()) do
								if e.Name == "Apple" then
									e.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
									wait();
									firetouchinterest(plr.Character.HumanoidRootPart, e.Handle, 0);
									wait();
								end;
							end;
						elseif not GetBP("Banana") then
							_tp(CFrame.new(2286.0078125, 73.133918762207, -7159.8090820312));
							for I, e in pairs(workspace:GetDescendants()) do
								if e.Name == "Banana" then
									e.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
									wait();
									firetouchinterest(plr.Character.HumanoidRootPart, e.Handle, 0);
									wait();
								end;
							end;
						elseif not GetBP("Pineapple") then
							_tp(CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625));
							for I, e in pairs(workspace:GetDescendants()) do
								if e.Name == "Pineapple" then
									e.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10);
									wait();
									firetouchinterest(plr.Character.HumanoidRootPart, e.Handle, 0);
									wait();
								end;
							end;
						end;
					end;
					if plr.Backpack:FindFirstChild("Banana") and (plr.Backpack:FindFirstChild("Apple") and plr.Backpack:FindFirstChild("Pineapple")) or plr:FindFirstChild("Banana") and (plr:FindFirstChild("Apple") and plr:FindFirstChild("Pineapple")) then
						repeat
							wait();
							_tp(I);
						until _G.AutoKenVTWO or plr.Character.HumanoidRootPart.CFrame == I;
						replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen");
					end;
					if plr.Backpack:FindFirstChild("Fruit Bowl") or plr.Character:FindFirstChild("Fruit Bowl") then
						if plr.Character.HumanoidRootPart.CFrame ~= K then
							_tp(K);
						elseif plr.Character.HumanoidRootPart.CFrame == K then
							replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Start");
							wait(.1);
							replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Buy");
						end;
					end;
				end;
			end);
		end;
	end;
end);
Others:AddToggle({
	Title = "Auto Citizen Quest",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.CitizenQuest = I
	end,
})
spawn(function()
	while task.wait(Sec or 1) do
		pcall(function()
			if _G.CitizenQuest then
				local progress = replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress")
				if Lv >= 1800 and progress and progress.KilledBandits == false then
					if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate")
					and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50")
					and plr.PlayerGui.Main.Quest.Visible == true then
						local I = GetConnectionEnemies("Forest Pirate")
						if I then
							repeat
								task.wait()
								G.Kill(I, _G.CitizenQuest)
							until _G.CitizenQuest == false
								or not I.Parent
								or I.Humanoid.Health <= 0
								or plr.PlayerGui.Main.Quest.Visible == false
						else
							_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
						end
					else
						_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
						if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125)
							- plr.Character.HumanoidRootPart.Position).Magnitude <= 30 then
							task.wait(1.5)
							replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
						end
					end
				elseif Lv >= 1800 and progress and progress.KilledBoss == false then
					local I = GetConnectionEnemies("Captain Elephant")
					if plr.PlayerGui.Main.Quest.Visible
					and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
						if I then
							repeat
								task.wait()
								G.Kill(I, _G.CitizenQuest)
							until _G.CitizenQuest == false
								or not I.Parent
								or I.Humanoid.Health <= 0
								or plr.PlayerGui.Main.Quest.Visible == false
						else
							_tp(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
						end
					else
						_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))
						if (plr.Character.HumanoidRootPart.Position
							- Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125)).Magnitude <= 4 then
							task.wait(1.5)
							replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
						end
					end
				elseif Lv >= 1800 and replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
					_tp(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
				end
			end
		end)
	end
end)
end
if World2 or World3 then
Others:AddSection("Aura Colours");
Others:AddButton({
    Title = "Buy Buso Colors",
    Description = "",
    Callback = function()
        replicated.Remotes.CommF_:InvokeServer("ColorsDealer", "2");
    end
});
 Others:AddToggle({
    Title = "Teleport Barista Haki",
    Description = "",
    Default = GetSetting("TpBarista_Save", false),
    Callback = function(I)
        _G.Tp_MasterA = I
        _G.SaveData["TpBarista_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
    while wait() do
        if _G.Tp_MasterA then
            pcall(function()
                for _, e in pairs(replicated.NPCs:GetChildren()) do
                    if e.Name == "Barista Cousin" then
                        _tp(e.HumanoidRootPart.CFrame);
                    end;
                end;
            end);
        end;
    end;
end);
end
if World3 then
 Others:AddToggle({
    Title = "Auto Rainbow Haki",
    Description = "",
    Default = GetSetting("AutoRainbowHaki_Save", false),
    Callback = function(I)
        _G.Auto_Rainbow_Haki = I
        _G.SaveData["AutoRainbowHaki_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
    pcall(function()
        while wait(Sec) do
            if _G.Auto_Rainbow_Haki then
                if plr.PlayerGui.Main.Quest.Visible == false then
                    if _G.GetQFast then
                        if plr.PlayerGui.Main.Quest.Visible == false then
                            replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet");
                        end;
                    else
                        Rainbow1 = CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875);
                        if plr.Character.HumanoidRootPart.CFrame ~= Rainbow1 then
                            _tp(Rainbow1);
                        elseif plr.Character.HumanoidRootPart.CFrame == Rainbow1 then
                            wait(1);
                            replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet");
                        end;
                    end;
                elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Stone") then
                    local I = GetConnectionEnemies("Stone");
                    if I then
                        repeat
                            wait();
                            G.Kill(I, _G.Auto_Rainbow_Haki);
                        until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
                    else
                        _tp(CFrame.new(-1086.11621, 38.8425903, 6768.71436, .0231462717, -0.592676699, .805107772, 2.03251839e-05, .805323839, .592835128, -0.999732077, -0.0137055516, .0186523199));
                    end;
                elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Hydra Leader") then
                    local I = GetConnectionEnemies("Hydra Leader");
                    if I then
                        repeat
                            task.wait();
                            G.Kill(I, _G.Auto_Rainbow_Haki);
                        until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
                    else
                        replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625));
                        local I = Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625);
                        local e = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
                        if plr.Character.HumanoidRootPart.CFrame.Position == I then
                            _tp(e);
                        end;
                    end;
                elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Kilo Admiral") then
                    local I = GetConnectionEnemies("Kilo Admiral");
                    if I then
                        repeat
                            task.wait();
                            G.Kill(I, _G.Auto_Rainbow_Haki);
                        until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
                    else
                        _tp(CFrame.new(2877.61743, 423.558685, -7207.31006, -0.989591599, 0, -0.143904909, 0, 1.00000012, 0, .143904924, 0, -0.989591479));
                    end;
                elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") then
                    local I = GetConnectionEnemies("Captain Elephant");
                    if I then
                        repeat
                            task.wait();
                            G.Kill(I, _G.Auto_Rainbow_Haki);
                        until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
                    else
                        local I = Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375);
                        local e = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125);
                        if plr.Character.HumanoidRootPart.CFrame.Position ~= I then
                            replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375));
                        elseif plr.Character.HumanoidRootPart.CFrame.Position == I then
                            _tp(e);
                        end;
                    end;
                elseif plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Beautiful Pirate") then
                    local I = GetConnectionEnemies("Captain Elephant");
                    if I then
                        repeat
                            task.wait();
                            G.Kill(I, _G.Auto_Rainbow_Haki);
                        until _G.Auto_Rainbow_Haki == false or I.Humanoid.Health <= 0 or not I.Parent or plr.PlayerGui.Main.Quest.Visible == false;
                    else
                        replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5314.5463867188, 22.562219619751, -127.06755065918));
                    end;
                end;
            end;
        end;
    end);
end);
end
if World3 then
Others:AddSection("Itens Sea 3");
Others:AddToggle({
 Title = "Auto Canvendish Sword",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.Auto_Cavender = I;
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Cavender then
				local I = GetConnectionEnemies("Beautiful Pirate");
				if I then
					repeat
						wait();
						G.Kill(I, _G.Auto_Cavender);
					until not _G.Auto_Cavender or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(5283.6094, 22.5622, -110.7829));
				end;
			end;
		end);
	end;
end);
Others:AddToggle({
 Title = "Auto Twin Hooks",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.TwinHook = I;
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.TwinHook then
				local I = GetConnectionEnemies("Captain Elephant");
				if I then
					repeat
						wait();
						G.Kill(I, _G.TwinHook);
					until not _G.TwinHook or I.Humanoid.Health <= 0;
				else
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.1699, 374.9402, -7551.6777));
					wait(.2);
					_tp(CFrame.new(-13376.7578, 433.2869, -8071.3926));
				end;
			end;
		end);
	end;
end);
Others:AddToggle({
 Title = "Auto Serpent Bow",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.AutoSerpentBow = I;
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.AutoSerpentBow then
			local I = GetConnectionEnemies("Hydra Leader");
			if I then
				repeat
					wait();
					G.Kill(I, _G.AutoSerpentBow);
				until not _G.AutoSerpentBow or not I.Parent or I.Humanoid.Health <= 0;
			else
				_tp(CFrame.new(5821.898, 1019.0951, -73.7192));
			end;
		end;
	end;
end);
Others:AddToggle({
 Title = "Auto Lei Accessory",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.AutoKilo = I;
	end,
});
spawn(function()
	while wait(.2) do
		if _G.AutoKilo then
			pcall(function()
				local I = GetConnectionEnemies("Kilo Admiral");
				if I then
					repeat
						task.wait();
						G.Kill(I, _G.AutoKilo);
					until not _G.AutoKilo or not I.Parent or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(2764.2234, 432.4615, -7144.458));
				end;
			end);
		end;
	end;
end);
end
Sea:AddSection("Sea Event")
local z5 = {
    "Guardian",
    "PirateGrandBrigade",
    "MarineGrandBrigade",
    "PirateBrigade",
    "MarineBrigade",
    "PirateSloop",
    "MarineSloop",
    "Beast Hunter",
}
Sea:AddDropdown({
    Title = "Select Boats",
    Options = z5,
    Default = "Guardian",
    Multi = false,
    Callback = function(I)
        _G.SelectedBoat = I
    end,
})
if World3 then
    local H5 = {"Lv 1","Lv 2","Lv 3","Lv 4","Lv 5","Lv 6","Lv Infinite"}
    Sea:AddDropdown({
        Title = "Select Level Sea",
        Options = H5,
        Default = "Lv 1",
        Multi = false,
        Callback = function(I)
            _G.DangerSc = I
        end,
    })
end
Sea:AddToggle({
    Title = "Auto Start farm",
    Default = false,
    Callback = function(I)
        _G.SailBoats = I
    end,
})
local function HasTarget()
    if _G.SeaBeast1 and workspace.SeaBeasts:FindFirstChild("SeaBeast1") then return true end
    if _G.Leviathan1 and workspace.SeaBeasts:FindFirstChild("Leviathan") then return true end
    for _, e in pairs(workspace.Enemies:GetChildren()) do
        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
            if (_G.Shark and e.Name == "Shark") or
               (_G.TerrorShark and e.Name == "Terrorshark") or
               (_G.Piranha and e.Name == "Piranha") or
               (_G.MobCrew and e.Name == "Fish Crew Member") or
               (_G.HCM and e.Name == "Haunted Crew Member") or
               (_G.FishBoat and e.Name == "FishBoat") or
               (_G.PGB and (e.Name == "PirateBrigade" or e.Name == "PirateGrandBrigade")) then
                return true
            end
        end
    end
    return false
end
spawn(function()
    while wait() do
        if _G.SailBoats then
            pcall(function()
                local I = CheckBoat()
                local plr = game.Players.LocalPlayer
                if not I then
                    local BoatDealerPos = CFrame.new(-16927.451, 9.086, 433.864)
                    TeleportToTarget(BoatDealerPos)
                    if (BoatDealerPos.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                        replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
                    end
                elseif I then
                    if HasTarget() then
                        if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Sit == true then
                            plr.Character.Humanoid.Sit = false
                            plr.Character.Humanoid.Jump = true
                        end
                    else
                        if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Sit == false then
                            _tp(I.VehicleSeat.CFrame * CFrame.new(0,2,0))
                        else
                            local CFrameSelectedZone =
                            _G.DangerSc == "Lv 1" and CFrame.new(-21998,30,-682) or
                            _G.DangerSc == "Lv 2" and CFrame.new(-26779,30,-822) or
                            _G.DangerSc == "Lv 3" and CFrame.new(-31171,30,-2256) or
                            _G.DangerSc == "Lv 4" and CFrame.new(-34054,30,-2560) or
                            _G.DangerSc == "Lv 5" and CFrame.new(-38887,30,-2162) or
                            _G.DangerSc == "Lv 6" and CFrame.new(-44541,30,-1244) or
                            CFrame.new(-10000000,31,37016)
                            repeat
                                wait()
                                if not HasTarget() then
                                    _tp(CFrameSelectedZone)
                                end
                            until not _G.SailBoats or plr.Character.Humanoid.Sit == false or HasTarget()
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while wait(Sec) do
        for _, boat in pairs(workspace.Boats:GetChildren()) do
            for _, v in pairs(boat:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = not (_G.SailBoats)
                end
            end
        end
    end
end)
_G.SetSpeedBoat = 300
Sea:AddToggle({
    Title = "Activate Boat Speed",
    Default = false,
    Callback = function(Value)
        _G.SpeedBoat = Value
    end
})
Sea:AddTextBox({
    Title = "Boat Speed Value",
    Default = "300",
    Callback = function(Value)
        local num = tonumber(Value)
        if num then _G.SetSpeedBoat = num end
    end
})
task.spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.SpeedBoat then
            local plr = game.Players.LocalPlayer
            if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Sit then
                for _, boat in pairs(workspace.Boats:GetChildren()) do
                    local seat = boat:FindFirstChildWhichIsA("VehicleSeat")
                    if seat then
                        seat.MaxSpeed = _G.SetSpeedBoat
                        seat.Torque = 0.2
                        seat.TurnSpeed = 5
                    end
                end
            end
        end
    end)
end)
Sea:AddSection("Select")
Sea:AddDropdown({
    Title = "Select Sea Enemies",
    Options = {
        "Sea Beast",
        "Pirate GrandBrigade",
        "Shark",
        "Piranha",
        "Terror Shark",
        "Fish Crew Member",
        "Haunted Crew Member",
        "Fish Boat"
    },
    Default = {},
    MultiSelect = true,
    Callback = function(Table)
        _G.SeaEnemies = {}
        for _, enemy in pairs({
            "Sea Beast",
            "Pirate GrandBrigade",
            "Shark",
            "Piranha",
            "Terror Shark",
            "Fish Crew Member",
            "Haunted Crew Member",
            "Fish Boat"
        }) do
            _G.SeaEnemies[enemy] = Table[enemy] or false
        end
        _G.SeaBeast1 = _G.SeaEnemies["Sea Beast"]
        _G.PGB = _G.SeaEnemies["Pirate GrandBrigade"]
        _G.Shark = _G.SeaEnemies["Shark"]
        _G.Piranha = _G.SeaEnemies["Piranha"]
        _G.TerrorShark = _G.SeaEnemies["Terror Shark"]
        _G.MobCrew = _G.SeaEnemies["Fish Crew Member"]
        _G.HCM = _G.SeaEnemies["Haunted Crew Member"]
        _G.FishBoat = _G.SeaEnemies["Fish Boat"]
    end,
})
Sea:AddDropdown({
    Title = "Select Melee Skills",
    Options = {"Z","X","C"},
    Default = {},
    MultiSelect = true,
    Callback = function(Table)
        _G.SelectedSkills["Melee"] = {}
        for _, skill in pairs({"Z","X","C"}) do
            _G.SelectedSkills["Melee"][skill] = Table[skill] or false
        end
        _G.SaveData["Skill_Melee_Z"] = _G.SelectedSkills["Melee"]["Z"]
        _G.SaveData["Skill_Melee_X"] = _G.SelectedSkills["Melee"]["X"]
        _G.SaveData["Skill_Melee_C"] = _G.SelectedSkills["Melee"]["C"]
        SaveSettings()
    end,
})
Sea:AddDropdown({
    Title = "Select Sword Skills",
    Options = {"Z","X"},
    Default = {},
    MultiSelect = true,
    Callback = function(Table)
        _G.SelectedSkills["Sword"] = {}
        for _, skill in pairs({"Z","X"}) do
            _G.SelectedSkills["Sword"][skill] = Table[skill] or false
        end
        _G.SaveData["Skill_Sword_Z"] = _G.SelectedSkills["Sword"]["Z"]
        _G.SaveData["Skill_Sword_X"] = _G.SelectedSkills["Sword"]["X"]
        SaveSettings()
    end,
})
Sea:AddDropdown({
    Title = "Select Gun Skills",
    Options = {"Z","X"},
    Default = {},
    MultiSelect = true,
    Callback = function(Table)
        _G.SelectedSkills["Gun"] = {}
        for _, skill in pairs({"Z","X"}) do
            _G.SelectedSkills["Gun"][skill] = Table[skill] or false
        end
        _G.SaveData["Skill_Gun_Z"] = _G.SelectedSkills["Gun"]["Z"]
        _G.SaveData["Skill_Gun_X"] = _G.SelectedSkills["Gun"]["X"]
        SaveSettings()
    end,
})
Sea:AddDropdown({
    Title = "Select Fruit Skills",
    Options = {"Z","X","C","V","F"},
    Default = {},
    MultiSelect = true,
    Callback = function(Table)
        _G.SelectedSkills["Blox Fruit"] = {}
        for _, skill in pairs({"Z","X","C","V","F"}) do
            _G.SelectedSkills["Blox Fruit"][skill] = Table[skill] or false
        end
        _G.SaveData["Skill_Fruit_Z"] = _G.SelectedSkills["Blox Fruit"]["Z"]
        _G.SaveData["Skill_Fruit_X"] = _G.SelectedSkills["Blox Fruit"]["X"]
        _G.SaveData["Skill_Fruit_C"] = _G.SelectedSkills["Blox Fruit"]["C"]
        _G.SaveData["Skill_Fruit_V"] = _G.SelectedSkills["Blox Fruit"]["V"]
        _G.SaveData["Skill_Fruit_F"] = _G.SelectedSkills["Blox Fruit"]["F"]
        SaveSettings()
    end,
})
_G.SelectedSkills = {
    ["Melee"] = {["Z"] = true, ["X"] = true, ["C"] = true},
    ["Sword"] = {["Z"] = true, ["X"] = true},
    ["Blox Fruit"] = {["Z"] = true, ["X"] = true, ["C"] = true, ["V"] = true, ["F"] = true},
    ["Gun"] = {["Z"] = true, ["X"] = true}
}
local function ExecuteSkills(category)
    if _G.SelectedSkills[category] then
        weaponSc(category) 
        task.wait(0.2) 
        local keys = {"Z", "X", "C", "V", "F"}
        for _, skill in ipairs(keys) do
            if _G.SelectedSkills[category][skill] then
                Useskills(category, skill)
                task.wait(0.35) 
            end
        end
    end
end
task.spawn(function()
    while task.wait() do
        pcall(function()
            local plr = game.Players.LocalPlayer
            local seaEnemies = {
                {Flag = _G.Shark, Name = "Shark", Check = CheckShark, KillType = "Normal"},
                {Flag = _G.TerrorShark, Name = "Terrorshark", Check = CheckTerrorShark, KillType = "Sea"},
                {Flag = _G.Piranha, Name = "Piranha", Check = CheckPiranha, KillType = "Normal"},
                {Flag = _G.MobCrew, Name = "Fish Crew Member", Check = CheckFishCrew, KillType = "Normal"},
                {Flag = _G.HCM, Name = "Haunted Crew Member", Check = CheckHauntedCrew, KillType = "Normal"}
            }
            for _, enemyData in ipairs(seaEnemies) do
                if enemyData.Flag and enemyData.Check() then
                    for _, K in pairs(workspace.Enemies:GetChildren()) do
                        if K.Name == enemyData.Name and G.Alive(K) then
                            repeat
                                task.wait()
                                if enemyData.KillType == "Sea" then
                                    G.KillSea(K, enemyData.Flag)
                                else
                                    G.Kill(K, enemyData.Flag)
                                end
                            until not enemyData.Flag or not K.Parent or K.Humanoid.Health <= 0
                        end
                    end
                end
            end
            if _G.SeaBeast1 and workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
                for _, e in pairs(workspace.SeaBeasts:GetChildren()) do
                    if e:FindFirstChild("HumanoidRootPart") and (e:FindFirstChild("Health") and e.Health.Value > 0) then
                        repeat
                            task.wait()
                            task.spawn(function()
                                if plr.Character and plr.Character:FindFirstChild("Humanoid") and not plr.Character.Humanoid.Sit then
                                    _tp(CFrame.new(e.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, e.HumanoidRootPart.Position.Z))
                                end
                            end)
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (plr.Character.HumanoidRootPart.Position - e.HumanoidRootPart.Position).Magnitude <= 500 then
                                MousePos = e.HumanoidRootPart.Position
                                if CheckF() then
                                    ExecuteSkills("Blox Fruit")
                                else
                                    ExecuteSkills("Melee")
                                    ExecuteSkills("Sword")
                                    ExecuteSkills("Blox Fruit")
                                    ExecuteSkills("Gun")
                                end
                            end
                        until not _G.SeaBeast1 or not e.Parent or e.Health.Value <= 0
                    end
                end
            end
            if _G.Leviathan1 and workspace.SeaBeasts:FindFirstChild("Leviathan") then
                for _, e in pairs(workspace.SeaBeasts:GetChildren()) do
                    local segment = e:FindFirstChild("Leviathan Segment")
                    if e:FindFirstChild("HumanoidRootPart") and segment and (e:FindFirstChild("Health") and e.Health.Value > 0) then
                        repeat
                            task.wait()
                            task.spawn(function()
                                if plr.Character and plr.Character:FindFirstChild("Humanoid") and not plr.Character.Humanoid.Sit then
                                    _tp(CFrame.new(e.HumanoidRootPart.Position.X, workspace.Map["WaterBase-Plane"].Position.Y + 200, e.HumanoidRootPart.Position.Z))
                                end
                            end)
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and (plr.Character.HumanoidRootPart.Position - e.HumanoidRootPart.Position).Magnitude <= 500 then
                                MousePos = segment.Position
                                if CheckF() then
                                    ExecuteSkills("Blox Fruit")
                                else
                                    ExecuteSkills("Melee")
                                    ExecuteSkills("Sword")
                                    ExecuteSkills("Blox Fruit")
                                    ExecuteSkills("Gun")
                                end
                            end
                        until not _G.Leviathan1 or not e.Parent or e.Health.Value <= 0
                    end
                end
            end
            local boatConfigs = {
                {Flag = _G.FishBoat, Check = CheckEnemiesBoat, Name = "FishBoat", Dist = 150, Offset = CFrame.new(0, -50, -25)},
                {Flag = _G.PGB, Check = CheckPirateGrandBrigade, Name = "PirateBrigade", Dist = 150, Offset = CFrame.new(0, -30, -10)},
                {Flag = _G.PGB, Check = CheckPirateGrandBrigade, Name = "PirateGrandBrigade", Dist = 150, Offset = CFrame.new(0, -50, -50)}
            }
            for _, boat in ipairs(boatConfigs) do
                if boat.Flag and boat.Check() then
                    for _, e in pairs(workspace.Enemies:GetChildren()) do
                        if e.Name == boat.Name and e:FindFirstChild("VehicleSeat") and e.Health.Value > 0 then
                            repeat
                                task.wait()
                                task.spawn(function()
                                    if plr.Character and plr.Character:FindFirstChild("Humanoid") and not plr.Character.Humanoid.Sit then
                                        _tp(e.Engine.CFrame * boat.Offset)
                                    end
                                end)
                                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and e:FindFirstChild("Engine") and (plr.Character.HumanoidRootPart.Position - e.Engine.Position).Magnitude <= boat.Dist then
                                    MousePos = e.Engine.Position
                                    if CheckF() then
                                        ExecuteSkills("Blox Fruit")
                                    else
                                        ExecuteSkills("Melee")
                                        ExecuteSkills("Sword")
                                        ExecuteSkills("Blox Fruit")
                                        ExecuteSkills("Gun")
                                    end
                                end
                            until not boat.Flag or not e:FindFirstChild("VehicleSeat") or e.Health.Value <= 0
                        end
                    end
                end
            end
        end)
    end
end)
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local FishReplicated = RS:WaitForChild("FishReplicated")
local FishingRequest = FishReplicated:WaitForChild("FishingRequest")
local FishingClientConfig = require(FishReplicated:WaitForChild("FishingClient"):WaitForChild("Config"))
local GetWaterHeight = require(RS:WaitForChild("Util"):WaitForChild("GetWaterHeightAtLocation"))
local Net = RS:WaitForChild("Modules"):WaitForChild("Net")
local CraftRemote = Net:WaitForChild("RF/Craft")
local JobsRemote = Net:WaitForChild("RF/JobsRemoteFunction")
local ToolAbilities = Net:WaitForChild("RF/JobToolAbilities")
_G.SelectedRod = "Fishing Rod"
_G.SelectedBait = "Basic Bait"
_G.AutoBuyBait = false
_G.AutoFishing = false
_G.AutoFishingQuest = false
_G.AutoQuestComplete = false
_G.AutoSellFish = false
_G.AutoSkillZ = false
Fish:AddSection("Select Bait And Rod")
Fish:AddDropdown({
    Title = "Select Fishing Rod",
    Description = "",
    Options = {
        "Fishing Rod",
        "Gold Rod",
        "Shark Rod",
        "Shell Rod",
        "Treasure Rod"
    },
    Default = GetSetting("Fish_SelectedRod", "Fishing Rod"), 
    Callback = function(Value)
        _G.SelectedRod = Value
        _G.SaveData["Fish_SelectedRod"] = Value
        SaveSettings()
    end
})
Fish:AddDropdown({
    Title = "Select Bait",
    Description = "",
    Options = {
        "Basic Bait",
        "Kelp Bait",
        "Good Bait",
        "Abyssal Bait",
        "Frozen Bait",
        "Epic Bait",
        "Carnivore Bait"
    },
    Default = GetSetting("Fish_SelectedBait", "Basic Bait"),
    Callback = function(Value)
        _G.SelectedBait = Value
        _G.SaveData["Fish_SelectedBait"] = Value
        SaveSettings()
        if _G.AutoBuyBait then
            pcall(function()
                CraftRemote:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})
Fish:AddSection("Fishing")
Fish:AddToggle({
    Title = "Auto Buy Bait",
    Description = "Automatically crafts the selected bait",
    Default = GetSetting("Fish_AutoBuyBait", false),
    Callback = function(Value)
        _G.AutoBuyBait = Value
        _G.SaveData["Fish_AutoBuyBait"] = Value
        SaveSettings()
        if Value then
            pcall(function()
                CraftRemote:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
})
task.spawn(function()
    while task.wait(2) do
        if _G.AutoBuyBait and _G.SelectedBait then
            pcall(function()
                CraftRemote:InvokeServer("Craft", _G.SelectedBait, {})
            end)
        end
    end
end)
Fish:AddToggle({
    Title = "Auto Fishing",
    Description = "Automatically casts and reels the fishing rod",
    Default = GetSetting("Fish_AutoFishing", false),
    Callback = function(Value)
        _G.AutoFishing = Value
        _G.SaveData["Fish_AutoFishing"] = Value
        SaveSettings()
    end
})
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoFishing then
            pcall(function()
                local plr = Players.LocalPlayer
                local char = plr.Character or plr.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local equippedTool = char:FindFirstChildOfClass("Tool")
                if _G.SelectedRod and (not equippedTool or equippedTool.Name ~= _G.SelectedRod) then
                    local rodInBag = plr.Backpack:FindFirstChild(_G.SelectedRod)
                    if rodInBag then
                        char.Humanoid:EquipTool(rodInBag)
                        equippedTool = rodInBag
                    else
                        return 
                    end
                end
                if equippedTool then
                    local maxLaunch = FishingClientConfig.Rod.MaxLaunchDistance
                    local waterHeight = GetWaterHeight(hrp.Position)
                    local rayOrigin = char.Head.Position
                    local rayDirection = hrp.CFrame.LookVector * maxLaunch
                    local ignoreList = {char, Workspace.Characters, Workspace.Enemies}
                    local _, hitPos = Workspace:FindPartOnRayWithIgnoreList(Ray.new(rayOrigin, rayDirection), ignoreList)
                    local targetPos = hitPos and Vector3.new(hitPos.X, math.max(hitPos.Y, waterHeight), hitPos.Z)
                    local state = equippedTool:GetAttribute("State")
                    local serverState = equippedTool:GetAttribute("ServerState")
                    if targetPos and (state == "ReeledIn" or serverState == "ReeledIn") then
                        FishingRequest:InvokeServer("StartCasting")
                        task.wait()
                        FishingRequest:InvokeServer("CastLineAtLocation", targetPos, 100, true)
                    elseif serverState == "Biting" then
                        FishingRequest:InvokeServer("Catching", true)
                        task.wait(0.1)
                        FishingRequest:InvokeServer("Catch", 1)
                    end
                end
            end)
        end
    end
end)
Fish:AddSection("Quests Fish")
Fish:AddToggle({
    Title = "Auto Quest Fishing",
    Description = "Automatically picks up quests from the Angler NPC",
    Default = GetSetting("Fish_AutoQuest", false),
    Callback = function(Value)
        _G.AutoFishingQuest = Value
        _G.SaveData["Fish_AutoQuest"] = Value
        SaveSettings()
    end
})
local function HasQuest()
    local playerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local questGui = playerGui:FindFirstChild("Quest") or playerGui:FindFirstChild("QuestGui")
        if questGui and questGui:FindFirstChild("Container") and questGui.Container:FindFirstChild("QuestTitle") then
            return true
        end
    end
    return false
end
task.spawn(function()
    while task.wait(1) do
        if _G.AutoFishingQuest then
            pcall(function()
                if not HasQuest() then
                    JobsRemote:InvokeServer("FishingNPC", "Angler", "AskQuest")
                end
            end)
        end
    end
end)
Fish:AddToggle({
    Title = "Auto Complete Quest",
    Description = "Automatically turns in completed quests",
    Default = GetSetting("Fish_AutoComplete", false),
    Callback = function(Value)
        _G.AutoQuestComplete = Value
        _G.SaveData["Fish_AutoComplete"] = Value
        SaveSettings()
        if Value then
            pcall(function()
                JobsRemote:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
})
task.spawn(function()
    while task.wait(5) do
        if _G.AutoQuestComplete then
            pcall(function()
                JobsRemote:InvokeServer("FishingNPC", "FinishQuest")
            end)
        end
    end
end)
Fish:AddSection("Misc Fish")
Fish:AddToggle({
    Title = "Auto Sell Fish",
    Description = "Automatically sells caught fish",
    Default = GetSetting("Fish_AutoSell", false),
    Callback = function(Value)
        _G.AutoSellFish = Value
        _G.SaveData["Fish_AutoSell"] = Value
        SaveSettings()
        if Value then
            pcall(function()
                JobsRemote:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
})
task.spawn(function()
    while task.wait(5) do
        if _G.AutoSellFish then
            pcall(function()
                JobsRemote:InvokeServer("FishingNPC", "SellFish")
            end)
        end
    end
end)
Fish:AddToggle({
    Title = "Auto Use Rod Skill",
    Description = "Spams the Z skill of the equipped tool",
    Default = GetSetting("Fish_AutoSkillZ", false),
    Callback = function(Value)
        _G.AutoSkillZ = Value
        _G.SaveData["Fish_AutoSkillZ"] = Value
        SaveSettings()
    end
})
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoSkillZ then
            pcall(function()
                ToolAbilities:InvokeServer("Z", true)
            end)
        end
    end
end)
if World3  then 
Event:AddSection("Kitsune Island");
Event:AddToggle({
    Title = "Auto Find Kitsune Island",
    Description = "", 
    Default = GetSetting("FindKitsune_Save", false),
    Callback = function(I)
        _G.AutofindKitIs = I
        _G.SaveData["FindKitsune_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait() do
		if _G.AutofindKitIs then
			pcall(function()
				if not workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
					local I = CheckBoat();
					if not I then
						local I = CFrame.new(-16927.451, 9.086, 433.864);
						TeleportToTarget(I);
						if (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat);
						end;
					else
						if plr.Character.Humanoid.Sit == false then
							local e = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
							_tp(e);
						else
							local I = CFrame.new(-10000000, 31, 37016.25);
							repeat
								wait();
								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-10000000, 150, 37016.25));
								else
									_tp(CFrame.new(-10000000, 31, 37016.25));
								end;
							until not _G.AutofindKitIs or (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") or plr.Character.Humanoid.Sit == false;
							plr.Character.Humanoid.Sit = false;
						end;
					end;
				else
					_tp((workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")).CFrame * CFrame.new(0, 500, 0));
				end;
			end);
		end;
	end;
end);
Event:AddToggle({
	Title = "Auto Teleport to Shrine Actived",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.tweenShrine = I;
	end,
});
spawn(function()
	while wait(.1) do
		if _G.tweenShrine then
			pcall(function()
				local I = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island");
				local e = I:FindFirstChild("ShrineActive");
				if e then
					for e, K in next, e:GetDescendants() do
						if K:IsA("BasePart") and K.Name:find("NeonShrinePart") then
							(replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")):FireServer();
							repeat
								wait();
								_tp(K.CFrame * CFrame.new(0, 2, 0));
							until _G.tweenShrine == false or not I;
						end;
					end;
				else
					_tp((workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")).CFrame * CFrame.new(0, 500, 0));
				end;
			end);
		end;
	end;
end);
Event:AddToggle({
    Title = "Auto Collect Azure Ember",
    Description = "",
    Default = GetSetting("CollectAzureEmber_Save", false),
    Callback = function(I)
        _G.Collect_Ember = I
        _G.SaveData["CollectAzureEmber_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(.1) do
		if _G.Collect_Ember then
			pcall(function()
				if workspace:WaitForChild("AttachedAzureEmber") or workspace:WaitForChild("EmberTemplate") then
					notween(((workspace:WaitForChild("EmberTemplate")):FindFirstChild("Part")).CFrame);
				else
					_tp((workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")).CFrame * CFrame.new(0, 500, 0));
					replicated.Modules.Net["RF/KitsuneStatuePray"]:InvokeServer();
				end;
			end);
		end;
	end;
end);
Event:AddToggle({
    Title = "Auto Trade Azure Ember",
    Description = "",
    Default = GetSetting("TradeAzureEmber_Save", false),
    Callback = function(I)
        _G.Trade_Ember = I
        _G.SaveData["TradeAzureEmber_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(.1) do
		if _G.Trade_Ember then
			pcall(function()
				if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
					(replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray")):InvokeServer();
				end;
			end);
		end;
	end;
end);
	Event:AddSection("Miragem Island");
Event:AddToggle({
	Title = "Auto Find Mirage Island",
    Description = "", 
    Default = GetSetting("FindMirage_Save", false),
    Callback = function(I)
        _G.FindMirage = I
        _G.SaveData["FindMirage_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait() do
		if _G.FindMirage then
			pcall(function()
				if not workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
					local I = CheckBoat();
					if not I then
						local I = CFrame.new(-16927.451, 9.086, 433.864);
						TeleportToTarget(I);
						if (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat);
						end;
					else
						if plr.Character.Humanoid.Sit == false then
							local e = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0);
							_tp(e);
						else
							repeat
								wait();
								local I = CFrame.new(-10000000, 31, 37016.25);
								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-10000000, 150, 37016.25));
								else
									_tp(CFrame.new(-10000000, 31, 37016.25));
								end;
							until not _G.FindMirage or (I.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 or workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") or plr.Character.Humanoid.Sit == false;
							plr.Character.Humanoid.Sit = false;
						end;
					end;
				else
					_tp(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 300, 0));
				end;
			end);
		end;
	end;
end);
Event:AddToggle({
	Title = "Auto Tween To Highest Point",
    Description = "",
    Default = GetSetting("HighestMirage_Save", false),
    Callback = function(I)
        _G.HighestMirage = I
        _G.SaveData["HighestMirage_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(1) do
        if _G.HighestMirage then
            pcall(function()
                if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
                    if _tp then
                        _tp(workspace.Map.MysticIsland.Center.CFrame * CFrame.new(0, 400, 0))
                    end
                end
            end)
        end
    end
end)
Event:AddToggle({
	Title = "Auto Collect Gear",
    Description = "",
    Default = GetSetting("AutoCollectGear_Save", false),
    Callback = function(I)
        _G.TPGEAR = I
        _G.SaveData["AutoCollectGear_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(0.1) do
        if _G.TPGEAR then
            pcall(function()
                local mystic = workspace.Map:FindFirstChild("MysticIsland")
                if mystic then
                    for _, e in pairs(mystic:GetChildren()) do
                        if e.Name == "Part" and e:IsA("MeshPart") then
                            if _tp then
                                _tp(e.CFrame)
                            end
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - e.Position).Magnitude < 20 then
                                fireproximityprompt(e:FindFirstChildOfClass("ProximityPrompt"), 30)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Event:AddToggle({
	Title = "Auto Teleport Advanced Fruit Dealer",
    Description = "",
    Default = GetSetting("AutoTweenAdvancedDealer_Save", false),
    Callback = function(I)
        _G.Addealer = I
        _G.SaveData["AutoTweenAdvancedDealer_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(1) do 
        if _G.Addealer then
            pcall(function()
                local npcs = game:GetService("ReplicatedStorage"):FindFirstChild("NPCs")
                if npcs then
                    for _, e in pairs(npcs:GetChildren()) do
                        if e.Name == "Advanced Fruit Dealer" and e:FindFirstChild("HumanoidRootPart") then
                            if _tp then
                                _tp(e.HumanoidRootPart.CFrame)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Event:AddToggle({
	Title = "Auto Collect Mirage Chest",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.FarmChestM = I;
	end,
});
spawn(function()
	while wait(.2) do
		if _G.FarmChestM then
			pcall(function()
				if workspace.Map.MysticIsland.Chests:FindFirstChild("DiamondChest") or workspace.Map.MysticIsland.Chests:FindFirstChild("FragChest") then
					local I = game:GetService("CollectionService");
					local e = game:GetService("Players");
					local K = e.LocalPlayer;
					local n = K.Character or K.CharacterAdded:Wait();
					if not n then
						return;
					end;
					local d = (n:GetPivot()).Position;
					local z = I:GetTagged("_ChestTagged");
					local H, F = math.huge, nil;
					for I = 1, #z, 1 do
						local e = z[I];
						local K = ((e:GetPivot()).Position - d).Magnitude;
						if not SelectedIsland or e:IsDescendantOf(SelectedIsland) then
							if not e:GetAttribute("IsDisabled") and K < H then
								H = K;
								F = e;
							end;
						end;
					end;
					if F then
						_tp(F:GetPivot());
					end;
				end;
			end);
		end;
	end;
end);
	Event:AddSection("Volcanic Magnet");
Event:AddToggle({
    Title = "Auto Craft Volcanic Magnet",
    Description = "", 
    Default = false,
    Callback = function(I)
        _G.CraftVM = I;
    end,
});
Event:AddButton({ 
    Title = "Craft Volcanic Magnet", 
    Description = "", 
    Callback = function()
        replicated.Remotes.CommF_:FireServer("Notify", "<Color=Yellow>Crafted <Volcanic Magnet><Color=/>")
    end 
});
spawn(function()
    while wait(Sec) do
        pcall(function()
            if _G.CraftVM then
                if GetM("Volcanic Magnet") < 1 then
                    if GetM("Scrap Metal") >= 10 and GetM("Blaze Ember") >= 15 then
                        replicated.Remotes.CommF_:FireServer("Notify", "<Color=Yellow>Crafted <Volcanic Magnet><Color=/>")
                    elseif GetM("Scrap Metal") < 10 then
                        local I = GetConnectionEnemies("Forest Pirate");
                        if I then
                            repeat
                                wait();
                                G.Kill(I, _G.CraftVM);
                            until not _G.CraftVM or not I.Parent or I.Humanoid.Health <= 0 or GetM("Scrap Metal") >= 10;
                        else
                            _tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375));
                        end;
                    elseif GetM("Blaze Ember") < 15 then
                        local startTime = tick()
                        repeat
                            replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5643.4526367188, 1013.0858154297, -340.51025390625))
                            wait(0.1)
                        until (tick() - startTime) >= 1 or not _G.CraftVM
                        repeat
                            wait();
                            _G.FarmBlazeEM = true;
                        until not _G.CraftVM or GetM("Blaze Ember") >= 15;
                        _G.FarmBlazeEM = false;
                    end;
                end;
            end;
        end);
    end;
end);
Event:AddSection("Prehistoric Island");
Event:AddToggle({
    Title = "Auto Find Prehistoric Island",
    Description = "",
    Default = GetSetting("PrehistoricFinder_Save", false),
    Callback = function(I)
        _G.Prehis_Find = I
        _G.SaveData["PrehistoricFinder_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait() do
        if _G.Prehis_Find then
            pcall(function()
                if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
                    local I = CheckBoat()
                    if I and I:FindFirstChild("VehicleSeat") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (plr.Character.HumanoidRootPart.Position - I.VehicleSeat.Position).Magnitude
                        if dist > 2500 then 
                            I = nil 
                        end
                    end
                    if not I then
                        local DealerPos = CFrame.new(-16927.451, 9.086, 433.864)
                        TeleportToTarget(DealerPos)
                        if (DealerPos.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                            replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
                        end
                    else
                        if plr.Character.Humanoid.Sit == false then
                            local seatCF = I.VehicleSeat.CFrame * CFrame.new(0, 1, 0)
                            _tp(seatCF)
                        else
                            local TargetPos = CFrame.new(-10000000, 31, 37016.25)
                            if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
                                _tp(CFrame.new(-10000000, 150, 37016.25))
                            else
                                _tp(TargetPos)
                            end
                            if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") or not _G.Prehis_Find then
                                plr.Character.Humanoid.Sit = false
                            end
                        end
                    end
                else
                    local Island = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island")
                    if (Island.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 2000 then
                        _tp(Island.CFrame)
                    end
                    if workspace.Map:FindFirstChild("PrehistoricIsland", true) or workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
                        local promptPart = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt")
                        if promptPart and promptPart:FindFirstChild("ProximityPrompt") then
                            if plr:DistanceFromCharacter(promptPart.Position) <= 150 then
                                fireproximityprompt(promptPart.ProximityPrompt, math.huge)
                                game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
                                task.wait(1.5)
                                game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
                            end
                            _tp(promptPart.CFrame)
                        end
                    end
                end
            end)
        end
    end
end)
Event:AddToggle({
    Title = "Auto Event Prehistoric Island",
    Description = "",
    Default = GetSetting("AutoEventPrehistoric_Save", false),
    Callback = function(I)
        _G.PrehistoricEvent = I
        _G.Prehis_Skills = I
        _G.SaveData["AutoEventPrehistoric_Save"] = I
        SaveSettings()
        if I then
            local RunService = game:GetService("RunService")
            task.spawn(function()
                while _G.Prehis_Skills do
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, v in pairs(char:GetChildren()) do
                            if v:IsA("BasePart") and v.CanCollide then
                                v.CanCollide = false
                            end
                        end
                    end
                    RunService.Stepped:Wait() 
                end
            end)
        end
    end,
})
spawn(function()
    while task.wait(1.5) do 
        if _G.Prehis_Skills then
            pcall(function()
                local MapIsland = game.Workspace.Map:FindFirstChild("PrehistoricIsland")
                if MapIsland then
                    local core = MapIsland:FindFirstChild("Core")
                    if core and core:FindFirstChild("InteriorLava") then
                        core.InteriorLava:Destroy()
                    end
                    for _, obj in pairs(MapIsland:GetDescendants()) do
                        if (obj:IsA("Part") or obj:IsA("MeshPart")) then
                            if obj.Name == "Lava" or obj.Name == "LavaPart" or obj.Name:lower():find("magma") then
                                obj:Destroy()
                            end
                        end
                        if obj.Name == "TouchInterest" and obj.Parent then
                            if not obj.Parent.Name:find("TrialTeleport") then
                                obj.Parent:Destroy()
                            end
                        end
                    end
                end
            end)
        end
    end
end)
spawn(function()
    while task.wait() do 
        if _G.Prehis_Skills then
            pcall(function()
                local plr = game.Players.LocalPlayer
                if workspace.Enemies:FindFirstChild("Lava Golem") then
                    local enemy = nil
                    pcall(function() 
                         if GetConnectionEnemies then
                            enemy = GetConnectionEnemies("Lava Golem") 
                         else
                            enemy = workspace.Enemies["Lava Golem"]
                         end
                    end)
                    if enemy and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                        repeat
                            task.wait() 
                            if enemy:FindFirstChild("HumanoidRootPart") and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                _tp(enemy.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
                                plr.Character.HumanoidRootPart.Velocity = Vector3.zero
                            end
                            if G and G.Kill then
                                G.Kill(enemy, _G.Prehis_Skills) 
                            end
                        until not _G.Prehis_Skills or not enemy.Parent or enemy.Humanoid.Health <= 0
                    end
                end
                local core = game.Workspace.Map:FindFirstChild("PrehistoricIsland") and game.Workspace.Map.PrehistoricIsland:FindFirstChild("Core")
                if core and core:FindFirstChild("VolcanoRocks") then
                    for _, rock in pairs(core.VolcanoRocks:GetChildren()) do
                        if rock:FindFirstChild("VFXLayer") then
                            local layer = rock.VFXLayer
                            if layer:FindFirstChild("At0") and layer.At0:FindFirstChild("Glow") and layer.At0.Glow.Enabled == true then
                                repeat
                                    task.wait() 
                                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                        local safePosition = layer.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                                        _tp(safePosition)
                                        plr.Character.HumanoidRootPart.Velocity = Vector3.zero
                                    end
                                    if plr:DistanceFromCharacter(layer.CFrame.Position) <= 200 then
                                        MousePos = layer.CFrame.Position 
                                        local VIM = game:GetService("VirtualInputManager")
                                        VIM:SendKeyEvent(true, "Z", false, game)
                                        VIM:SendKeyEvent(true, "X", false, game)
                                        VIM:SendKeyEvent(true, "C", false, game)
                                        if Useskills then
                                            Useskills("Melee", "Z")
                                            Useskills("Melee", "X")
                                            Useskills("Melee", "C")
                                            Useskills("Blox Fruit", "Z")
                                            Useskills("Blox Fruit", "X")
                                            Useskills("Blox Fruit", "C")
                                        end
                                    end
                                until not _G.Prehis_Skills or layer.At0.Glow.Enabled == false or not rock.Parent
                            end
                        end
                    end
                end
            end)
        else
            task.wait(1) 
        end
    end
end)
Event:AddToggle({
    Title = "Auto Collect Dino Bones",
    Description = "",
    Default = GetSetting("DinoBones_Save", false),
    Callback = function(I)
        _G.Prehis_DB = I
        _G.SaveData["DinoBones_Save"] = I
        SaveSettings()
    end,
})
Event:AddToggle({
    Title = "Auto Collect Dragon Eggs",
    Description = "",
    Default = GetSetting("DragonEggs_Save", false),
    Callback = function(I)
        _G.Prehis_DE = I
        _G.SaveData["DragonEggs_Save"] = I
        SaveSettings()
    end,
})
Event:AddToggle({
    Title = "Auto Reset When Complete Volcano",
    Description = "",
    Default = GetSetting("ResetVolcano_Save", false),
    Callback = function(I)
        _G.ResetPH = I
        _G.SaveData["ResetVolcano_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait() do
        pcall(function()
            local FoundTarget = false
            if _G.Prehis_DE then
                local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland")
                if MapIsland and MapIsland.Core:FindFirstChild("SpawnedDragonEggs") then
                    local Egg = MapIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg")
                    if Egg and Egg:FindFirstChild("Molten") then
                        FoundTarget = true
                        _G.Collecting = true
                        _tp(Egg.Molten.CFrame)
                        if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Egg.Molten.Position).Magnitude <= 15 then
                            fireproximityprompt(Egg.Molten.ProximityPrompt, 30)
                        end
                    end
                end
            end
            if _G.Prehis_DB and not FoundTarget then
                local Bone = workspace:FindFirstChild("DinoBone")
                if Bone then
                    FoundTarget = true
                    _G.Collecting = true
                    _tp(Bone.CFrame)
                end
            end
            if not FoundTarget then
                _G.Collecting = false
            end
        end)
    end
end)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.ResetPH then
                local MapIsland = workspace.Map:FindFirstChild("PrehistoricIsland")
                local EventEnded = MapIsland and MapIsland:FindFirstChild("TrialTeleport") and MapIsland.TrialTeleport:FindFirstChild("TouchInterest")
                if EventEnded then
                    task.wait(4.5) 
                    while true do
                        local ShouldWait = false
                        if _G.Prehis_DE and MapIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then
                            ShouldWait = true
                        end
                        if _G.Prehis_DB and workspace:FindFirstChild("DinoBone") then
                            ShouldWait = true
                        end
                        if _G.Collecting then
                            ShouldWait = true
                        end
                        if ShouldWait then
                            task.wait(0.5)
                        else
                            break 
                        end
                    end
                    game.Players.LocalPlayer.Character.Humanoid.Health = 0
                    task.wait(8) 
                end
            end
        end)
    end
end)
Event:AddSection("Frozen Dimension")
Event:AddButton({
	Title = "Buy Spy",
	Description = "", 
	Callback = function()
		replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "2");
	end
});
Event:AddToggle({
    Title = "Teleport Frozen Dimension",
    Description = "", 
    Default = GetSetting("FrozenTP_Save", false),
    Callback = function(I)
        _G.FrozenTP = I
        _G.SaveData["FrozenTP_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(.1) do
		if _G.FrozenTP then
			pcall(function()
				if workspace.Map:FindFirstChild("LeviathanGate") then
					_tp(workspace.Map.LeviathanGate.CFrame);
					replicated.Remotes.CommF_:InvokeServer("OpenLeviathanGate");
				end;
			end);
		end;
	end;
end); 
end
function isnil(I)
	return I == nil;
end;
local function G5(I)
	return math.floor(tonumber(I) + .5);
end;
Number = math.random(1, 1000000);
EspPly = function()
    for I, e in next, game.Players:GetChildren() do
        pcall(function()
            if not isnil(e.Character) then
                if PlayerEsp then
                    if not isnil(e.Character.Head) and not e.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        local I = Instance.new("BillboardGui", e.Character.Head);
                        I.Name = "NameEsp" .. Number;
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = e.Character.Head;
                        I.AlwaysOnTop = true;
                        local K = Instance.new("TextLabel", I);
                        K.Font = Enum.Font.Code;
                        K.FontSize = "Size14";
                        K.TextWrapped = true;
                        K.Text = e.Name .. " | Lv. " .. (e.Data.Level.Value);
                        K.Size = UDim2.new(1, 0, 1, 0);
                        K.TextYAlignment = "Top";
                        K.BackgroundTransparency = 1;
                        K.TextStrokeTransparency = .5;
                        K.TextColor3 = Color3.new(1, 1, 1);
                    else
                        e.Character.Head["NameEsp" .. Number].TextLabel.Text = e.Name .. " | Lv. " .. (e.Data.Level.Value);
                    end;
                else
                    if e.Character.Head:FindFirstChild("NameEsp" .. Number) then
                        (e.Character.Head:FindFirstChild("NameEsp" .. Number)):Destroy();
                    end;
                end;
            end;
        end);
    end;
end;
DevEsp = function()
    for I, e in next, workspace:GetChildren() do
        pcall(function()
            if DevilFruitESP then
                if string.find(e.Name, "Fruit") then
                    if not e.Handle:FindFirstChild("NameEsp" .. Number) then
                        local I = Instance.new("BillboardGui", e.Handle);
                        I.Name = "NameEsp" .. Number;
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = e.Handle;
                        I.AlwaysOnTop = true;
                        local K = Instance.new("TextLabel", I);
                        K.Font = Enum.Font.Code;
                        K.FontSize = "Size14";
                        K.TextWrapped = true;
                        K.Size = UDim2.new(1, 0, 1, 0);
                        K.TextYAlignment = "Top";
                        K.BackgroundTransparency = 1;
                        K.TextStrokeTransparency = .5;
                        K.TextColor3 = Color3.fromRGB(255, 255, 255);
                        K.Text = e.Name .. (" \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Handle.Position).Magnitude / 3) .. " M"));
                    else
                        e.Handle["NameEsp" .. Number].TextLabel.Text = "[" .. (e.Name .. ("]" .. ("   \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Handle.Position).Magnitude / 3) .. " M"))));
                    end;
                end;
            else
                if e.Handle:FindFirstChild("NameEsp" .. Number) then
                    (e.Handle:FindFirstChild("NameEsp" .. Number)):Destroy();
                end;
            end;
        end);
    end;
end;
flowerEsp = function()
    for I, e in pairs(workspace:GetChildren()) do
        pcall(function()
            if e.Name == "Flower2" or e.Name == "Flower1" then
                if FlowerESP then
                    if not e:FindFirstChild("NameEsp" .. Number) then
                        local I = Instance.new("BillboardGui", e);
                        I.Name = "NameEsp" .. Number;
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = e;
                        I.AlwaysOnTop = true;
                        local K = Instance.new("TextLabel", I);
                        K.Font = Enum.Font.Code;
                        K.FontSize = "Size14";
                        K.TextWrapped = true;
                        K.Size = UDim2.new(1, 0, 1, 0);
                        K.TextYAlignment = "Top";
                        K.BackgroundTransparency = 1;
                        K.TextStrokeTransparency = .5;
                        K.TextColor3 = Color3.fromRGB(255, 255, 255);
                        if e.Name == "Flower1" then
                            K.Text = "Blue Flower" .. (" \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
                        end;
                        if e.Name == "Flower2" then
                            K.Text = "Red Flower" .. (" \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
                        end;
                    else
                        e["NameEsp" .. Number].TextLabel.Text = e.Name .. ("   \n" .. (G5(((game:GetService("Players")).LocalPlayer.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
                    end;
                else
                    if e:FindFirstChild("NameEsp" .. Number) then
                        (e:FindFirstChild("NameEsp" .. Number)):Destroy();
                    end;
                end;
            end;
        end);
    end;
end;
gearEsp = function()
    for I, e in pairs(workspace.Map.MysticIsland:GetDescendants()) do
        pcall(function()
            if ESPGear then
                if e.Name == "Part" and e.Material == Enum.Material.Neon then
                    if not e:FindFirstChild("NameEsp") then
                        local I = Instance.new("BillboardGui", e);
                        I.Name = "NameEsp";
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = e;
                        I.AlwaysOnTop = true;
                        local K = Instance.new("TextLabel", I);
                        K.Font = "Code";
                        K.FontSize = "Size14";
                        K.TextWrapped = true;
                        K.Size = UDim2.new(1, 0, 1, 0);
                        K.TextYAlignment = "Top";
                        K.BackgroundTransparency = 1;
                        K.TextStrokeTransparency = .5;
                        K.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        e.NameEsp.TextLabel.Text = "Gear" .. ("   \n" .. (G5((plr.Character.Head.Position - e.Position).Magnitude / 3) .. " M"));
                    end;
                end;
            else
                if e:FindFirstChild("NameEsp") then
                    (e:FindFirstChild("NameEsp")):Destroy();
                end;
            end;
        end);
    end;
end;
AdvanFruitEsp = function()
    if advanEsp == true then
        for I, e in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
            if e.Name == "Advanced Fruit Dealer" then
                local Adv = workspace:FindFirstChild("Adv")
                if not Adv then
                    Adv = Instance.new("Part");
                    Adv.Name = "Adv";
                    Adv.Transparency = 1;
                    Adv.Size = Vector3.new(1, 1, 1);
                    Adv.Anchored = true;
                    Adv.CanCollide = false;
                    Adv.Parent = workspace;
                    Adv.CFrame = e.HumanoidRootPart.CFrame;
                end
                if Adv then
                    if not Adv:FindFirstChild("NameEsp") then
                        local I = Instance.new("BillboardGui", Adv);
                        I.Name = "NameEsp";
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = Adv;
                        I.AlwaysOnTop = true;
                        local txt = Instance.new("TextLabel", I);
                        txt.Font = "Code";
                        txt.FontSize = "Size14";
                        txt.TextWrapped = true;
                        txt.Size = UDim2.new(1, 0, 1, 0);
                        txt.TextYAlignment = "Top";
                        txt.BackgroundTransparency = 1;
                        txt.TextStrokeTransparency = .5;
                        txt.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        Adv.NameEsp.TextLabel.Text = e.Name .. ("   \n" .. (G5((game.Players.LocalPlayer.Character.Head.Position - e.HumanoidRootPart.Position).Magnitude / 3) .. " M"));
                    end;
                end;
            end;
        end;
    else
        if workspace:FindFirstChild("Adv") then
            workspace.Adv:Destroy();
        end;
    end;
end;
HakiClorEsp = function()
    if ColorEsp == true then
        for I, e in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
            if e.Name == "Barista Cousin" then
                local Gay = workspace:FindFirstChild("Gay")
                if not Gay then
                    Gay = Instance.new("Part");
                    Gay.Name = "Gay";
                    Gay.Transparency = 1;
                    Gay.Size = Vector3.new(1, 1, 1);
                    Gay.Anchored = true;
                    Gay.CanCollide = false;
                    Gay.Parent = workspace;
                    Gay.CFrame = e.HumanoidRootPart.CFrame;
                end
                if Gay then
                    if not Gay:FindFirstChild("NameEsp") then
                        local I = Instance.new("BillboardGui", Gay);
                        I.Name = "NameEsp";
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = Gay;
                        I.AlwaysOnTop = true;
                        local txt = Instance.new("TextLabel", I);
                        txt.Font = "Code";
                        txt.FontSize = "Size14";
                        txt.TextWrapped = true;
                        txt.Size = UDim2.new(1, 0, 1, 0);
                        txt.TextYAlignment = "Top";
                        txt.BackgroundTransparency = 1;
                        txt.TextStrokeTransparency = .5;
                        txt.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        Gay.NameEsp.TextLabel.Text = e.Name .. ("   \n" .. (G5((game.Players.LocalPlayer.Character.Head.Position - e.HumanoidRootPart.Position).Magnitude / 3) .. " M"));
                    end;
                end;
            end;
        end;
    else
        if workspace:FindFirstChild("Gay") then
            workspace.Gay:Destroy();
        end;
    end;
end;
LegenSword = function()
    if LegenS == true then
        for I, e in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
            if e.Name == "Legendary Sword Dealer " then
                if not workspace:FindFirstChild("Lgd") then
                    Lgd = Instance.new("Part");
                    Lgd.Name = "Lgd";
                    Lgd.Transparency = 1;
                    Lgd.Size = Vector3.new(1, 1, 1);
                    Lgd.Anchored = true;
                    Lgd.CanCollide = false;
                    Lgd.Parent = workspace;
                    Lgd.CFrame = e.HumanoidRootPart.CFrame;
                elseif workspace:FindFirstChild("Lgd") then
                    if not Lgd:FindFirstChild("NameEsp") then
                        local I = Instance.new("BillboardGui", Lgd);
                        I.Name = "NameEsp";
                        I.ExtentsOffset = Vector3.new(0, 1, 0);
                        I.Size = UDim2.new(1, 200, 1, 30);
                        I.Adornee = Lgd;
                        I.AlwaysOnTop = true;
                        local txt = Instance.new("TextLabel", I);
                        txt.Font = "Code";
                        txt.FontSize = "Size14";
                        txt.TextWrapped = true;
                        txt.Size = UDim2.new(1, 0, 1, 0);
                        txt.TextYAlignment = "Top";
                        txt.BackgroundTransparency = 1;
                        txt.TextStrokeTransparency = .5;
                        txt.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        Lgd.NameEsp.TextLabel.Text = e.Name .. ("   \n" .. (G5((game.Players.LocalPlayer.Character.Head.Position - e.HumanoidRootPart.Position).Magnitude / 3) .. " M"));
                    end;
                end;
            end;
        end;
    else
        if workspace:FindFirstChild("Lgd") then
            (workspace:FindFirstChild("Lgd")):Destroy();
        end;
    end;
end;
ChestEsp = function()
    if ChestESP then
        local I = game:GetService("CollectionService");
        local z = I:GetTagged("_ChestTagged");
        for _, e in ipairs(z) do
            pcall(function()
                local H = (e:GetPivot().Position - game.Players.LocalPlayer.Character.Head.Position).Magnitude;
                local Q = e:FindFirstChild("ChestEspAttachment");
                if not Q then
                    local att = Instance.new("Attachment", e);
                    att.Name = "ChestEspAttachment";
                    att.Position = Vector3.new(0, 3, 0);
                    local gui = Instance.new("BillboardGui", att);
                    gui.Name = "NameEsp";
                    gui.Size = UDim2.new(0, 200, 0, 30);
                    gui.AlwaysOnTop = true;
                    local txt = Instance.new("TextLabel", gui);
                    txt.Font = Enum.Font.Code;
                    txt.TextSize = 14;
                    txt.BackgroundTransparency = 1;
                    txt.TextColor3 = Color3.new(1, 1, 1);
                    txt.Size = UDim2.new(1, 0, 1, 0);
                end;
                local X = e.ChestEspAttachment:FindFirstChild("NameEsp");
                if X then
                    X.TextLabel.Text = string.format("[%s] %d M", e.Name:gsub("Label", ""), math.floor(H / 3));
                end;
            end)
        end;
    else
        for _, e in ipairs((game:GetService("CollectionService")):GetTagged("_ChestTagged")) do
            if e:FindFirstChild("ChestEspAttachment") then e.ChestEspAttachment:Destroy(); end;
        end;
    end;
end;
berriesEsp = function()
    if BerryEsp then
        local I = game:GetService("CollectionService");
        local n = I:GetTagged("BerryBush");
        for _, e in ipairs(n) do
            local pos = (e.Parent:GetPivot()).Position;
            for _, attr in pairs(e:GetAttributes()) do
                local name = "BerryEspPart_" .. tostring(pos);
                local d = workspace:FindFirstChild(name);
                if not d then
                    d = Instance.new("Part", workspace);
                    d.Name = name;
                    d.Transparency = 1;
                    d.Anchored = true;
                    d.CanCollide = false;
                    d.CFrame = CFrame.new(pos);
                end;
                if not d:FindFirstChild("NameEsp") then
                    local gui = Instance.new("BillboardGui", d);
                    gui.Name = "NameEsp";
                    gui.Size = UDim2.new(0, 200, 0, 30);
                    gui.AlwaysOnTop = true;
                    local txt = Instance.new("TextLabel", gui);
                    txt.Font = Enum.Font.Code;
                    txt.TextColor3 = Color3.new(1, 1, 1);
                    txt.BackgroundTransparency = 1;
                    txt.Size = UDim2.new(1, 0, 1, 0);
                end;
                local dist = (game.Players.LocalPlayer.Character.Head.Position - pos).Magnitude / 3;
                d.NameEsp.TextLabel.Text = "[" .. attr .. "] " .. math.round(dist) .. " M";
            end;
        end;
    else
        for _, e in ipairs(workspace:GetChildren()) do
            if e.Name:match("BerryEspPart_") then e:Destroy(); end;
        end;
    end;
end;
_G.ESPColor = Color3.fromRGB(255, 255, 255)
function IslandESP_Func()
	for _, island in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		pcall(function()
			if island.Name ~= "Sea" then
                if _G.IslandESP then
                    if not island:FindFirstChild("IslandESP") then
                        local billboard = Instance.new("BillboardGui", island)
                        billboard.Name = "IslandESP"
                        billboard.Size = UDim2.new(0, 150, 0, 35)
                        billboard.StudsOffset = Vector3.new(0, 35, 0)
                        billboard.AlwaysOnTop = true
                        local text = Instance.new("TextLabel", billboard)
                        text.Size = UDim2.new(1, 0, 1, 0)
                        text.BackgroundTransparency = 1
                        text.Text = island.Name
                        text.TextColor3 = _G.ESPColor
                        text.TextStrokeTransparency = 0
                        text.TextScaled = true
                        text.Font = Enum.Font.Cartoon
                    end
                else
                    if island:FindFirstChild("IslandESP") then island.IslandESP:Destroy() end
                end
			end
		end)
	end
end
Esp:AddSection("Esp");
Esp:AddToggle({Title = "Esp Berries", Default = false, Callback = function(I) 
    BerryEsp = I; 
    spawn(function() while BerryEsp do wait(1); berriesEsp(); end; end); 
end});
Esp:AddToggle({Title = "Esp Players", Default = false, Callback = function(I) 
    PlayerEsp = I; 
    spawn(function() while PlayerEsp do wait(0.1); EspPly(); end; end); 
end});
Esp:AddToggle({Title = "Esp Chests", Default = false, Callback = function(I) 
    ChestESP = I; 
    spawn(function() while ChestESP do wait(1); ChestEsp(); end; end); 
end});
Esp:AddToggle({Title = "Esp Fruits", Default = false, Callback = function(I)
    DevilFruitESP = I
    task.spawn(function() while DevilFruitESP do task.wait(1); pcall(DevEsp) end end)
end})
Esp:AddToggle({Title = "Esp Island", Default = false, Callback = function(I)
    _G.IslandESP = I;
    task.spawn(function() while _G.IslandESP do IslandESP_Func(); task.wait(2) end; IslandESP_Func() end)
end});
if World2 or World3 then
    Esp:AddToggle({Title = "Esp Aura Colour Dealers", Default = false, Callback = function(I)
        ColorEsp = I
        task.spawn(function() while ColorEsp do pcall(HakiClorEsp); task.wait(1) end; pcall(HakiClorEsp) end)
    end})
end
if World3 then
    Esp:AddToggle({Title = "Esp Gears", Default = false, Callback = function(I)
        ESPGear = I
        task.spawn(function() while ESPGear do pcall(gearEsp); task.wait(1) end end)
    end})
    Esp:AddToggle({Title = "Esp Advanced Fruits Dealer", Default = false, Callback = function(I)
        advanEsp = I
        task.spawn(function() while advanEsp do pcall(AdvanFruitEsp); task.wait(1) end; pcall(AdvanFruitEsp) end)
    end})
end
Esp:AddSection("Stats");
Esp:AddToggle({
    Title = "Add Points Melee",
    Description = "Gasta pontos automaticamente em Melee",
    Default = GetSetting("AutoMelee_Save", false),
    Callback = function(I)
        _G.Auto_Melee = I
        _G.SaveData["AutoMelee_Save"] = I
        SaveSettings()
    end,
})
Esp:AddToggle({
    Title = "Add Points Sword",
    Description = "Gasta pontos automaticamente em Sword",
    Default = GetSetting("AutoSword_Save", false),
    Callback = function(I)
        _G.Auto_Sword = I
        _G.SaveData["AutoSword_Save"] = I
        SaveSettings()
    end,
})
Esp:AddToggle({
    Title = "Add Points Gun",
    Description = "Gasta pontos automaticamente em Gun",
    Default = GetSetting("AutoGun_Save", false),
    Callback = function(I)
        _G.Auto_Gun = I
        _G.SaveData["AutoGun_Save"] = I
        SaveSettings()
    end,
})
Esp:AddToggle({
    Title = "Add Points Fruit",
    Description = "Gasta pontos automaticamente em Fruit",
    Default = GetSetting("AutoFruit_Save", false),
    Callback = function(I)
        _G.Auto_Blox = I
        _G.SaveData["AutoFruit_Save"] = I
        SaveSettings()
    end,
})
Esp:AddToggle({
    Title = "Add Points Defense",
    Description = "Gasta pontos automaticamente em Defense",
    Default = GetSetting("AutoDefense_Save", false),
    Callback = function(I)
        _G.Auto_Defense = I
        _G.SaveData["AutoDefense_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local remote = game:GetService("ReplicatedStorage").Remotes.CommF_
            if _G.Auto_Melee then remote:InvokeServer("AddPoint", "Melee", 3) end
            if _G.Auto_Sword then remote:InvokeServer("AddPoint", "Sword", 3) end
            if _G.Auto_Gun then remote:InvokeServer("AddPoint", "Gun", 3) end
            if _G.Auto_Blox then remote:InvokeServer("AddPoint", "Demon Fruit", 3) end
            if _G.Auto_Defense then remote:InvokeServer("AddPoint", "Defense", 3) end
        end)
    end
end)
local AllAvailablePoints = 9999999; 
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Melee then
				statsSetings("Melee", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Sword then
				statsSetings("Sword", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Gun then
				statsSetings("Gun", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Blox then 
				statsSetings("Devil", AllAvailablePoints);
			end;
		end);
	end;
end);
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Defense then
				statsSetings("Defense", AllAvailablePoints);
			end;
		end);
	end;
end);
Player:AddSection("Pvp")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local WS = game:GetService("Workspace")
local RS = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
_G.TargetMode = "Closest Player"
_G.PlayersList = "None"
_G.TpPly = false
_G.AimCam = false
local SilentAim_Enabled = false
local PredictionEnabled = true
local PredictionAmount = 0.1
local maxRange = 1000
local renderConnection = nil
local currentTool = nil
local PlayersPosition = nil
local characterConnections = {}
local function GetPlayersTable()
    local t = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(t, v.Name)
        end
    end
    if #t == 0 then return {"None"} end
    table.sort(t)
    return t
end
local PlayerDropdown = Player:AddDropdown({
    Title = "List Players",
    Description = "",
    Options = GetPlayersTable(),
    Default = "None",
    Callback = function(v)
        _G.PlayersList = v
    end,
})
local function RefreshPlayerList()
    local list = GetPlayersTable()
    if #list > 0 and list[1] ~= "None" then
        table.sort(list)
        PlayerDropdown.Refresh(list, list[1])
        _G.PlayersList = list[1]
    else
        PlayerDropdown.Refresh({"None"}, "None")
        _G.PlayersList = "None"
    end
end
Player:AddButton({
    Title = "Refresh Player List",
    Description = "",
    Callback = RefreshPlayerList
})
Player:AddDropdown({
    Title = "Aimbot Target Mode",
    Description = "",
    Options = {"Closest Player", "Selected Player"},
    Default = "Closest Player",
    Callback = function(I)
        _G.TargetMode = I
    end,
})
function getClosestPlayer(lpHRP)
    local closest, dist = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChildWhichIsA("Humanoid")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hum.Health > 0 and hrp then
                local d = (hrp.Position - lpHRP.Position).Magnitude
                if d < dist and d <= maxRange then
                    dist = d
                    closest = plr
                end
            end
        end
    end
    return closest
end
Player:AddToggle({
    Title = "Teleport To Selected Player",
    Default = false,
    Callback = function(I)
        _G.TpPly = I;
        spawn(function()
            pcall(function()
                while _G.TpPly do
                    wait();
                    local plr = (game:GetService("Players"))[_G.PlayersList]
                    if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        _tp(plr.Character.HumanoidRootPart.CFrame);
                    end
                end;
            end);
        end);
    end,
})
Player:AddSection("Aimbot")
Player:AddToggle({
    Title = "Aimbot Cam Lock",
    Default = false,
    Callback = function(I)
        _G.AimCam = I
    end,
})
task.spawn(function()
    while task.wait() do
        if _G.AimCam then
            pcall(function()
                local cam = WS.CurrentCamera
                local targetPlr
                if _G.TargetMode == "Selected Player" then
                    targetPlr = Players:FindFirstChild(_G.PlayersList)
                else
                    local char = LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        targetPlr = getClosestPlayer(char.HumanoidRootPart)
                    end
                end
                if targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart") then
                    cam.CFrame = CFrame.new(cam.CFrame.Position, targetPlr.Character.HumanoidRootPart.Position)
                end
            end)
        end
    end
end)
Player:AddToggle({
    Title = "Aimbot Skills",
    Default = false,
    Callback = function(state)
        SilentAim_Enabled = state
    end
})
local function getPredictedPosition(hrp)
    if not hrp then return nil end
    local hum = hrp.Parent:FindFirstChildWhichIsA("Humanoid")
    if not hum or not PredictionEnabled or hum.WalkSpeed < 5 then
        return hrp.Position
    end
    return hrp.Position + (hrp.Velocity * PredictionAmount)
end
local function isSkillReadyForTool(toolName)
    if not toolName then return false end
    local gui = LocalPlayer:FindFirstChild("PlayerGui")
    local main = gui and gui:FindFirstChild("Main")
    local skills = main and main:FindFirstChild("Skills")
    local tool = skills and skills:FindFirstChild(toolName)
    if not tool then return false end
    for _, key in ipairs({"Z","X","C","V"}) do
        local skill = tool:FindFirstChild(key)
        if skill and skill:FindFirstChild("Cooldown") and skill.Cooldown.Size.X.Scale == 1 then
            return true
        end
    end
    return false
end
local function startRender()
    if renderConnection then return end
    renderConnection = RunService.RenderStepped:Connect(function()
        if not SilentAim_Enabled then return end
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local target
        if _G.TargetMode == "Selected Player" then
            target = Players:FindFirstChild(_G.PlayersList)
        else
            target = getClosestPlayer(hrp)
        end
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local thrp = target.Character.HumanoidRootPart
            PlayersPosition = getPredictedPosition(thrp)
            if currentTool and isSkillReadyForTool(currentTool.Name) then
                local look = (Vector3.new(PlayersPosition.X, hrp.Position.Y, PlayersPosition.Z) - hrp.Position).Unit
                hrp.CFrame = CFrame.new(hrp.Position, hrp.Position + look)
            end
        else
            PlayersPosition = nil
        end
    end)
end
local function stopRender()
    if renderConnection then
        renderConnection:Disconnect()
        renderConnection = nil
    end
end
LocalPlayer.CharacterAdded:Connect(function(char)
    for _, c in ipairs(characterConnections) do pcall(function() c:Disconnect() end) end
    characterConnections = {}
    table.insert(characterConnections, char.ChildAdded:Connect(function(obj)
        if obj:IsA("Tool") then currentTool = obj end
    end))
end)
pcall(function()
    local mt = getrawmetatable(game)
    setreadonly(mt, false)
    local old = mt.__namecall
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if (method == "FireServer" or method == "InvokeServer") and SilentAim_Enabled and PlayersPosition and typeof(args[1]) == "Vector3" then
            args[1] = PlayersPosition
            return old(self, unpack(args))
        end
        return old(self, ...)
    end)
    setreadonly(mt, true)
end)
RunService.RenderStepped:Connect(function()
    if SilentAim_Enabled then startRender() else stopRender() end
end)
Player:AddSection("Local Player");
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local humanoid = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") or nil
plr.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
end)
local SpeedEnabled = false
local JumpEnabled = false
local desiredSpeed = 16
local desiredJump = 50
local function protectSpeed()
    if humanoid then
        humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if SpeedEnabled and humanoid.WalkSpeed ~= desiredSpeed then
                humanoid.WalkSpeed = desiredSpeed
            end
        end)
    end
end
local function applyStats()
    if humanoid then
        if SpeedEnabled then humanoid.WalkSpeed = desiredSpeed end
        if JumpEnabled then humanoid.JumpPower = desiredJump end
    end
end
RunService.Heartbeat:Connect(function()
    if humanoid then
        if SpeedEnabled and humanoid.WalkSpeed ~= desiredSpeed then
            humanoid.WalkSpeed = desiredSpeed
        end
        if JumpEnabled and humanoid.JumpPower ~= desiredJump then
            humanoid.JumpPower = desiredJump
        end
    end
end)
plr.CharacterAdded:Connect(function(char)
    humanoid = char:WaitForChild("Humanoid")
    protectSpeed()
end)
protectSpeed()
Player:AddToggle({
	Title = "Set WalkSpeed",
    Description = "Enable custom WalkSpeed",
    Default = false,
    Callback = function(Value)
        SpeedEnabled = Value
        applyStats()
    end
})
Player:AddTextBox({
    Title = "WalkSpeed Value",
    Description = "",
    PlaceHolder = "16",
    Default = tostring(desiredSpeed),
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            desiredSpeed = num
            applyStats()
        end
    end
})
Player:AddToggle({
	Title = "Set JumpPower",
    Description = "Enable custom JumpPower",
    Default = false,
    Callback = function(Value)
        JumpEnabled = Value
        applyStats()
    end
})
Player:AddTextBox({
    Title = "JumpPower Value",
    Description = "",
    PlaceHolder = "50",
    Default = tostring(desiredJump),
    Callback = function(Value)
        local num = tonumber(Value)
        if num then
            desiredJump = num
            applyStats()
        end
    end
})
Teleport:AddSection("Worlds");
Teleport:AddButton({ Title = "Teleport Sea 1", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("TravelMain");
	end });
Teleport:AddButton({ Title = "Teleport Sea 2", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("TravelDressrosa");
	end });
Teleport:AddButton({ Title = "Teleport Sea 3", Description = "", Callback = function()
		replicated.Remotes.CommF_:InvokeServer("TravelZou");
	end });
Teleport:AddSection("Island")
Location = {}
for _, e in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
	table.insert(Location, e.Name)
end
Teleport:AddDropdown({
	Title = "Select Island",
	Description = "",
	Options = Location,
	Default = false,
	Multi = false,
	Callback = function(I)
		_G.Island = I
	end,
})
Teleport:AddToggle({
    Title = "Auto Teleport",
    Description = "",
    Default = false,
    Callback = function(Value)
        _G.Teleport = Value
        if Value then
            local targetIsland = workspace._WorldOrigin.Locations:FindFirstChild(_G.Island)
            if targetIsland then
                spawn(function()
                    Root.CFrame = Root.CFrame * CFrame.new(0, 700, 0)
                    wait(0.1) 
                    local destination = targetIsland.CFrame * CFrame.new(0, 700, 0)
                    repeat
                        wait()
                        _tp(destination)
                    until not _G.Teleport or (Root.Position - destination.p).Magnitude < 10
                    if _G.Teleport then
                        Root.CFrame = targetIsland.CFrame * CFrame.new(0, 5, 0) 
                    end
                    _G.Teleport = false
                end)
            else
                print("Selecione uma ilha primeiro!")
                _G.Teleport = false
            end
        end
    end,
})
Teleport:AddSection("Npc");
for I, e in pairs(replicated.NPCs:GetChildren()) do
	table.insert(NPCList, e.Name);
end;
Teleport:AddDropdown({
	Title = "Select Npc",
	Description = "",
	Options = NPCList,
	Default = false,
	Multi = false,
	Callback = function(I)
		NPClist = I;
	end,
});
Teleport:AddToggle({
	Title = "Auto Teleport To Npc",
	Description = "Automatic teleport to pos Npcs",
	Default = false,
	Callback = function(I)
		_G.TPNpc = I;
	end,
});
spawn(function()
	while wait(Sec) do
		if _G.TPNpc then
			pcall(function()
				for I, e in pairs(replicated.NPCs:GetChildren()) do
					if e.Name == NPClist then
						_tp(e.HumanoidRootPart.CFrame);
					end;
				end;
			end);
		end;
	end;
end);
Teleport:AddSection("Race")
Teleport:AddButton({
	Title = "Teleport Temple of Time",
	Description = "Teleport to temple of time",
	Callback = function()
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local Workspace = game:GetService("Workspace")
		local Players = game:GetService("Players")
		local lp = Players.LocalPlayer
		local TargetPos = Vector3.new(28286, 14897, 103)
		local TargetCFrame = CFrame.new(TargetPos)
		local function LoadMap()
			pcall(function()
				local mapStash = ReplicatedStorage:WaitForChild("MapStash", 5)
				local temple = mapStash and mapStash:FindFirstChild("Temple of Time")
				if temple and not Workspace:FindFirstChild("Temple of Time") then
					local mapFolder = Workspace:FindFirstChild("Map")
					temple.Parent = mapFolder or Workspace
				end
			end)
		end
		task.spawn(function()
			local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
			while true do
				pcall(function()
					remote:InvokeServer("RaceV4Progress", "Check")
					task.wait(0.1)
					remote:InvokeServer("RaceV4Progress", "Teleport")
				end)
				task.wait(2)
			end
		end)
		task.spawn(function()
			LoadMap()
			local arrived = false
			while not arrived do
				task.wait()
				pcall(function()
					local char = lp.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					if hrp then
						hrp.CFrame = TargetCFrame
						if (hrp.Position - TargetPos).Magnitude < 3 then
							arrived = true
							for _, v in pairs(hrp:GetChildren()) do
								if v:IsA("BodyVelocity") or v:IsA("BodyPosition") or v:IsA("BodyGyro") then
									v:Destroy()
								end
							end
						end
					end
				end)
			end
		end)
	end
})
task.spawn(function()
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local Workspace = game:GetService("Workspace")
	local remote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
	local TargetPos = Vector3.new(28286, 14897, 103)
	local TargetCFrame = CFrame.new(TargetPos)
	local function LoadMap()
		pcall(function()
			local mapStash = ReplicatedStorage:WaitForChild("MapStash", 5)
			local temple = mapStash and mapStash:FindFirstChild("Temple of Time")
			if temple and not Workspace:FindFirstChild("Temple of Time") then
				local mapFolder = Workspace:FindFirstChild("Map")
				temple.Parent = mapFolder or Workspace
			end
		end)
	end
	LoadMap()
end)
Fruit:AddSection("Raid Farming");
local function IsRaidMob(mob)
    local n = mob.Name:lower()
    if n:find("raid") or n:find("microchip") or n:find("island") then return true end
    if mob:GetAttribute("IsRaid") or mob:GetAttribute("RaidMob") or mob:GetAttribute("IsBoss") then return true end
    local hum = mob:FindFirstChild("Humanoid")
    if hum and hum.WalkSpeed == 0 then return true end
    if mob.Parent and tostring(mob.Parent):lower():find("_worldorigin") then return true end
    return false
end
local function IsInRaid()
    local ok, result = pcall(function()
        return game:GetService("Players").LocalPlayer.PlayerGui.Main.TopHUDList.RaidTimer.Visible
    end)
    return ok and result == true
end
local function IsIslandRaid(cu)
    local ok, locs = pcall(function() return workspace["_WorldOrigin"].Locations end)
    if not ok or not locs then return nil end
    for _, v in ipairs(locs:GetChildren()) do
        if v.Name == "Island " .. cu then
            return v
        end
    end
    return nil
end
local function getNextRaidIsland()
    for _, id in ipairs({5, 4, 3, 2, 1}) do
        local island = IsIslandRaid(id)
        if island then return island, id end
    end
    return nil, 0
end
_G.SelectChip = _G.SelectChip or "Flame"
_G.AutoRaid = _G.AutoRaid or false
_G.KillH = _G.KillH or false
local LastRaidStartTick = 0
Fruit:AddDropdown({
    Title = "Select Chip",
    Description = "",
    Options = {
        "Flame", "Ice", "Quake", "Light", "Dark",
        "String", "Rumble", "Magma", "Human: Buddha",
        "Sand", "Bird: Phoenix", "Dough"
    },
    Default = _G.SelectChip,
    Callback = function(v)
        _G.SelectChip = v
    end
})
Fruit:AddToggle({
    Title = "Auto Raid",
    Description = "",
    Default = _G.AutoRaid,
    Callback = function(v)
        _G.AutoRaid = v
    end
})
Fruit:AddToggle({
    Title = "Kill Aura (Island 4/5)",
    Description = "",
    Default = _G.KillH,
    Callback = function(v)
        _G.KillH = v
    end
})
spawn(function()
    while task.wait(Sec) do
        if _G.KillH and IsInRaid() then
            local _, islandNum = getNextRaidIsland()
            if islandNum == 4 or islandNum == 5 then
                for _, e in pairs(workspace.Enemies:GetChildren()) do
                    if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 then
                        pcall(function()
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            e:BreakJoints()
                            e.Humanoid.Health = 0
                            if e:FindFirstChild("HumanoidRootPart") then
                                e.HumanoidRootPart.CanCollide = false
                            end
                        end)
                    end
                end
            end
        end
    end
end)
spawn(function()
    while task.wait() do
        if _G.AutoRaid then
            pcall(function()
                local plr = game:GetService("Players").LocalPlayer
                if IsInRaid() then
                    local Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if not Root then return end
                    local target = nil
                    local dist = 1950
                    for _, e in pairs(workspace.Enemies:GetChildren()) do
                        if e:FindFirstChild("Humanoid") and e.Humanoid.Health > 0 and e:FindFirstChild("HumanoidRootPart") and not IsRaidMob(e) then
                            local d = (Root.Position - e.HumanoidRootPart.Position).Magnitude
                            if d < dist then
                                dist = d
                                target = e
                            end
                        end
                    end
                    if target then
                        _tp(target.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0))
                        if G and G.Kill then
                            G.Kill(target, _G.AutoRaid)
                        end
                    else
                        local island = getNextRaidIsland()
                        if island then
                            _tp(island.CFrame * CFrame.new(0, 60, 0))
                        end
                    end
                else
                    local hasChip = (plr.Backpack:FindFirstChild("Special Microchip") or (plr.Character and plr.Character:FindFirstChild("Special Microchip")))
                    if not hasChip and not IsInRaid() then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
                        if not (plr.Backpack:FindFirstChild("Special Microchip") or (plr.Character and plr.Character:FindFirstChild("Special Microchip"))) and not IsInRaid() then
                            local fruits = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
                            for _, data in pairs(fruits or {}) do
                                if IsInRaid() or (plr.Backpack:FindFirstChild("Special Microchip") or (plr.Character and plr.Character:FindFirstChild("Special Microchip"))) then break end
                                local rarity = tostring(data.Rarity or ""):lower()
                                if (data.Price or 0) <= 1150000 or rarity == "common" or rarity == "uncommon" or rarity == "rare" then
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", data.Name)
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
                                end
                            end
                        end
                    end
                    hasChip = (plr.Backpack:FindFirstChild("Special Microchip") or (plr.Character and plr.Character:FindFirstChild("Special Microchip")))
                    if hasChip and not IsInRaid() then
                        local pId = game.PlaceId
                        local targetPos = nil
                        local button = nil
                        if pId == 4442272183 or pId == 79091703265657 then
                            targetPos = CFrame.new(-6521.95215, 307.734985, -4813.02441)
                            if workspace.Map:FindFirstChild("CircleIsland") then
                                button = workspace.Map.CircleIsland:FindFirstChild("RaidSummon2", true)
                                button = button and button:FindFirstChild("ClickDetector", true)
                            end
                        elseif pId == 7449423635 or pId == 100117331123089 then
                            targetPos = CFrame.new(-5034.36523, 315.004669, -2949.36304)
                            if workspace.Map:FindFirstChild("Boat Castle") then
                                button = workspace.Map["Boat Castle"]:FindFirstChild("RaidSummon2", true)
                                button = button and button:FindFirstChild("ClickDetector", true)
                            end
                        end
                        if targetPos and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            local hrp = plr.Character.HumanoidRootPart
                            repeat
                                task.wait()
                                _tp(targetPos)
                            until not _G.AutoRaid or IsInRaid() or (hrp.Position - targetPos.Position).Magnitude < 3
                            if _G.AutoRaid and not IsInRaid() then
                                hrp.CFrame = targetPos
                                task.wait(0.2)
                                if button and (tick() - LastRaidStartTick) >= 5 then
                                    pcall(function()
                                        fireclickdetector(button, 0)
                                    end)
                                    LastRaidStartTick = tick()
                                    local deadline = tick() + 30
                                    repeat task.wait(0.5) until IsInRaid() or tick() > deadline or not _G.AutoRaid
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)
Fruit:AddToggle({
	Title = "Auto Awakening",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.Auto_Awakener = I;
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Awakener then
				replicated.Remotes.CommF_:InvokeServer("Awakener", "Check");
				replicated.Remotes.CommF_:InvokeServer("Awakener", "Awaken");
			end;
		end);
	end;
end);
local FruitList = {}
local Remote = game:GetService("ReplicatedStorage").Remotes.CommF_
local function LoadFruitData()
    local NormalStock = Remote:InvokeServer("GetFruits", false)
    local MirageStock = Remote:InvokeServer("GetFruits", true)
    local TempTable = {}
    for _, data in pairs(NormalStock) do
        TempTable[data.Name] = true
    end
    for _, data in pairs(MirageStock) do
        TempTable[data.Name] = true
    end
    for name, _ in pairs(TempTable) do
        table.insert(FruitList, name)
    end
    table.sort(FruitList)
end
LoadFruitData()
Fruit:AddSection("Fruit Sniper");
Fruit:AddDropdown({
    Title = "Select Fruit",
    Description = "Choose a fruit to snipe",
    Options = FruitList,
    Default = false,
    Multi = false,
    Callback = function(Value)
        _G.SelectedFruit = Value
    end,
})
Fruit:AddToggle({
    Title = "Sniper Fruit",
    Description = "Auto buy when in stock",
    Default = false,
    Callback = function(Value)
        _G.SniperEnabled = Value
    end
})
task.spawn(function()
    while task.wait(1) do
        if _G.SniperEnabled and _G.SelectedFruit then
            local CurrentNormal = Remote:InvokeServer("GetFruits", false)
            local CurrentMirage = Remote:InvokeServer("GetFruits", true)
            local CanBuy = false
            if CurrentNormal[_G.SelectedFruit] and CurrentNormal[_G.SelectedFruit].OnSale then
                CanBuy = true
            elseif CurrentMirage[_G.SelectedFruit] and CurrentMirage[_G.SelectedFruit].OnSale then
                CanBuy = true
            end
            if CanBuy then
                Remote:InvokeServer("PurchaseRawFruit", _G.SelectedFruit)
            end
        end
    end
end)
Fruit:AddSection("Fruits");
Fruit:AddToggle({
    Title = "Auto Random Fruit",
    Description = "Automatic random devil fruit",
    Default = GetSetting("AutoRandomFruit_Save", false),
    Callback = function(I)
        _G.Random_Auto = I
        _G.SaveData["AutoRandomFruit_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(Sec) do
        pcall(function()
            if _G.Random_Auto then
                replicated.Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end
        end)
    end
end)
Fruit:AddToggle({
    Title = "Auto Store Fruit",
    Description = "Automatic store devil fruit",
    Default = GetSetting("AutoStoreFruit_Save", false),
    Callback = function(I)
        _G.StoreF = I
        _G.SaveData["AutoStoreFruit_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(Sec) do
        if _G.StoreF then
            pcall(function()
                UpdStFruit()
            end)
        end
    end
end)
Fruit:AddToggle({
    Title = "Auto Collect Fruit",
    Description = "Automatic bring devil fruit",
    Default = GetSetting("AutoCollectFruit_Save", false),
    Callback = function(I)
        _G.InstanceF = I
        _G.SaveData["AutoCollectFruit_Save"] = I
        SaveSettings()
    end,
})
task.spawn(function()
    while task.wait(Sec) do
        if _G.InstanceF then
            pcall(function()
                collectFruits(_G.InstanceF)
            end)
        end
    end
end)
Fruit:AddToggle({
    Title = "Notify Fruit Spawn/Drop",
    Description = "Notifies and distinguishes spawned vs dropped fruits",
    Default = GetSetting("NotifyFruit_Save", false),
    Callback = function(Value)
        _G.NotifyFruit = Value
        _G.SaveData["NotifyFruit_Save"] = Value
        SaveSettings()
    end,
})
task.spawn(function()
    workspace.ChildAdded:Connect(function(child)
        if _G.NotifyFruit then
            pcall(function()
                task.wait(0.5)
                if child.Parent and string.find(child.Name, "Fruit") and (child:IsA("Tool") or child:FindFirstChild("Handle")) then
                    local fruitPos = nil
                    if child:FindFirstChild("Handle") then
                        fruitPos = child.Handle.Position
                    elseif child:IsA("BasePart") then
                        fruitPos = child.Position
                    end
                    local isDropped = false
                    local dropperName = "Unknown"
                    if fruitPos then
                        for _, player in pairs(game.Players:GetPlayers()) do
                            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                                local dist = (player.Character.HumanoidRootPart.Position - fruitPos).Magnitude
                                if dist <= 15 then
                                    isDropped = true
                                    dropperName = player.Name
                                    break
                                end
                            end
                        end
                    end
                    local titleMsg = isDropped and "Fruit Dropped" or "Fruit Spawned"
                    local bodyMsg = isDropped and child.Name .. " dropped by " .. dropperName or child.Name .. " spawned on map!"
                    Library:Notify({
                        Title = titleMsg,
                        Content = bodyMsg,
                        Icon = "rbxassetid://10709761889",
                        Time = 4
                    })
                end
            end)
        end
    end)
end)
Setting:AddSection("Codes");
Setting:AddButton({
	Title = "Redeem All Codes",
	Description = "",
	Callback = function()
		local Codes = {
			"KITT_RESET", "Sub2UncleKizaru", "SUB2GAMERROBOT_RESET1", "Sub2Fer999", "Enyu_is_Pro", "JCWK",
			"StarcodeHEO", "MagicBus", "KittGaming", "Sub2CaptainMaui", "Sub2OfficalNoobie", "TheGreatAce",
			"Sub2NoobMaster123", "Sub2Daigrock", "Axiore", "StrawHatMaine", "TantaiGaming", "Bluxxy",
			"SUB2GAMERROBOT_EXP1", "Chandler", "NOMOREHACK", "BANEXPLOIT", "WildDares", "BossBuild",
			"GetPranked", "EARN_FRUITS", "FIGHT4FRUIT", "NOEXPLOITER", "NOOB2ADMIN", "CODESLIDE", "ADMINHACKED",
			"ADMINDARES", "fruitconcepts", "krazydares", "TRIPLEABUSE", "SEATROLLING", "24NOADMIN", "REWARDFUN",
			"NEWTROLL", "fudd10_v2", "Fudd10", "Bignews", "SECRET_ADMIN"
		};
		for _, code in ipairs(Codes) do
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(code);
			end);
		end;
	end,
});
Setting:AddSection("Team");
Setting:AddButton({ Title = "Set Pirate Team", Description = "", Callback = function()
		Pirates();
	end });
Setting:AddButton({ Title = "Set Marine Team", Description = "", Callback = function()
		Marines();
	end });
Setting:AddSection("Others");
HakiSt = {
		"State 0",
		"State 1",
		"State 2",
		"State 3",
		"State 4",
		"State 5",
	};
Setting:AddDropdown({
	Title = "Haki States",
	Description = "",
	Options = HakiSt,
	Default = false,
	Multi = false,
	Callback = function(I)
		_G.SelectStateHaki = I;
	end,
});
Setting:AddButton({ Title = "Change Haki", Description = "", Callback = function()
		if _G.SelectStateHaki == "State 0" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 0);
		elseif _G.SelectStateHaki == "State 1" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 1);
		elseif _G.SelectStateHaki == "State 2" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 2);
		elseif _G.SelectStateHaki == "State 3" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 3);
		elseif _G.SelectStateHaki == "State 4" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 4);
		elseif _G.SelectStateHaki == "State 5" then
			replicated.Remotes.CommF_:InvokeServer("ChangeBusoStage", 5);
		end;
	end });
Setting:AddButton({ Title = "Nofog", Description = "", Callback = function()
		if Lighting:FindFirstChild("LightingLayers") then
			Lighting.LightingLayers:Destroy();
		end;
		if Lighting:FindFirstChild("SeaTerrorCC") then
			Lighting.SeaTerrorCC:Destroy();
		end;
		if Lighting:FindFirstChild("FantasySky") then
			Lighting.FantasySky:Destroy();
		end;
	end });
Setting:AddToggle({
	Title = "Walk on Water",
	Description = "walk on water",
	Default = true,
	Callback = function(I)
		_G.WalkWater_Part = I;
		local e = (game:GetService("Workspace")).Map["WaterBase-Plane"];
		if _G.WalkWater_Part then
			e.Size = Vector3.new(1000, 112, 1000);
		else
			e.Size = Vector3.new(1000, 80, 1000);
		end;
	end,
});
Setting:AddSection("Fps");
Setting:AddButton({ Title = "Fps Boost", Description = "", Callback = function()
		LowCpu();
	end });
local V5 = game.Players.LocalPlayer;
local function y5(I)
	if not I then
		return false;
	end;
	local e = I:FindFirstChild("Humanoid");
	return e and e.Health > 0;
end
local FastAttackModule = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local function SafeWaitForChild(parent, childName)
    local success, result = pcall(function()
        return parent:WaitForChild(childName)
    end)
    if not success or not result then
        warn("SafeWaitForChild falhou: " .. tostring(childName))
    end
    return result
end
local Modules = SafeWaitForChild(ReplicatedStorage, "Modules")
local Net = SafeWaitForChild(Modules, "Net")
local Settings = {
    AutoClick = true,
    ClickDelay = 0
}
local FastAttack = {
    Distance = 100,
    attackMobs = true,
    attackPlayers = true,
    Equipped = nil
}
local RegisterAttack = SafeWaitForChild(Net, "RE/RegisterAttack")
local RegisterHit = SafeWaitForChild(Net, "RE/RegisterHit")
local function IsAlive(character)
    return character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0
end
local function ProcessEnemies(OthersEnemies, Folder)
    local BasePart = nil
    for _, Enemy in ipairs(Folder:GetChildren()) do
        local Head = Enemy:FindFirstChild("Head")
        if Head and IsAlive(Enemy) and Player:DistanceFromCharacter(Head.Position) < FastAttack.Distance then
            if Enemy ~= Player.Character then
                table.insert(OthersEnemies, { Enemy, Head })
                BasePart = Head
            end
        end
    end
    return BasePart
end
function FastAttack:Attack(BasePart, OthersEnemies)
    if not BasePart or #OthersEnemies == 0 then return end
    pcall(function()
        RegisterAttack:FireServer(Settings.ClickDelay or 0)
        RegisterHit:FireServer(BasePart, OthersEnemies)
    end)
end
function FastAttack:AttackNearest()
    local OthersEnemies = {}
    local EnemiesFolder = workspace:FindFirstChild("Enemies")
    local CharactersFolder = workspace:FindFirstChild("Characters")
    local Part1 = nil
    local Part2 = nil
    if EnemiesFolder then Part1 = ProcessEnemies(OthersEnemies, EnemiesFolder) end
    if CharactersFolder then Part2 = ProcessEnemies(OthersEnemies, CharactersFolder) end
    local character = Player.Character
    if not character then return end
    local equippedWeapon = character:FindFirstChildOfClass("Tool")
    if equippedWeapon and equippedWeapon:FindFirstChild("LeftClickRemote") then
        for _, enemyData in ipairs(OthersEnemies) do
            local enemy = enemyData[1]
            if enemy and enemy:FindFirstChild("HumanoidRootPart") and character:FindFirstChild("HumanoidRootPart") then
                local direction = (enemy.HumanoidRootPart.Position - character:GetPivot().Position).Unit
                pcall(function()
                    equippedWeapon.LeftClickRemote:FireServer(direction, 1)
                end)
            end
        end
    elseif #OthersEnemies > 0 then
        self:Attack(Part1 or Part2, OthersEnemies)
    else
        task.wait(0)
    end
end
function FastAttack:BladeHits()
    local Equipped = IsAlive(Player.Character) and Player.Character:FindFirstChildOfClass("Tool")
    if Equipped and Equipped.ToolTip ~= "Gun" then
        self:AttackNearest()
    else
        task.wait(0)
    end
end
task.spawn(function()
    while task.wait(Settings.ClickDelay) do
        if Settings.AutoClick then
            FastAttack:BladeHits()
        end
    end
end)
getgenv().rz_FastAttack = FastAttack
FastAttackModule.FastAttack = FastAttack
return FastAttackModule