local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LP = game.Players.LocalPlayer

-- Configuration
local Config = {
    AnchorKey = Enum.KeyCode.F,
    InstantBuyKey = Enum.KeyCode.H,
    AutoBuyKey = Enum.KeyCode.G
}

local States = {
    Anchor = false,
    InstantBuy = false,
    AutoBuy = false
}

-- Couleur personnalisable
local ThemeColor = Color3.fromRGB(138, 43, 226) -- Violet par défaut

-- UI Style Rayfield
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UGCCheatGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 480, 0, 320)
Main.Position = UDim2.new(0.5, -240, 0.5, -160)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = ThemeColor
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.5

-- Effet de blur/glow
local Shadow = Instance.new("ImageLabel", Main)
Shadow.Name = "Shadow"
Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
Shadow.BackgroundTransparency = 1
Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.ZIndex = 0
Shadow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
Shadow.ImageColor3 = ThemeColor
Shadow.ImageTransparency = 0.7

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Header.BackgroundTransparency = 0.3
Header.BorderSizePixel = 0

local HeaderCorner = Instance.new("UICorner", Header)
HeaderCorner.CornerRadius = UDim.new(0, 16)

local HeaderBottom = Instance.new("Frame", Header)
HeaderBottom.Size = UDim2.new(1, 0, 0, 16)
HeaderBottom.Position = UDim2.new(0, 0, 1, -16)
HeaderBottom.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
HeaderBottom.BackgroundTransparency = 0.3
HeaderBottom.BorderSizePixel = 0

-- Logo/Icon avec image corrigée
local Icon = Instance.new("ImageLabel", Header)
Icon.Size = UDim2.new(0, 36, 0, 36)
Icon.Position = UDim2.new(0, 16, 0.5, -18)
Icon.BackgroundTransparency = 1
Icon.Image = "rbxassetid://114630829528007"
Icon.ScaleType = Enum.ScaleType.Fit

local IconCorner = Instance.new("UICorner", Icon)
IconCorner.CornerRadius = UDim.new(0, 8)

-- Title
local Title = Instance.new("TextLabel", Header)
Title.Size = UDim2.new(0, 300, 1, 0)
Title.Position = UDim2.new(0, 60, 0, 0)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.Text = "UGC CHEAT"
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Subtitle = Instance.new("TextLabel", Header)
Subtitle.Size = UDim2.new(0, 300, 0, 18)
Subtitle.Position = UDim2.new(0, 60, 0, 32)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Admin Abuse Tools"
Subtitle.TextSize = 12
Subtitle.TextColor3 = ThemeColor
Subtitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 36, 0, 36)
CloseBtn.Position = UDim2.new(1, -52, 0.5, -18)
CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
CloseBtn.BackgroundTransparency = 0.3
CloseBtn.Text = ""
CloseBtn.AutoButtonColor = false

local CloseBtnCorner = Instance.new("UICorner", CloseBtn)
CloseBtnCorner.CornerRadius = UDim.new(0, 8)

local CloseIcon = Instance.new("TextLabel", CloseBtn)
CloseIcon.Size = UDim2.new(1, 0, 1, 0)
CloseIcon.BackgroundTransparency = 1
CloseIcon.Font = Enum.Font.GothamBold
CloseIcon.Text = "×"
CloseIcon.TextSize = 24
CloseIcon.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Bouton pour réouvrir le menu
local ReopenButton = Instance.new("ImageButton", ScreenGui)
ReopenButton.Size = UDim2.new(0, 50, 0, 50)
ReopenButton.Position = UDim2.new(0, 20, 0.5, -25)
ReopenButton.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
ReopenButton.BackgroundTransparency = 0.2
ReopenButton.Image = "rbxassetid://114630829528007"
ReopenButton.ScaleType = Enum.ScaleType.Fit
ReopenButton.Visible = false
ReopenButton.Active = true
ReopenButton.Draggable = true

local ReopenCorner = Instance.new("UICorner", ReopenButton)
ReopenCorner.CornerRadius = UDim.new(0, 12)

