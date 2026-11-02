return function(tab)
 local env=getgenv()
 local retired=env.__ToshiroSilentGun
 if retired and retired.version=="screen" then return retired end
 if retired then
  retired.enabled=false
  if retired.connection then retired.connection:Disconnect() end
  local previous=retired.directPrevious or (retired.hookKind=="FireServer" and retired.previous)
  if previous and retired.remote then hookfunction(retired.remote.FireServer,previous) end
 end
 local player=game:GetService("Players").LocalPlayer
 local input=game:GetService("UserInputService")
 local insetService=game:GetService("GuiService")
 local aim=require(game:GetService("ReplicatedStorage").Controllers.CombatController.AimAssist)
 local original=aim.getTargetInfo
 local info=debug.info
 local state={version="screen",enabled=false,mode="Near Mouse",radius=160,redirected=0,calls=0}
 local gui=Instance.new("ScreenGui")
 gui.Name="ToshiroGunRadius"
 gui.IgnoreGuiInset=true
 gui.ResetOnSpawn=false
 gui.DisplayOrder=20
 gui.Parent=gethui and gethui() or game:GetService("CoreGui")
 local circle=Instance.new("Frame")
 circle.AnchorPoint=Vector2.new(0.5,0.5)
 circle.BackgroundTransparency=1
 circle.Visible=false
 circle.Parent=gui
 local corner=Instance.new("UICorner")
 corner.CornerRadius=UDim.new(0.5,0)
 corner.Parent=circle
 local stroke=Instance.new("UIStroke")
 stroke.Color=Color3.fromRGB(145,135,255)
 stroke.Thickness=1
 stroke.Parent=circle
 local function choose()
  state.part,state.point=nil,nil
  local cam=workspace.CurrentCamera
  local char=player.Character
  local root=char and char:FindFirstChild("HumanoidRootPart")
  local tool=char and char:FindFirstChildOfClass("Tool")
  if not state.enabled or not cam or not root or not tool or tool.ToolTip~="Gun" then return end
  local mouse=input:GetMouseLocation()-insetService:GetGuiInset()
  local origin=state.mode=="Full Screen" and cam.ViewportSize/2 or mouse
  local limit=state.mode=="Full Screen" and math.huge or state.radius
  local enemies=workspace:FindFirstChild("Enemies")
  if not enemies then return end
  for _,npc in ipairs(enemies:GetChildren()) do
   local hum=npc:FindFirstChildOfClass("Humanoid")
   local part=npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart")
   if hum and hum.Health>0 and part and part:IsA("BasePart") and (part.Position-root.Position).Magnitude<=1000 then
    local point,onScreen=cam:WorldToViewportPoint(part.Position)
    if onScreen and point.Z>0 then
     local distance=(Vector2.new(point.X,point.Y)-origin).Magnitude
     if distance<=limit then limit=distance; state.part=part; state.point=part.Position end
    end
   end
  end
 end
 state.connection=game:GetService("RunService").RenderStepped:Connect(function()
  local mouse=input:GetMouseLocation()
  circle.Position=UDim2.fromOffset(mouse.X,mouse.Y)
  circle.Size=UDim2.fromOffset(state.radius*2,state.radius*2)
  circle.Visible=state.enabled and state.mode=="Near Mouse"
  choose()
 end)
 local wrapper=function(delta,...)
  local caller=info(2,"n")
  state.calls+=1
  state.lastCaller=caller
  if state.enabled and delta==0 and caller=="shootGun" then
   choose()
   if state.part then
    state.redirected+=1
    return {Part=state.part,Position=state.point,Strength=1,Score=0,ScreenDistance=0,WorldDistance=0}
   end
  end
  return original(delta,...)
 end
 aim.getTargetInfo=wrapper
 state.aim,state.original,state.wrapper=aim,original,wrapper
 env.__ToshiroSilentGun=state
 tab:AddDropdown({Title="Gun NPC Search",Options={"Near Mouse","Full Screen"},Default="Near Mouse",Callback=function(v) state.mode=v end})
 tab:AddSlider({Title="Gun Mouse Radius (px)",Min=25,Max=400,Default=160,Increment=5,Callback=function(v) state.radius=v end})
 tab:AddToggle({Title="Aimbot Gun (Silent)",Description="NPCs na tela. Desligue Cam Lock e Aimbot Skills.",Default=false,Callback=function(v) state.enabled=v; choose() end})
 return state
end
