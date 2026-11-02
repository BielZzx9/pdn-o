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
if World1 then
	Boss = {
			"The Gorilla King",
			"Bobby",
			"The Saw",
			"Yeti",
			"Mob Leader",
			"Vice Admiral",
			"Saber Expert",
			"Warden",
			"Chief Warden",
			"Swan",
			"Magma Admiral",
			"Fishman Lord",
			"Wysper",
			"Thunder God",
			"Cyborg",
			"Ice Admiral",
			"Greybeard",
		};
elseif World2 then
	Boss = {
			"Diamond",
			"Jeremy",
			"Fajita",
			"Don Swan",
			"Smoke Admiral",
			"Awakened Ice Admiral",
			"Tide Keeper",
			"Darkbeard",
			"Cursed Captain",
			"Order",
		};
elseif World3 then
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
if World1 then
	MaterialList = {
			"Leather + Scrap Metal",
			"Angel Wings",
			"Magma Ore",
			"Fish Tail",
		};
elseif World2 then
	MaterialList = {
			"Leather + Scrap Metal",
			"Radioactive Material",
			"Ectoplasm",
			"Mystic Droplet",
			"Magma Ore",
			"Vampire Fang",
		};
elseif World3 then
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
    if not (hum and hum.Sit) then
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
		if World1 then
			if _G.FindBoss == "The Gorilla King" then
				bMon = "The Gorilla King";
				Qname = "JungleQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102);
				PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, .707079291, 0, 1, 0, -0.707079291, 0, -0.707134247);
			elseif _G.FindBoss == "Bobby" then
				bMon = "Bobby";
				Qname = "BuggyQuest1";
				Qdata = 3;
				PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188);
				PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344);
			elseif _G.FindBoss == "The Saw" then
				bMon = "The Saw";
				PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906);
			elseif _G.FindBoss == "Yeti" then
				bMon = "Yeti";
				Qname = "SnowQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156);
				PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172);
			elseif _G.FindBoss == "Mob Leader" then
				bMon = "Mob Leader";
				PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813);
			elseif _G.FindBoss == "Vice Admiral" then
				bMon = "Vice Admiral";
				Qname = "MarineQuest2";
				Qdata = 2;
				PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625);
				PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375);
			elseif _G.FindBoss == "Saber Expert" then
				bMon = "Saber Expert";
				PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564);
			elseif _G.FindBoss == "Warden" then
				bMon = "Warden";
				Qname = "ImpelQuest";
				Qdata = 1;
				PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, .220546961, -4.49946401e-06, .975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, .220546961);
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
			elseif _G.FindBoss == "Chief Warden" then
				bMon = "Chief Warden";
				Qname = "ImpelQuest";
				Qdata = 2;
				PosB = CFrame.new(5206.92578, .997753382, 814.976746, .342041343, -0.00062915677, .939684749, .00191645394, .999998152, -2.80422337e-05, -0.939682961, .00181045406, .342041939);
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
			elseif _G.FindBoss == "Swan" then
				bMon = "Swan";
				Qname = "ImpelQuest";
				Qdata = 3;
				PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, .951042235, 0, 1, 0, -0.951042235, 0, -0.309060812);
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
			elseif _G.FindBoss == "Magma Admiral" then
				bMon = "Magma Admiral";
				Qname = "MagmaQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875);
				PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875);
			elseif _G.FindBoss == "Fishman Lord" then
				bMon = "Fishman Lord";
				Qname = "FishmanQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
				PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984);
			elseif _G.FindBoss == "Wysper" then
				bMon = "Wysper";
				Qname = "SkyExp1Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094);
				PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531);
			elseif _G.FindBoss == "Thunder God" then
				bMon = "Thunder God";
				Qname = "SkyExp2Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125);
				PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188);
			elseif _G.FindBoss == "Cyborg" then
				bMon = "Cyborg";
				Qname = "FountainQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875);
				PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813);
			elseif _G.FindBoss == "Ice Admiral" then
				bMon = "Ice Admiral";
				Qdata = nil;
				PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, .81913656, 0, -0.573599219);
				PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, .81913656, 0, -0.573599219);
			elseif _G.FindBoss == "Greybeard" then
				bMon = "Greybeard";
				Qdata = nil;
				PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188);
				PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188);
			end;
		end;
		if World2 then
			if _G.FindBoss == "Diamond" then
				bMon = "Diamond";
				Qname = "Area1Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375);
				PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407);
			elseif _G.FindBoss == "Jeremy" then
				bMon = "Jeremy";
				Qname = "Area2Quest";
				Qdata = 3;
				PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063);
				PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109);
			elseif _G.FindBoss == "Fajita" then
				bMon = "Fajita";
				Qname = "MarineQuest3";
				Qdata = 3;
				PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031);
				PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625);
			elseif _G.FindBoss == "Don Swan" then
				bMon = "Don Swan";
				PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875);
			elseif _G.FindBoss == "Smoke Admiral" then
				bMon = "Smoke Admiral";
				Qname = "IceSideQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813);
				PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875);
			elseif _G.FindBoss == "Awakened Ice Admiral" then
				bMon = "Awakened Ice Admiral";
				Qname = "FrostQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813);
				PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125);
			elseif _G.FindBoss == "Tide Keeper" then
				bMon = "Tide Keeper";
				Qname = "ForgottenQuest";
				Qdata = 3;
				PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625);
				PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188);
			elseif _G.FindBoss == "Darkbeard" then
				bMon = "Darkbeard";
				Qdata = nil;
				PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531);
				PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531);
			elseif _G.FindBoss == "Cursed Captaim" then
				bMon = "Cursed Captain";
				Qdata = nil;
				PosQBoss = CFrame.new(916.928589, 181.092773, 33422);
				PosB = CFrame.new(916.928589, 181.092773, 33422);
			elseif _G.FindBoss == "Order" then
				bMon = "Order";
				Qdata = nil;
				PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875);
				PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875);
			end;
		end;
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
    if World1 and I > 699 then
        I = 650 
    end
    if World2 and I > 1499 then
        I = 1450 
    end
    if World1 then
        if I == 1 or I <= 9 then
            if tostring(TeamSelf) == "Marines" then
                Mon = "Trainee"
                Qname = "MarineQuest"
                Qdata = 1
                NameMon = "Trainee"
                PosM = CFrame.new(-2709.67944, 24.5206585, 2104.24585)
                PosQ = CFrame.new(-2709.67944, 24.5206585, 2104.24585)
            elseif tostring(TeamSelf) == "Pirates" then
                Mon = "Bandit"
                Qdata = 1
                Qname = "BanditQuest1"
                NameMon = "Bandit"
                PosM = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125)
                PosQ = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125)
            end
        elseif I >= 10 and I <= 14 then
            Mon = "Monkey"
            Qdata = 1
            Qname = "JungleQuest"
            NameMon = "Monkey"
            PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            PosM = CFrame.new(-1448.5180664062, 67.853012084961, 11.465796470642)
        elseif I >= 15 and I <= 29 then
            Mon = "Gorilla"
            Qdata = 2
            Qname = "JungleQuest"
            NameMon = "Gorilla"
            PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838)
            PosM = CFrame.new(-1129.8836669922, 40.46354675293, -525.42370605469)
        elseif I >= 30 and I <= 39 then
            Mon = "Pirate"
            Qdata = 1
            Qname = "BuggyQuest1"
            NameMon = "Pirate"
            PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            PosM = CFrame.new(-1103.5134277344, 13.752052307129, 3896.0910644531)
        elseif I >= 40 and I <= 59 then
            Mon = "Brute"
            Qdata = 2
            Qname = "BuggyQuest1"
            NameMon = "Brute"
            PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
            PosM = CFrame.new(-1140.0837402344, 14.809885025024, 4322.9213867188)
        elseif I >= 60 and I <= 74 then
            Mon = "Desert Bandit"
            Qdata = 1
            Qname = "DesertQuest"
            NameMon = "Desert Bandit"
            PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359)
            PosM = CFrame.new(924.7998046875, 6.4486746788025, 4481.5859375)
        elseif I >= 75 and I <= 89 then
            Mon = "Desert Officer"
            Qdata = 2
            Qname = "DesertQuest"
            NameMon = "Desert Officer"
            PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359)
            PosM = CFrame.new(1608.2822265625, 8.6142244338989, 4371.0073242188)
        elseif I >= 90 and I <= 99 then
            Mon = "Snow Bandit"
            Qdata = 1
            Qname = "SnowQuest"
            NameMon = "Snow Bandit"
            PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            PosM = CFrame.new(1354.3479003906, 87.272773742676, -1393.9465332031)
        elseif I >= 100 and I <= 119 then
            Mon = "Snowman"
            Qdata = 2
            Qname = "SnowQuest"
            NameMon = "Snowman"
            PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796)
            PosM = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625)
        elseif I >= 120 and I <= 149 then
            Mon = "Chief Petty Officer"
            Qdata = 1
            Qname = "MarineQuest2"
            NameMon = "Chief Petty Officer"
            PosQ = CFrame.new(-5039.58643, 27.3500385, 4324.68018)
            PosM = CFrame.new(-4881.2309570312, 22.652044296265, 4273.7524414062)
        elseif I >= 150 and I <= 174 then
            Mon = "Sky Bandit"
            Qdata = 1
            Qname = "SkyQuest"
            NameMon = "Sky Bandit"
            PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            PosM = CFrame.new(-4953.20703125, 295.74420166016, -2899.2290039062)
        elseif I >= 175 and I <= 189 then
            Mon = "Dark Master"
            Qdata = 2
            Qname = "SkyQuest"
            NameMon = "Dark Master"
            PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165)
            PosM = CFrame.new(-5259.8447265625, 391.39767456055, -2229.0354003906)
        elseif I >= 190 and I <= 209 then
            Mon = "Prisoner"
            Qdata = 1
            Qname = "PrisonerQuest"
            NameMon = "Prisoner"
            PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514)
            PosM = CFrame.new(5098.9736328125, -0.3204058110714, 474.23733520508)
        elseif I >= 210 and I <= 249 then
            Mon = "Dangerous Prisoner"
            Qdata = 2
            Qname = "PrisonerQuest"
            NameMon = "Dangerous Prisoner"
            PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514)
            PosM = CFrame.new(5654.5634765625, 15.633401870728, 866.29919433594)
        elseif I >= 250 and I <= 274 then
            Mon = "Toga Warrior"
            Qdata = 1
            Qname = "ColosseumQuest"
            NameMon = "Toga Warrior"
            PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            PosM = CFrame.new(-1820.21484375, 51.683856964111, -2740.6650390625)
        elseif I >= 275 and I <= 299 then
            Mon = "Gladiator"
            Qdata = 2
            Qname = "ColosseumQuest"
            NameMon = "Gladiator"
            PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
            PosM = CFrame.new(-1292.8381347656, 56.380882263184, -3339.0314941406)
        elseif I >= 300 and I <= 324 then
            Mon = "Military Soldier"
            Qdata = 1
            Qname = "MagmaQuest"
            NameMon = "Military Soldier"
            PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            PosM = CFrame.new(-5411.1645507812, 11.081554412842, 8454.29296875)
        elseif I >= 325 and I <= 374 then
            Mon = "Military Spy"
            Qdata = 2
            Qname = "MagmaQuest"
            NameMon = "Military Spy"
            PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
            PosM = CFrame.new(-5802.8681640625, 86.262413024902, 8828.859375)
        elseif I >= 375 and I <= 399 then
            Mon = "Fishman Warrior"
            Qdata = 1
            Qname = "FishmanQuest"
            NameMon = "Fishman Warrior"
            PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            PosM = CFrame.new(60878.30078125, 18.482830047607, 1543.7574462891)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif I >= 400 and I <= 449 then
            Mon = "Fishman Commando"
            Qdata = 2
            Qname = "FishmanQuest"
            NameMon = "Fishman Commando"
            PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            PosM = CFrame.new(61922.6328125, 18.482830047607, 1493.9343261719)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif I >= 450 and I <= 474 then
            Mon = "God's Guard"
            Qdata = 1
            Qname = "SkyExp1Quest"
            NameMon = "God's Guard"
            PosQ = CFrame.new(-4721.88867, 843.874695, -1949.96643)
            PosM = CFrame.new(-4710.04296875, 845.27697753906, -1927.3079833984)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-4607.82275, 872.54248, -1667.55688))
            end
        elseif I >= 475 and I <= 524 then
            Mon = "Shanda"
            Qdata = 2
            Qname = "SkyExp1Quest"
            NameMon = "Shanda"
            PosQ = CFrame.new(-7859.09814, 5544.19043, -381.476196)
            PosM = CFrame.new(-7678.4897460938, 5566.4038085938, -497.21560668945)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 10000 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
            end
        elseif I >= 525 and I <= 549 then
            Mon = "Royal Squad"
            Qdata = 1
            Qname = "SkyExp2Quest"
            NameMon = "Royal Squad"
            PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            PosM = CFrame.new(-7624.2524414062, 5658.1333007812, -1467.3542480469)
        elseif I >= 550 and I <= 624 then
            Mon = "Royal Soldier"
            Qdata = 2
            Qname = "SkyExp2Quest"
            NameMon = "Royal Soldier"
            PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
            PosM = CFrame.new(-7836.7534179688, 5645.6640625, -1790.6236572266)
        elseif I >= 625 and I <= 649 then
            Mon = "Galley Pirate"
            Qdata = 1
            Qname = "FountainQuest"
            NameMon = "Galley Pirate"
            PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            PosM = CFrame.new(5551.0219726562, 78.901351928711, 3930.4128417969)
        elseif I >= 650 then
            Mon = "Galley Captain"
            Qdata = 2
            Qname = "FountainQuest"
            NameMon = "Galley Captain"
            PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293)
            PosM = CFrame.new(5441.9516601562, 42.502059936523, 4950.09375)
        end
    elseif World2 then
        if I >= 700 and I <= 724 then
            Mon = "Raider"
            Qdata = 1
            Qname = "Area1Quest"
            NameMon = "Raider"
            PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            PosM = CFrame.new(-728.32672119141, 52.779319763184, 2345.7705078125)
        elseif I >= 725 and I <= 774 then
            Mon = "Mercenary"
            Qdata = 2
            Qname = "Area1Quest"
            NameMon = "Mercenary"
            PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188)
            PosM = CFrame.new(-1004.3244018555, 80.158866882324, 1424.6193847656)
        elseif I >= 775 and I <= 799 then
            Mon = "Swan Pirate"
            Qdata = 1
            Qname = "Area2Quest"
            NameMon = "Swan Pirate"
            PosQ = CFrame.new(638.43811, 71.769989, 918.282898)
            PosM = CFrame.new(1068.6643066406, 137.61428833008, 1322.1060791016)
        elseif I >= 800 and I <= 874 then
            Mon = "Factory Staff"
            Qname = "Area2Quest"
            Qdata = 2
            NameMon = "Factory Staff"
            PosQ = CFrame.new(632.698608, 73.1055908, 918.666321)
            PosM = CFrame.new(73.078674316406, 81.863441467285, -27.470672607422)
        elseif I >= 875 and I <= 899 then
            Mon = "Marine Lieutenant"
            Qdata = 1
            Qname = "MarineQuest3"
            NameMon = "Marine Lieutenant"
            PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
            PosM = CFrame.new(-2821.3723144531, 75.897277832031, -3070.0891113281)
        elseif I >= 900 and I <= 949 then
            Mon = "Marine Captain"
            Qdata = 2
            Qname = "MarineQuest3"
            NameMon = "Marine Captain"
            PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812)
            PosM = CFrame.new(-1861.2310791016, 80.176582336426, -3254.6975097656)
        elseif I >= 950 and I <= 974 then
            Mon = "Zombie"
            Qdata = 1
            Qname = "ZombieQuest"
            NameMon = "Zombie"
            PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            PosM = CFrame.new(-5657.7768554688, 78.969734191895, -928.68701171875)
        elseif I >= 975 and I <= 999 then
            Mon = "Vampire"
            Qdata = 2
            Qname = "ZombieQuest"
            NameMon = "Vampire"
            PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061)
            PosM = CFrame.new(-6037.66796875, 32.184638977051, -1340.6597900391)
        elseif I >= 1000 and I <= 1049 then
            Mon = "Snow Trooper"
            Qdata = 1
            Qname = "SnowMountainQuest"
            NameMon = "Snow Trooper"
            PosQ = CFrame.new(609.858826, 400.119904, -5372.25928)
            PosM = CFrame.new(549.14733886719, 427.38705444336, -5563.6987304688)
        elseif I >= 1050 and I <= 1099 then
            Mon = "Winter Warrior"
            Qdata = 2
            Qname = "SnowMountainQuest"
            NameMon = "Winter Warrior"
            PosQ = CFrame.new(609.858826, 400.119904, -5372.25928)
            PosM = CFrame.new(1142.7451171875, 475.63980102539, -5199.4165039062)
        elseif I >= 1100 and I <= 1124 then
            Mon = "Lab Subordinate"
            Qdata = 1
            Qname = "IceSideQuest"
            NameMon = "Lab Subordinate"
            PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
            PosM = CFrame.new(-5707.4716796875, 15.951709747314, -4513.3920898438)
        elseif I >= 1125 and I <= 1174 then
            Mon = "Horned Warrior"
            Qdata = 2
            Qname = "IceSideQuest"
            NameMon = "Horned Warrior"
            PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852)
            PosM = CFrame.new(-6341.3666992188, 15.951770782471, -5723.162109375)
        elseif I >= 1175 and I <= 1199 then
            Mon = "Magma Ninja"
            Qdata = 1
            Qname = "FireSideQuest"
            NameMon = "Magma Ninja"
            PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457)
            PosM = CFrame.new(-5449.6728515625, 76.658744812012, -5808.2006835938)
        elseif I >= 1200 and I <= 1249 then
            Mon = "Lava Pirate"
            Qdata = 2
            Qname = "FireSideQuest"
            NameMon = "Lava Pirate"
            PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457)
            PosM = CFrame.new(-5213.3315429688, 49.737880706787, -4701.451171875)
        elseif I >= 1250 and I <= 1274 then
            Mon = "Ship Deckhand"
            Qdata = 1
            Qname = "ShipQuest1"
            NameMon = "Ship Deckhand"
            PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016)
            PosM = CFrame.new(1212.0111083984, 150.79205322266, 33059.24609375)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif I >= 1275 and I <= 1299 then
            Mon = "Ship Engineer"
            Qdata = 2
            Qname = "ShipQuest1"
            NameMon = "Ship Engineer"
            PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016)
            PosM = CFrame.new(919.47863769531, 43.544013977051, 32779.96875)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif I >= 1300 and I <= 1324 then
            Mon = "Ship Steward"
            Qdata = 1
            Qname = "ShipQuest2"
            NameMon = "Ship Steward"
            PosQ = CFrame.new(968.80957, 125.092171, 33244.125)
            PosM = CFrame.new(919.43853759766, 129.55599975586, 33436.03515625)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif I >= 1325 and I <= 1349 then
            Mon = "Ship Officer"
            Qdata = 2
            Qname = "ShipQuest2"
            NameMon = "Ship Officer"
            PosQ = CFrame.new(968.80957, 125.092171, 33244.125)
            PosM = CFrame.new(1036.0179443359, 181.4390411377, 33315.7265625)
            if _G.Level and (PosQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 500 then
                replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif I >= 1350 and I <= 1374 then
            Mon = "Arctic Warrior"
            Qdata = 1
            Qname = "FrostQuest"
            NameMon = "Arctic Warrior"
            PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            PosM = CFrame.new(5966.24609375, 62.970020294189, -6179.3828125)
        elseif I >= 1375 and I <= 1424 then
            Mon = "Snow Lurker"
            Qdata = 2
            Qname = "FrostQuest"
            NameMon = "Snow Lurker"
            PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984)
            PosM = CFrame.new(5407.0737304688, 69.194374084473, -6880.8803710938)
        elseif I >= 1425 and I <= 1449 then
            Mon = "Sea Soldier"
            Qdata = 1
            Qname = "ForgottenQuest"
            NameMon = "Sea Soldier"
            PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            PosM = CFrame.new(-3028.2236328125, 64.674514770508, -9775.4267578125)
        elseif I >= 1450 then
            Mon = "Water Fighter"
            Qdata = 2
            Qname = "ForgottenQuest"
            NameMon = "Water Fighter"
            PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193)
            PosM = CFrame.new(-3352.9013671875, 285.01556396484, -10534.841796875)
        end
    elseif World3 then
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
		if World1 then
			if SelectMaterial == "Angel Wings" then
				MMon = {
						"Shanda",
						"Royal Squad",
						"Royal Soldier",
						"Wysper",
						"Thunder God",
					};
				MPos = CFrame.new(-4698, 845, -1912);
				SP = "Default";
				local I = Vector3.new(-4607.82275, 872.54248, -1667.55688);
				shouldRequestEntrance(I, 10000);
			elseif SelectMaterial == "Leather + Scrap Metal" then
				MMon = { "Brute", "Pirate" };
				MPos = CFrame.new(-1145, 15, 4350);
				SP = "Default";
			elseif SelectMaterial == "Magma Ore" then
				MMon = { "Military Soldier", "Military Spy", "Magma Admiral" };
				MPos = CFrame.new(-5815, 84, 8820);
				SP = "Default";
			elseif SelectMaterial == "Fish Tail" then
				MMon = { "Fishman Warrior", "Fishman Commando", "Fishman Lord" };
				MPos = CFrame.new(61123, 19, 1569);
				SP = "Default";
				local I = Vector3.new(61163.8515625, 5.342342376709, 1819.7841796875);
				shouldRequestEntrance(I, 17000);
			end;
		elseif World2 then
			if SelectMaterial == "Leather + Scrap Metal" then
				MMon = { "Marine Captain" };
				MPos = CFrame.new(-2010.5059814453, 73.001159667969, -3326.6208496094);
				SP = "Default";
			elseif SelectMaterial == "Magma Ore" then
				MMon = { "Magma Ninja", "Lava Pirate" };
				MPos = CFrame.new(-5428, 78, -5959);
				SP = "Default";
			elseif SelectMaterial == "Ectoplasm" then
    MMon = {
            "Ship Deckhand",
            "Ship Engineer",
            "Ship Steward",
            "Ship Officer",
        };
    MPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625);
    SP = "Default";
    local I = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125);
    shouldRequestEntrance(I, 1000); 
			elseif SelectMaterial == "Mystic Droplet" then
				MMon = { "Water Fighter" };
				MPos = CFrame.new(-3385, 239, -10542);
				SP = "Default";
			elseif SelectMaterial == "Radioactive Material" then
				MMon = { "Factory Staff" };
				MPos = CFrame.new(295, 73, -56);
				SP = "Default";
			elseif SelectMaterial == "Vampire Fang" then
				MMon = { "Vampire" };
				MPos = CFrame.new(-6033, 7, -1317);
				SP = "Default";
			end;
		elseif World3 then
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
do
    local ok, install = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/BielZzx9/pdn-o/main/ToshiroHub/Search.lua"))()
    end)
    if ok and type(install) == "function" then
        pcall(install, Library)
    end