local ReopenStroke = Instance.new("UIStroke", ReopenButton)
ReopenStroke.Color = ThemeColor
ReopenStroke.Thickness = 2
ReopenStroke.Transparency = 0.3

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()
    task.wait(0.3)
    Main.Visible = false
    ReopenButton.Visible = true
    TweenService:Create(ReopenButton, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 50, 0, 50)
    }):Play()
end)

ReopenButton.MouseButton1Click:Connect(function()
    ReopenButton.Visible = false
    Main.Visible = true
    Main.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 480, 0, 320)
    }):Play()
end)

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 50, 50)}):Play()
end)

CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 40)}):Play()
end)

ReopenButton.MouseEnter:Connect(function()
    TweenService:Create(ReopenButton, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    TweenService:Create(ReopenStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
end)

ReopenButton.MouseLeave:Connect(function()
    TweenService:Create(ReopenButton, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    TweenService:Create(ReopenStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
end)

-- ScrollingFrame pour le contenu
local ContentScroll = Instance.new("ScrollingFrame", Main)
ContentScroll.Size = UDim2.new(1, -32, 1, -92)
ContentScroll.Position = UDim2.new(0, 16, 0, 76)
ContentScroll.BackgroundTransparency = 1
ContentScroll.BorderSizePixel = 0
ContentScroll.ScrollBarThickness = 4
ContentScroll.ScrollBarImageColor3 = ThemeColor
ContentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ContentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Content Container
local Content = Instance.new("Frame", ContentScroll)
Content.Size = UDim2.new(1, 0, 0, 0)
Content.BackgroundTransparency = 1
Content.AutomaticSize = Enum.AutomaticSize.Y

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.Padding = UDim.new(0, 10)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Fonction pour créer un toggle
local function CreateToggle(name, description, layoutOrder, stateKey, configKey)
    local ToggleFrame = Instance.new("Frame", Content)
    ToggleFrame.Size = UDim2.new(1, -4, 0, 65)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    ToggleFrame.BackgroundTransparency = 0.4
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.LayoutOrder = layoutOrder
    
    local ToggleCorner = Instance.new("UICorner", ToggleFrame)
    ToggleCorner.CornerRadius = UDim.new(0, 12)
    
    local ToggleStroke = Instance.new("UIStroke", ToggleFrame)
    ToggleStroke.Color = Color3.fromRGB(40, 40, 50)
    ToggleStroke.Thickness = 1
    ToggleStroke.Transparency = 0.6
    
    local ToggleLabel = Instance.new("TextLabel", ToggleFrame)
    ToggleLabel.Size = UDim2.new(0, 330, 0, 22)
    ToggleLabel.Position = UDim2.new(0, 16, 0, 12)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.Text = name
    ToggleLabel.TextSize = 14
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleDesc = Instance.new("TextLabel", ToggleFrame)
    ToggleDesc.Size = UDim2.new(0, 330, 0, 18)
    ToggleDesc.Position = UDim2.new(0, 16, 0, 36)
    ToggleDesc.BackgroundTransparency = 1
    ToggleDesc.Font = Enum.Font.Gotham
    ToggleDesc.Text = description
    ToggleDesc.TextSize = 11
    ToggleDesc.TextColor3 = Color3.fromRGB(150, 150, 160)
    ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
    
    local ToggleButton = Instance.new("TextButton", ToggleFrame)
    ToggleButton.Size = UDim2.new(0, 50, 0, 26)
    ToggleButton.Position = UDim2.new(1, -66, 0.5, -13)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    ToggleButton.ZIndex = 2
    
    local ToggleBtnCorner = Instance.new("UICorner", ToggleButton)
    ToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    
    local ToggleIndicator = Instance.new("Frame", ToggleButton)
    ToggleIndicator.Size = UDim2.new(0, 20, 0, 20)
    ToggleIndicator.Position = UDim2.new(0, 3, 0.5, -10)
    ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleIndicator.BorderSizePixel = 0
    ToggleIndicator.ZIndex = 3
    
    local IndicatorCorner = Instance.new("UICorner", ToggleIndicator)
    IndicatorCorner.CornerRadius = UDim.new(1, 0)
    
    local function Toggle()
        States[stateKey] = not States[stateKey]
        local active = States[stateKey]
        
        TweenService:Create(ToggleIndicator, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = active and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10)
        }):Play()
        
        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {
            BackgroundColor3 = active and ThemeColor or Color3.fromRGB(40, 40, 50)
        }):Play()
        
        TweenService:Create(ToggleStroke, TweenInfo.new(0.3), {
            Color = active and ThemeColor or Color3.fromRGB(40, 40, 50),
            Transparency = active and 0.3 or 0.6
        }):Play()
        
        warn(name .. " : " .. (active and "ON" or "OFF"))
    end
    
    ToggleButton.MouseButton1Click:Connect(Toggle)
    
    UIS.InputBegan:Connect(function(input, gameProcessed) 
        if not gameProcessed and input.KeyCode == Config[configKey] then 
            Toggle() 
        end 
    end)
    
    return ToggleButton
end

-- Color Picker
local ColorPickerFrame = Instance.new("Frame", Content)
ColorPickerFrame.Size = UDim2.new(1, -4, 0, 65)
ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ColorPickerFrame.BackgroundTransparency = 0.4
ColorPickerFrame.BorderSizePixel = 0
ColorPickerFrame.LayoutOrder = 0

local ColorPickerCorner = Instance.new("UICorner", ColorPickerFrame)
ColorPickerCorner.CornerRadius = UDim.new(0, 12)

local ColorPickerStroke = Instance.new("UIStroke", ColorPickerFrame)
ColorPickerStroke.Color = Color3.fromRGB(40, 40, 50)
ColorPickerStroke.Thickness = 1
ColorPickerStroke.Transparency = 0.6

local ColorPickerLabel = Instance.new("TextLabel", ColorPickerFrame)
ColorPickerLabel.Size = UDim2.new(0, 330, 0, 22)
ColorPickerLabel.Position = UDim2.new(0, 16, 0, 12)
ColorPickerLabel.BackgroundTransparency = 1
ColorPickerLabel.Font = Enum.Font.GothamBold
ColorPickerLabel.Text = "Theme Color"
ColorPickerLabel.TextSize = 14
ColorPickerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
ColorPickerLabel.TextXAlignment = Enum.TextXAlignment.Left

local ColorPickerDesc = Instance.new("TextLabel", ColorPickerFrame)
ColorPickerDesc.Size = UDim2.new(0, 330, 0, 18)
ColorPickerDesc.Position = UDim2.new(0, 16, 0, 36)
ColorPickerDesc.BackgroundTransparency = 1
ColorPickerDesc.Font = Enum.Font.Gotham
ColorPickerDesc.Text = "Customize your interface color"
ColorPickerDesc.TextSize = 11
ColorPickerDesc.TextColor3 = Color3.fromRGB(150, 150, 160)
ColorPickerDesc.TextXAlignment = Enum.TextXAlignment.Left

-- Color buttons
local colors = {
    {name = "Purple", color = Color3.fromRGB(138, 43, 226)},
    {name = "Blue", color = Color3.fromRGB(30, 144, 255)},
    {name = "Pink", color = Color3.fromRGB(255, 20, 147)},
    {name = "Red", color = Color3.fromRGB(220, 50, 50)},
    {name = "Green", color = Color3.fromRGB(50, 205, 50)}
}

local ColorContainer = Instance.new("Frame", ColorPickerFrame)
ColorContainer.Size = UDim2.new(0, 250, 0, 26)
ColorContainer.Position = UDim2.new(1, -266, 0.5, -13)
ColorContainer.BackgroundTransparency = 1

local ColorLayout = Instance.new("UIListLayout", ColorContainer)
ColorLayout.FillDirection = Enum.FillDirection.Horizontal
ColorLayout.Padding = UDim.new(0, 6)
ColorLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right

for i, colorData in ipairs(colors) do
    local ColorBtn = Instance.new("TextButton", ColorContainer)
    ColorBtn.Size = UDim2.new(0, 26, 0, 26)
    ColorBtn.BackgroundColor3 = colorData.color
    ColorBtn.Text = ""
    ColorBtn.AutoButtonColor = false
    
    local ColorBtnCorner = Instance.new("UICorner", ColorBtn)
    ColorBtnCorner.CornerRadius = UDim.new(1, 0)
    
    local ColorBtnStroke = Instance.new("UIStroke", ColorBtn)
    ColorBtnStroke.Color = Color3.fromRGB(255, 255, 255)
    ColorBtnStroke.Thickness = 2
    ColorBtnStroke.Transparency = 1
    
    ColorBtn.MouseButton1Click:Connect(function()
        ThemeColor = colorData.color
        
        -- Update all theme colors
        MainStroke.Color = ThemeColor
        Shadow.ImageColor3 = ThemeColor
        Subtitle.TextColor3 = ThemeColor
        ContentScroll.ScrollBarImageColor3 = ThemeColor
        ReopenStroke.Color = ThemeColor
        
        for _, obj in pairs(ColorContainer:GetChildren()) do
            if obj:IsA("TextButton") then
                local stroke = obj:FindFirstChildOfClass("UIStroke")
                if stroke then
                    stroke.Transparency = 1
                end
            end
        end
        
        ColorBtnStroke.Transparency = 0
        
        -- Update all active toggles
        for _, toggle in pairs(Content:GetChildren()) do
            if toggle:IsA("Frame") and toggle ~= ColorPickerFrame then
                local btn = toggle:FindFirstChildOfClass("TextButton")
                if btn then
                    local indicator = btn:FindFirstChildOfClass("Frame")
                    if indicator and indicator.Position.X.Offset > 10 then
                        btn.BackgroundColor3 = ThemeColor
                        toggle:FindFirstChildOfClass("UIStroke").Color = ThemeColor
                    end
                end
            end
        end
    end)
    
    if i == 1 then
        ColorBtnStroke.Transparency = 0
    end
end

-- Create Toggles
CreateToggle("Anchor Character", "Press F • Freeze your character in place", 1, "Anchor", "AnchorKey")
CreateToggle("Instant Buy", "Press H • Buy items instantly without holding", 2, "InstantBuy", "InstantBuyKey")
CreateToggle("Auto Buy", "Press G • Automatically buy nearby items", 3, "AutoBuy", "AutoBuyKey")

-- Animation d'ouverture
Main.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 480, 0, 320)
}):Play()

