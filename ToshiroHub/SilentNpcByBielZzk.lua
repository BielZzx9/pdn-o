-- Silent Npc by BielZzk | standalone, no external UI library.
if not game:IsLoaded() then game.Loaded:Wait() end
local env = getgenv()
if env.__SilentNpcBielZzk and env.__SilentNpcBielZzk.Destroy then env.__SilentNpcBielZzk.Destroy() end
local players = game:GetService("Players")
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")
local insetService = game:GetService("GuiService")
local virtualInput = game:GetService("VirtualInputManager")
local player = players.LocalPlayer
local controller = game:GetService("ReplicatedStorage"):WaitForChild("Controllers"):WaitForChild("CombatController")
local aim = require(controller:WaitForChild("AimAssist"))
local original = aim.getTargetInfo
local debugInfo = debug.info
local state = {silent=false,auto=false,full=false,radius=160,distance=1000,alive=true,redirected=0,connections={}}
local function connect(signal, callback)
    local c=signal:Connect(callback)
    state.connections[#state.connections+1]=c
    return c
end
local function make(kind,parent,props)
    local object=Instance.new(kind)
    for key,value in pairs(props) do object[key]=value end
    object.Parent=parent
    return object
end
local gui=make("ScreenGui",gethui and gethui() or game:GetService("CoreGui"),{
    Name="SilentNpcByBielZzk",IgnoreGuiInset=true,ResetOnSpawn=false,DisplayOrder=200,
})
local circle=make("Frame",gui,{BackgroundTransparency=1,AnchorPoint=Vector2.new(0.5,0.5),Visible=false})
make("UICorner",circle,{CornerRadius=UDim.new(0.5,0)})
make("UIStroke",circle,{Color=Color3.fromRGB(145,135,255),Thickness=1})
local panel=make("Frame",gui,{
    Position=UDim2.new(0,24,0.25,0),Size=UDim2.fromOffset(286,308),
    BackgroundColor3=Color3.fromRGB(21,22,27),BorderSizePixel=0,Active=true,ZIndex=10,
})
make("UICorner",panel,{CornerRadius=UDim.new(0,9)})
make("UIStroke",panel,{Color=Color3.fromRGB(65,61,90),Thickness=1})
local header=make("TextLabel",panel,{
    Text="Silent Npc by BielZzk",Font=Enum.Font.GothamBold,TextSize=14,
    TextColor3=Color3.fromRGB(240,240,245),TextXAlignment=Enum.TextXAlignment.Left,
    Position=UDim2.fromOffset(12,0),Size=UDim2.new(1,-75,0,38),BackgroundTransparency=1,Active=true,ZIndex=11,
})
local function button(text,x,y,w,h)
    local b=make("TextButton",panel,{
        Text=text,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(235,235,242),
        BackgroundColor3=Color3.fromRGB(39,40,49),BorderSizePixel=0,
        Position=UDim2.fromOffset(x,y),Size=UDim2.fromOffset(w,h),ZIndex=11,
    })
    make("UICorner",b,{CornerRadius=UDim.new(0,5)})
    return b
end
local minimize=button("-",228,7,23,24)
local close=button("X",255,7,23,24)
local silentButton=button("",10,44,266,32)
local autoButton=button("",10,82,266,32)
local modeButton=button("",10,120,266,32)
local radiusLabel=make("TextLabel",panel,{Text="Raio do circulo: 25 a 2000 pixels",Font=Enum.Font.Gotham,TextSize=10,TextColor3=Color3.fromRGB(175,176,192),BackgroundTransparency=1,Position=UDim2.fromOffset(10,155),Size=UDim2.fromOffset(266,16),ZIndex=11})
local minus=button("-",10,174,28,30)
local plus=button("+",248,174,28,30)
local radiusBox=make("TextBox",panel,{
    Text="160",PlaceholderText="25 a 2000 px",ClearTextOnFocus=false,Font=Enum.Font.Gotham,
    TextSize=12,TextColor3=Color3.fromRGB(235,235,242),BackgroundColor3=Color3.fromRGB(39,40,49),
    BorderSizePixel=0,Position=UDim2.fromOffset(44,174),Size=UDim2.fromOffset(198,30),ZIndex=11,
})
make("UICorner",radiusBox,{CornerRadius=UDim.new(0,5)})
local distanceLabel=make("TextLabel",panel,{Text="Distancia maxima do NPC (studs)",Font=Enum.Font.Gotham,TextSize=10,TextColor3=Color3.fromRGB(175,176,192),BackgroundTransparency=1,Position=UDim2.fromOffset(10,208),Size=UDim2.fromOffset(266,16),ZIndex=11})
local distanceMinus=button("-",10,226,28,30)
local distancePlus=button("+",248,226,28,30)
local distanceBox=make("TextBox",panel,{Text="1000",PlaceholderText="50 a 20000 studs",ClearTextOnFocus=false,Font=Enum.Font.Gotham,TextSize=12,TextColor3=Color3.fromRGB(235,235,242),BackgroundColor3=Color3.fromRGB(39,40,49),BorderSizePixel=0,Position=UDim2.fromOffset(44,226),Size=UDim2.fromOffset(198,30),ZIndex=11})
make("UICorner",distanceBox,{CornerRadius=UDim.new(0,5)})
local status=make("TextLabel",panel,{
    Text="Equipe uma gun",Font=Enum.Font.Gotham,TextSize=11,TextColor3=Color3.fromRGB(175,176,192),
    Position=UDim2.fromOffset(10,264),Size=UDim2.fromOffset(266,34),BackgroundTransparency=1,
    TextWrapped=true,ZIndex=11,
})
local function refresh()
    silentButton.Text="Silent NPC: "..(state.silent and "LIGADO" or "DESLIGADO")
    autoButton.Text="Auto click gun: "..(state.auto and "LIGADO" or "DESLIGADO")
    modeButton.Text="Busca: "..(state.full and "TELA INTEIRA" or "PERTO DO MOUSE")
    silentButton.BackgroundColor3=state.silent and Color3.fromRGB(78,65,145) or Color3.fromRGB(39,40,49)
    autoButton.BackgroundColor3=state.auto and Color3.fromRGB(78,65,145) or Color3.fromRGB(39,40,49)
    radiusBox.Text=tostring(state.radius)
    distanceBox.Text=tostring(state.distance)
end
local function setDistance(value)
    state.distance=math.clamp(math.floor(tonumber(value) or state.distance),50,20000)
    refresh()
end
local function setRadius(value)
    state.radius=math.clamp(math.floor(tonumber(value) or state.radius),25,2000)
    refresh()
end
local function equippedGun()
    local char=player.Character
    local tool=char and char:FindFirstChildOfClass("Tool")
    return tool and (tool.ToolTip=="Gun" or tool:GetAttribute("WeaponType")=="Gun") and tool or nil
end
local function choose()
    state.part,state.point=nil,nil
    local camera=workspace.CurrentCamera
    local char=player.Character
    local root=char and char:FindFirstChild("HumanoidRootPart")
    if not state.alive or not state.silent or not camera or not root or not equippedGun() then return end
    local inset=insetService:GetGuiInset()
    local origin=state.full and (camera.ViewportSize/2-inset) or (input:GetMouseLocation()-inset)
    local distance=state.full and math.huge or state.radius
    local enemies=workspace:FindFirstChild("Enemies")
    if not enemies then return end
    for _,npc in ipairs(enemies:GetChildren()) do
        local hum=npc:FindFirstChildOfClass("Humanoid")
        local part=npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart")
        if hum and hum.Health>0 and part and part:IsA("BasePart") and (part.Position-root.Position).Magnitude<=state.distance then
            local point,onScreen=camera:WorldToScreenPoint(part.Position)
            if onScreen and point.Z>0 then
                local d=(Vector2.new(point.X,point.Y)-origin).Magnitude
                if d<=distance then distance=d; state.part=part; state.point=part.Position end
            end
        end
    end
end
local wrapper=function(delta,...)
    if state.alive and state.silent and delta==0 and debugInfo(2,"n")=="shootGun" then
        choose()
        if state.part then
            state.redirected+=1
            return {Part=state.part,Position=state.point,Strength=1,Score=0,ScreenDistance=0,WorldDistance=0}
        end
    end
    return original(delta,...)
end
aim.getTargetInfo=wrapper
local held=false
local function release()
    if held then
        held=false
        local mouse=input:GetMouseLocation()
        pcall(function() virtualInput:SendMouseButtonEvent(mouse.X,mouse.Y,0,false,game,0) end)
    end
end
function state.Destroy()
    state.alive=false
    state.auto=false
    release()
    for _,connection in ipairs(state.connections) do connection:Disconnect() end
    if state.autoTask then pcall(task.cancel,state.autoTask) end
    if aim.getTargetInfo==wrapper then aim.getTargetInfo=original end
    gui:Destroy()
    if env.__SilentNpcBielZzk==state then env.__SilentNpcBielZzk=nil end
end
connect(close.Activated,state.Destroy)
connect(silentButton.Activated,function() state.silent=not state.silent; if not state.silent then release() end; refresh() end)
connect(autoButton.Activated,function() state.auto=not state.auto; if not state.auto then release() end; refresh() end)
connect(modeButton.Activated,function() state.full=not state.full; refresh() end)
connect(minus.Activated,function() setRadius(state.radius-50) end)
connect(plus.Activated,function() setRadius(state.radius+50) end)
connect(radiusBox.FocusLost,function() setRadius(radiusBox.Text) end)
connect(distanceMinus.Activated,function() setDistance(state.distance-250) end)
connect(distancePlus.Activated,function() setDistance(state.distance+250) end)
connect(distanceBox.FocusLost,function() setDistance(distanceBox.Text) end)
local minimized=false
connect(minimize.Activated,function()
    minimized=not minimized
    panel.Size=UDim2.fromOffset(286,minimized and 38 or 308)
    for _,child in ipairs({silentButton,autoButton,modeButton,radiusLabel,minus,plus,radiusBox,distanceLabel,distanceMinus,distancePlus,distanceBox,status}) do child.Visible=not minimized end
    minimize.Text=minimized and "+" or "-"
end)
local dragStart,dragPosition,dragInput
connect(header.InputBegan,function(event)
    if event.UserInputType==Enum.UserInputType.MouseButton1 or event.UserInputType==Enum.UserInputType.Touch then
        dragInput=event; dragStart=event.Position; dragPosition=panel.Position
    end
end)
connect(input.InputChanged,function(event)
    if dragInput and (event.UserInputType==Enum.UserInputType.MouseMovement or event==dragInput) then
        local d=event.Position-dragStart
        panel.Position=UDim2.new(dragPosition.X.Scale,dragPosition.X.Offset+d.X,dragPosition.Y.Scale,dragPosition.Y.Offset+d.Y)
    end
end)
connect(input.InputEnded,function(event) if event==dragInput then dragInput=nil end end)
local function pointerOverPanel()
    local mouse=input:GetMouseLocation()-insetService:GetGuiInset()
    local p,size=panel.AbsolutePosition,panel.AbsoluteSize
    return mouse.X>=p.X and mouse.X<=p.X+size.X and mouse.Y>=p.Y and mouse.Y<=p.Y+size.Y
end
connect(run.RenderStepped,function()
    local mouse=input:GetMouseLocation()
    circle.Position=UDim2.fromOffset(mouse.X,mouse.Y)
    circle.Size=UDim2.fromOffset(state.radius*2,state.radius*2)
    circle.Visible=state.silent and not state.full
    choose()
    if not equippedGun() then status.Text="Equipe uma gun"
    elseif not state.silent then status.Text="Ligue Silent NPC para selecionar um alvo"
    elseif state.part then status.Text="Alvo: "..state.part.Parent.Name.." | Raio: "..state.radius.." px"
    else status.Text="Nenhum NPC na area | Raio: "..state.radius.." px" end
end)
state.autoTask=task.spawn(function()
    while state.alive do
        task.wait(0.18)
        if state.auto and state.silent and state.part and equippedGun() and not input:GetFocusedTextBox() and not pointerOverPanel() then
            local mouse=input:GetMouseLocation()
            local ok,err=pcall(function()
                held=true
                virtualInput:SendMouseButtonEvent(mouse.X,mouse.Y,0,true,game,0)
                task.wait(0.03)
                release()
            end)
            if not ok then
                release()
                state.auto=false
                state.lastError=tostring(err)
                refresh()
            end
        end
    end
end)
env.__SilentNpcBielZzk=state
refresh()
return state