end
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
local Fish = Library:MakeTab({
    Title = "Fish",
    Icon = "rbxassetid://127664059821666"
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
if World2 then
    local LegendarySword = Status:AddParagraph("Legendary Sword", "Status: âï¸")
    spawn(function()
        pcall(function()
            while wait() do
                local rs = game:GetService("ReplicatedStorage").Remotes.CommF_
                if rs:InvokeServer("LegendarySwordDealer", "1") then
                    LegendarySword:SetDesc("Shisui")
                elseif rs:InvokeServer("LegendarySwordDealer", "2") then
                    LegendarySword:SetDesc("Wando")
                elseif rs:InvokeServer("LegendarySwordDealer", "3") then
                    LegendarySword:SetDesc("Saddi")
                else
                    LegendarySword:SetDesc("Not Found")
                end
            end
        end)
    end)
end
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
if World2 then
Farm:AddToggle({
    Title = "Auto Factory",
    Description = "Auto factory raid in world 2",
    Default = GetSetting("AutoFactory_Save", false),
    Callback = function(Value)
        _G.AutoFactory = Value
        _G.SaveData["AutoFactory_Save"] = Value
        SaveSettings()
    end,
})
spawn(function()
    local FactoryPos = CFrame.new(448.46756, 199.356781, -441.389252)
    while task.wait(Sec) do
        pcall(function()
            if not _G.AutoFactory then return end
            local Core = GetConnectionEnemies("Core")
            if Core and Core:FindFirstChild("Humanoid") and Core.Humanoid.Health > 0 then
                repeat
                    task.wait()
                    if not _G.AutoFactory then break end
                    if not Core or not Core.Parent then break end
                    if Core.Humanoid.Health <= 0 then break end
                    if _G.SelectWeapon then
                        EquipWeapon(_G.SelectWeapon)
                    end
                    _tp(FactoryPos)
                until Core.Humanoid.Health <= 0 or _G.AutoFactory == false
            else
                _tp(FactoryPos)
            end
        end)
    end
end)
end
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
Setting:AddSection("Server");
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
	Default = GetSetting("AutoAttack_Save", falss),
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
    Max = 1000,
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
        _G.AutoRipIngay = I
        _G.SaveData["AutoRipIndra_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoRipIngay then
				local I = GetConnectionEnemies("rip_indra");
				if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and I then
					repeat
						wait();
						G.Kill(I, _G.AutoRipIngay);
					until not _G.AutoRipIngay or not I.Parent or I.Humanoid.Health <= 0;
				else
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, .914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899));
					wait(.1);
					_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781));
				end;
			end;
		end);
	end;