-- Variables pour Auto Buy
local _Players2 = game:GetService('Players')
local _RunService = game:GetService('RunService')
local _Workspace = game:GetService('Workspace')
local _LocalPlayer3 = _Players2.LocalPlayer
local u91 = {}
local u92 = false
local u93 = nil
local u94 = nil

local function u99(p95)
    if not (p95 and p95:IsA('ProximityPrompt')) then
        return false
    end
    
    local _Parent = p95.Parent
    
    if not _Parent or _Parent.Name ~= 'PromptAttachment' then
        return false
    end
    
    local _Parent2 = _Parent.Parent
    
    if not _Parent2 or _Parent2.Name ~= 'Part' then
        return false
    end
    
    local _Parent3 = _Parent2.Parent
    
    return _Parent3 and _Parent3:IsA('Model') and true or false
end

local function u101(p100)
    if p100 and p100.Parent then
        if p100.Parent:IsA('Attachment') and (p100.Parent.Name == 'PromptAttachment' and (p100.Parent.Parent and p100.Parent.Parent.Name == 'Part')) then
            return p100.Parent.Parent.Position
        elseif p100.Parent:IsA('BasePart') then
            return p100.Parent.Position
        elseif p100.Parent:IsA('Model') and p100.Parent.PrimaryPart then
            return p100.Parent.PrimaryPart.Position
        else
            return nil
        end
    else
        return nil
    end
