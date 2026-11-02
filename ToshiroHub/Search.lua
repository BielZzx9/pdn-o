return function(window)
    local entries = {}
    local originalMakeTab = window.MakeTab
    function window:MakeTab(options)
        local tab = originalMakeTab(self, options)
        for _, name in ipairs({"AddToggle", "AddButton", "AddDropdown", "AddTextBox", "AddSlider"}) do
            local original = tab[name]
            if type(original) == "function" then
                tab[name] = function(self, config, ...)
                    local control = original(self, config, ...)
                    local title = type(config) == "table" and (config.Title or config.Name or config[1])
                    if type(title) == "string" and control then
                        entries[#entries + 1] = {title = title, tab = self, control = control}
                    end
                    return control
                end
            end
        end
        return tab
    end
    local top = window.TITLE_LABEL.Parent
    local function make(kind, parent, props)
        local object = Instance.new(kind)
        for key, value in pairs(props) do object[key] = value end
        object.Parent = parent
        return object
    end
    local icon = make("ImageButton", window.SUBTITLE_LABEL, {
        Name = "ToshiroSearch", BackgroundTransparency = 1,
        Image = "rbxassetid://10734943674", ImageColor3 = Color3.fromRGB(235,235,235),
        Size = UDim2.fromOffset(16,16), Position = UDim2.new(1,14,0.5,0),
        AnchorPoint = Vector2.new(0,0.5), ZIndex = 30,
    })
    local panel = make("Frame", top, {
        Name = "ToshiroSearchPanel", Visible = false, Position = UDim2.fromOffset(135,30),
        Size = UDim2.fromOffset(250,210), BackgroundColor3 = Color3.fromRGB(25,25,28),
        BorderSizePixel = 0, ZIndex = 40,
    })
    make("UICorner", panel, {CornerRadius = UDim.new(0,7)})
    local input = make("TextBox", panel, {
        Name = "Query", Text = "", PlaceholderText = "Pesquisar funcao...", ClearTextOnFocus = false,
        Size = UDim2.new(1,-16,0,28), Position = UDim2.fromOffset(8,8),
        BackgroundColor3 = Color3.fromRGB(38,38,43), BorderSizePixel = 0,
        TextColor3 = Color3.fromRGB(240,240,240), PlaceholderColor3 = Color3.fromRGB(160,160,165),
        TextSize = 12, Font = Enum.Font.Gotham, ZIndex = 41,
    })
    make("UICorner", input, {CornerRadius = UDim.new(0,5)})
    local results = make("ScrollingFrame", panel, {
        Name = "Results", Position = UDim2.fromOffset(8,42), Size = UDim2.new(1,-16,1,-50),
        BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3,
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 41,
    })
    make("UIListLayout", results, {Padding = UDim.new(0,4), SortOrder = Enum.SortOrder.LayoutOrder})
    local function refresh()
        for _, child in ipairs(results:GetChildren()) do if child:IsA("GuiObject") then child:Destroy() end end
        results.CanvasPosition = Vector2.zero
        local query = string.lower(input.Text)
        local count = 0
        for _, entry in ipairs(entries) do
            if string.find(string.lower(entry.title), query, 1, true) then
                count += 1
                local button = make("TextButton", results, {
                    Text = entry.title .. "  /  " .. tostring(entry.tab.Title),
                    Size = UDim2.new(1,-4,0,28), BackgroundColor3 = Color3.fromRGB(36,36,40),
                    TextColor3 = Color3.fromRGB(235,235,240), TextSize = 10,
                    Font = Enum.Font.Gotham, TextTruncate = Enum.TextTruncate.AtEnd,
                    BorderSizePixel = 0, ZIndex = 42, LayoutOrder = count,
                })
                make("UICorner", button, {CornerRadius = UDim.new(0,4)})
                button.Activated:Connect(function()
                    input:ReleaseFocus()
                    panel.Visible = false
                    entry.tab:Select()
                    task.delay(0.4, function()
                        local row = entry.control.VISIBLE_ELEMENT or entry.control.DESTROY_ELEMENT
                        if typeof(row) ~= "Instance" or not row.Parent then return end
                        local scroll = row:FindFirstAncestorWhichIsA("ScrollingFrame")
                        if scroll then
                            local scale = top.AbsoluteSize.Y / math.max(top.Size.Y.Offset,1)
                            local y = scroll.CanvasPosition.Y + (row.AbsolutePosition.Y-scroll.AbsolutePosition.Y)/math.max(scale,0.01)-8
                            scroll.CanvasPosition = Vector2.new(0,math.max(0,y))
                        end
                        local stroke = make("UIStroke", row, {Color = Color3.fromRGB(125,120,255), Thickness = 2})
                        task.delay(1.5,function() stroke:Destroy() end)
                    end)
                end)
            end
        end
        if count == 0 then
            make("TextLabel",results,{Text="Nenhuma funcao encontrada", Size=UDim2.new(1,0,0,28), BackgroundTransparency=1, TextColor3=Color3.fromRGB(180,180,185),TextSize=11,Font=Enum.Font.Gotham,ZIndex=42})
        end
    end
    input:GetPropertyChangedSignal("Text"):Connect(refresh)
    icon.Activated:Connect(function()
        panel.Visible = not panel.Visible
        if panel.Visible then refresh(); input:CaptureFocus() else input:ReleaseFocus() end
    end)
end