end);
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
Others:AddToggle({
 Title = "Auto Farm Darkbeard",
	Description = "Auto farm raid boss darkbeard",
	Default = false,
	Callback = function(I)
		_G.Auto_Def_DarkCoat = I;
	end,
});
spawn(function()
	while wait(.1) do
		if _G.Auto_Def_DarkCoat then
			pcall(function()
				if GetBP("Fist of Darkness") and not workspace.Enemies:FindFirstChild("Darkbeard") then
					_tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531));
				elseif GetConnectionEnemies("Darkbeard") then
					local I = GetConnectionEnemies("Darkbeard");
					if I then
						repeat
							wait();
							G.Kill(I, _G.Auto_Def_DarkCoat);
						until _G.Auto_Def_DarkCoat == false or not I.Parent or I.Humanoid.Helath <= 0;
					end;
				elseif not GetBP("Fist of Darkness") and not GetConnectionEnemies("Darkbeard") then
					repeat
						wait(.1);
						_G.AutoFarmChest = true;
					until not _G.Auto_Def_DarkCoat or GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard");
					_G.AutoFarmChest = false;
				end;
			end);
		end;
	end;
end);
_G.AutoCursedCaptain = _G.AutoCursedCaptain or false
Others:AddToggle({
    Title = "Auto Cursed Captain",
    Description = "",
    Default = _G.AutoCursedCaptain,
    Callback = function(v)
        _G.AutoCursedCaptain = v
    end
})
spawn(function()
    while task.wait() do
        pcall(function()
            if not _G.AutoCursedCaptain then return end
            local Players = game:GetService("Players")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local Workspace = game:GetService("Workspace")
            local Plr = Players.LocalPlayer
            local Char = Plr.Character or Plr.CharacterAdded:Wait()
            local Root = Char:FindFirstChild("HumanoidRootPart")
            if not Root then return end
            local InsidePos = Vector3.new(923,126,32852)
            local Boss = nil
            local function InPlace()
                return (Root.Position - InsidePos).Magnitude < 2000
            end
            if not InPlace() then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", InsidePos)
                task.wait(1)
            end
            if Workspace:FindFirstChild("Enemies") then
                for _, v in pairs(Workspace.Enemies:GetChildren()) do
                    if v.Name == "Cursed Captain" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        Boss = v
                        break
                    end
                end
            end
            if not Boss then
                repeat
                    task.wait(1)
                    if not InPlace() then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", InsidePos)
                    end
                    if Workspace:FindFirstChild("Enemies") then
                        for _, v in pairs(Workspace.Enemies:GetChildren()) do
                            if v.Name == "Cursed Captain" and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                Boss = v
                                break
                            end
                        end
                    end
                until Boss or not _G.AutoCursedCaptain
            end
            if Boss and Boss:FindFirstChild("HumanoidRootPart") then
                repeat
                    task.wait()
                    if not InPlace() then
                        ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", InsidePos)
                        task.wait(1)
                    end
                    if _tp then
                        _tp(Boss.HumanoidRootPart.CFrame * CFrame.new(0,20,0))
                    else
                        Root.CFrame = Boss.HumanoidRootPart.CFrame * CFrame.new(0,20,0)
                    end
                    if G and G.Kill then
                        G.Kill(Boss, true)
                    end
                until not _G.AutoCursedCaptain
                or not Boss.Parent
                or Boss.Humanoid.Health <= 0
                or not Root.Parent
            end
        end)
    end
end)
if World2 then
Others:AddSection("True Triple Katana Sword");
Others:AddToggle({
 Title = "Auto Buy Legendary Sword",
    Description = "",
    Default = GetSetting("TpLegendarySword_Save", false),
    Callback = function(I)
        _G.Tp_LgS = I
        _G.SaveData["TpLegendarySword_Save"] = I
        SaveSettings()
        if I then
            spawn(function()
                while _G.Tp_LgS do
                    pcall(function()
                        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1")
                        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2")
                        replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3")
                    end)
                    wait(1) 
                end
            end)
        end
    end,
})
Others:AddToggle({
 Title = "Teleport Legendary Sword Dealer",
    Description = "",
    Default = GetSetting("TpLegendarySword_Save", false),
    Callback = function(I)
        _G.Tp_LgS = I
        _G.SaveData["TpLegendarySword_Save"] = I
        SaveSettings()
    end,
})
spawn(function()
	while wait(Sec) do
		if _G.Tp_LgS then
			pcall(function()
				for I, e in pairs(replicated.NPCs:GetChildren()) do
					if e.Name == "Legendary Sword Dealer " then
						_tp(e.HumanoidRootPart.CFrame);
					end;
				end;
			end);
		end;
	end;
end);
end
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
if World2 then
Others:AddSection("Sea 2 Itens");
Others:AddToggle({
 Title = "Auto Rengoku Sword",
    Description = "",
    Default = false,
    Callback = function(I)
        _G.AutoKeyRen = I
    end,
})
spawn(function()
    while wait(0.1) do
        pcall(function()
            if _G.AutoKeyRen then
                if plr.Backpack:FindFirstChild(K[3]) or plr.Character:FindFirstChild(K[3]) then
                    EquipWeapon(K[3])
                    wait(0.1)
                    _tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                else
                    local enemy = GetConnectionEnemies("Awakened Ice Admiral")
                    if enemy then
                        repeat
                            task.wait()
                            G.Kill(enemy, _G.AutoKeyRen)
                        until plr.Backpack:FindFirstChild(K[3]) 
                            or not enemy.Parent 
                            or enemy.Humanoid.Health <= 0 
                            or _G.AutoKeyRen == false
                    else
                        _tp(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
                        wait(1)
                    end
                end
            end
        end)
    end
end)
Others:AddToggle({
 Title = "Auto Dragon Trident",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.AutoTridentW2 = I;
	end,
});
spawn(function()
	while wait(.1) do
		pcall(function()
			if _G.AutoTridentW2 then
				local I = GetConnectionEnemies("Tide Keeper");
				if I then
					repeat
						task.wait();
						G.Kill(I, _G.AutoTridentW2);
					until _G.AutoTridentW2 == false or not I.Parent or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188));
				end;
			end;
		end);
	end;