end

local function u105(p102)
    local v103 = u101(p102)
    
    if not v103 then
        return false
    end
    
    local _, v104 = workspace.CurrentCamera:WorldToViewportPoint(v103)
    
    return v104
end

local function u111(p106)
    local v107, v108, v109 = pairs({
        Enum.UserInputType.Keyboard,
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.Touch,
    })
    
    while true do
        local u110
        
        v109, u110 = v107(v108, v109)
        
        if v109 == nil then
            break
        end
        
        pcall(function()
            p106:InputHoldBegin(u110)
        end)
    end
end

local function u117(p112)
    local v113, v114, v115 = pairs({
        Enum.UserInputType.Keyboard,
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.Touch,
    })
    
    while true do
        local u116
        
        v115, u116 = v113(v114, v115)
        
        if v115 == nil then
            break
        end
        
        pcall(function()
            p112:InputHoldEnd(u116)
        end)
    end
end

local function u119(p118)
    if u99(p118) and not u91[p118] then
        u91[p118] = true
    end
end

local function u121(p120)
    u119(p120)
end

local function u133()
    if not u92 then
        u92 = true
        
        local v122 = _Workspace
        local v123, v124, v125 = pairs(v122:GetDescendants())
        
        while true do
            local v126
            
            v125, v126 = v123(v124, v125)
            
            if v125 == nil then
                break
            end
            
            u119(v126)
        end
        
        if u94 then
            u94:Disconnect()
            
            u94 = nil
        end
        
        u94 = _Workspace.DescendantAdded:Connect(u121)
        
        if u93 then
            u93:Disconnect()
            
            u93 = nil
        end
        
        u93 = _RunService.RenderStepped:Connect(function()
            local _Character = _LocalPlayer3.Character
            
            if _Character then
                _Character = _Character:FindFirstChild('HumanoidRootPart')
            end
            if _Character then
                local v128, v129, v130 = pairs(u91)
                
                while true do
                    local v131
                    
                    v130, v131 = v128(v129, v130)
                    
                    if v130 == nil then
                        break
                    end
                    if v130 and (v130.Parent and u99(v130)) then
                        local v132 = u101(v130)
                        
                        if v132 then
                            if (_Character.Position - v132).Magnitude > 15 or not u105(v130) then
                                u117(v130)
                            else
                                u111(v130)
                            end
                        else
                            u91[v130] = nil
                        end
                    else
                        u91[v130] = nil
                    end
                end
            end
        end)
    end
end

local function u138()
    if u92 then
        u92 = false
        
        if u93 then
            u93:Disconnect()
            
            u93 = nil
        end
        if u94 then
            u94:Disconnect()
            
            u94 = nil
        end
        
        local v134, v135, v136 = pairs(u91)
        
        while true do
            local v137
            
            v136, v137 = v134(v135, v136)
            
            if v136 == nil then
                break
            end
            
            u117(v136)
        end
        
        u91 = {}
    end
end

-- ANCHOR CHARACTER
task.spawn(function()
    while task.wait() do
        pcall(function()
            if States.Anchor and LP.Character then
                local char = LP.Character
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA('BasePart') then
                        part.Anchored = true
                    end
                end
            elseif not States.Anchor and LP.Character then
                local char = LP.Character
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA('BasePart') then
                        part.Anchored = false
                    end
                end
            end
        end)
    end
end)

LP.CharacterAdded:Connect(function()
    task.wait(0.5)
    if States.Anchor then
        pcall(function()
            local char = LP.Character
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA('BasePart') then
                    part.Anchored = true
                end
            end
        end)
    end
end)

-- INSTANT BUY
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if States.InstantBuy then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("ProximityPrompt") then
                        v.HoldDuration = 0
                        v.MaxActivationDistance = 20
                    end
                end
            end
        end)
    end
end)

workspace.DescendantAdded:Connect(function(v)
    if v:IsA("ProximityPrompt") and States.InstantBuy then
        v.HoldDuration = 0
        v.MaxActivationDistance = 20
    end
end)

-- AUTO BUY
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if States.AutoBuy and not u92 then
                u133()
            elseif not States.AutoBuy and u92 then
                u138()
            end
        end)
    end
end)

_LocalPlayer3.CharacterRemoving:Connect(function()
    local v142, v143, v144 = pairs(u91)
    
    while true do
        local v145
        
        v144, v145 = v142(v143, v144)
        
        if v144 == nil then
            break
        end
        
        u117(v144)
    end
    
    u91 = {}
end)