end);
Others:AddToggle({
 Title = "Auto Long Sword",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.LongsWord = I;
	end,
});
spawn(function()
	while wait(.1) do
		pcall(function()
			if _G.LongsWord then
				local I = GetConnectionEnemies("Diamond");
				if I then
					repeat
						task.wait();
						G.Kill(I, _G.LongsWord);
					until _G.LongsWord == false or not I.Parent or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407));
				end;
			end;
		end);
	end;
end);
Others:AddToggle({
 Title = "Auto Black Spikey",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.BlackSpikey = I;
	end,
});
spawn(function()
	while wait(.1) do
		if _G.BlackSpikey then
			pcall(function()
				local I = GetConnectionEnemies("Jeremy");
				if I then
					repeat
						wait();
						G.Kill(I, _G.BlackSpikey);
					until _G.BlackSpikey == false or not I.Parent or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109));
				end;
			end);
		end;
	end;
end);
Others:AddToggle({
 Title = "Auto Midnight Blade",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.AutoEcBoss = I;
	end,
});
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoEcBoss then
				if GetM("Ectoplasm") >= 99 then
					replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 3);
				elseif GetM("Ectoplasm") <= 99 then
					local I = GetConnectionEnemies("Cursed Captain");
					if I then
						repeat
							wait();
							G.Kill(I, _G.AutoEcBoss);
						until not _G.AutoEcBoss or not I.Parent or I.Humanoid.Health <= 0;
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125));
						wait(.5);
						_tp(CFrame.new(916.928589, 181.092773, 33422));
					end;
				end;
			end;
		end);
	end;
end);
Others:AddToggle({
 Title = "Auto Swan Glasses",
	Description = "",
	Default = false,
	Callback = function(I)
		_G.Auto_SwanGG = I;
	end,
});
spawn(function()
	while wait(.2) do
		if _G.Auto_SwanGG then
			pcall(function()
				local I = GetConnectionEnemies("Don Swan");
				if I then
					repeat
						wait();
						G.Kill(I, _G.Auto_SwanGG);
					until _G.Auto_SwanGG == false or not I.Parent or I.Humanoid.Health <= 0;
				else
					_tp(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875));
				end;
			end);
		end;
	end;
end);
end
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
if World2 then
    Esp:AddToggle({Title = "Esp Flower", Default = false, Callback = function(I)
        FlowerESP = I
        task.spawn(function() while FlowerESP do pcall(flowerEsp); task.wait(1) end end)
    end})
    Esp:AddToggle({Title = "Esp Legendary Sword", Default = false, Callback = function(I)
        LegenS = I
        task.spawn(function() while LegenS do pcall(LegenSword); task.wait(1) end end)
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