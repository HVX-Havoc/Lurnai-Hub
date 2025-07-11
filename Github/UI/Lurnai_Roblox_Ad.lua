-- REMOVE OLD UI
do
    local CoreGui = game:GetService("CoreGui")
    for _, name in ipairs({"OpenClose", "Lurnai_ScreenGui", "LurnaiAds"}) do
        local old = CoreGui:FindFirstChild(name)
        if old then old:Destroy() end
    end
end

-- MAIN CONTAINER
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LurnaiAds"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = (gethui and gethui()) or (cloneref and cloneref(game:GetService("CoreGui"))) or game:GetService("CoreGui")
if ProtectGui then pcall(ProtectGui, ScreenGui) end

-- CLOSE BUTTON (draggable)
local Close_ImageButton = Instance.new("ImageButton")
Close_ImageButton.Name = "Close_ImageButton"
Close_ImageButton.Parent = ScreenGui
Close_ImageButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Close_ImageButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
Close_ImageButton.Position = UDim2.new(0.1021, 0, 0.0743, 0)
Close_ImageButton.Size = UDim2.new(0, 59, 0, 49)
Close_ImageButton.Image = "rbxassetid://129069615357738"
Close_ImageButton.Visible = false

local CloserUICorner = Instance.new("UICorner")
CloserUICorner.Name = "MainCorner"
CloserUICorner.CornerRadius = UDim.new(0, 9)
CloserUICorner.Parent = Close_ImageButton

local closeDragging = false
local closeDragStart, closeStartPos

local function closeUpdate(input)
    local delta = input.Position - closeDragStart
    Close_ImageButton.Position = UDim2.new(closeStartPos.X.Scale, closeStartPos.X.Offset + delta.X, closeStartPos.Y.Scale, closeStartPos.Y.Offset + delta.Y)
end
Close_ImageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        closeDragging = true
        closeDragStart = input.Position
        closeStartPos = Close_ImageButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                closeDragging = false
            end
        end)
    end
end)
Close_ImageButton.InputChanged:Connect(function(input)
    if closeDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        closeUpdate(input)
    end
end)

-- MAIN DRAGGABLE AD FRAME
local AdFrame = Instance.new("Frame")
AdFrame.Name = "AdFrame"
AdFrame.Parent = ScreenGui
AdFrame.Size = UDim2.new(0.4, 0, 0.3, 0)
AdFrame.Position = UDim2.new(0.5, 0, 0.35, 0)
AdFrame.AnchorPoint = Vector2.new(0.5, 0.5)
AdFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
AdFrame.BorderSizePixel = 0
AdFrame.Active = true

local AdFrameCorner = Instance.new("UICorner")
AdFrameCorner.Parent = AdFrame
AdFrameCorner.CornerRadius = UDim.new(0, 10)

local AdFrameStroke = Instance.new("UIStroke")
AdFrameStroke.Parent = AdFrame
AdFrameStroke.Color = Color3.fromRGB(70, 130, 255)
AdFrameStroke.Thickness = 2.5
AdFrameStroke.Transparency = 0

local UIGlow = Instance.new("ImageLabel")
UIGlow.Name = "Glow"
UIGlow.Parent = AdFrame
UIGlow.AnchorPoint = Vector2.new(0.5, 0.5)
UIGlow.BackgroundTransparency = 1
UIGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
UIGlow.Size = UDim2.new(1.1, 0, 1.1, 0)
UIGlow.ZIndex = -1
UIGlow.Image = "rbxassetid://6015897843"
UIGlow.ImageColor3 = Color3.fromRGB(45, 90, 255)
UIGlow.ImageTransparency = 0.6

local OuterGlow = Instance.new("ImageLabel")
OuterGlow.Name = "OuterGlow"
OuterGlow.Parent = AdFrame
OuterGlow.AnchorPoint = Vector2.new(0.5, 0.5)
OuterGlow.BackgroundTransparency = 1
OuterGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
OuterGlow.Size = UDim2.new(1.2, 0, 1.2, 0)
OuterGlow.ZIndex = -2
OuterGlow.Image = "rbxassetid://6015897843"
OuterGlow.ImageColor3 = Color3.fromRGB(0, 50, 255)
OuterGlow.ImageTransparency = 0.8

-- DISCORD LABEL W/ GLOW
local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Name = "DiscordLabel"
DiscordLabel.Parent = AdFrame
DiscordLabel.Size = UDim2.new(1, 0, 0.6, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "Lurnai Hub"
DiscordLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordLabel.TextSize = 28
DiscordLabel.Font = Enum.Font.GothamBold
DiscordLabel.TextWrapped = true

local function CreateTextGlow(textObject)
    for i = 1, 4 do
        local TextGlowClone = Instance.new("TextLabel")
        TextGlowClone.Name = "TextGlow" .. i
        TextGlowClone.Parent = textObject
        TextGlowClone.AnchorPoint = Vector2.new(0.5, 0.5)
        TextGlowClone.Position = UDim2.new(0.5, 0, 0.5, 0)
        TextGlowClone.Size = UDim2.new(1, 0, 1, 0)
        TextGlowClone.BackgroundTransparency = 1
        TextGlowClone.TextColor3 = Color3.fromRGB(0, 150, 255)
        TextGlowClone.Text = textObject.Text
        TextGlowClone.TextSize = textObject.TextSize
        TextGlowClone.Font = textObject.Font
        TextGlowClone.TextTransparency = 0.7
        TextGlowClone.ZIndex = textObject.ZIndex - i
        TextGlowClone.TextXAlignment = textObject.TextXAlignment
        TextGlowClone.TextYAlignment = textObject.TextYAlignment
        TextGlowClone.TextWrapped = textObject.TextWrapped
        local offsetX, offsetY = 0,0
        if i == 1 then offsetX = 1 elseif i == 2 then offsetX = -1 elseif i == 3 then offsetY = 1 elseif i == 4 then offsetY = -1 end
        TextGlowClone.Position = UDim2.new(0.5, offsetX, 0.5, offsetY)
    end
    local pulseTween = game:GetService("TweenService"):Create(
        textObject,
        TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {TextColor3 = Color3.fromRGB(220, 235, 255)}
    )
    pulseTween:Play()
end
CreateTextGlow(DiscordLabel)

local SubLabel = Instance.new("TextLabel")
SubLabel.Name = "SubLabel"
SubLabel.Parent = AdFrame
SubLabel.Size = UDim2.new(0.9, 0, 0.2, 0)
SubLabel.Position = UDim2.new(0.05, 0, 0.4, 0)
SubLabel.BackgroundTransparency = 1
SubLabel.Text = "Join our community for updates and support"
SubLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SubLabel.TextSize = 16
SubLabel.Font = Enum.Font.Gotham
SubLabel.TextWrapped = true

-- BUTTONS AND EFFECTS
local CopyButton = Instance.new("TextButton")
CopyButton.Name = "CopyButton"
CopyButton.Parent = AdFrame
CopyButton.Size = UDim2.new(0.4, 0, 0.2, 0)
CopyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
CopyButton.Text = "Join Discord"
CopyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.Font = Enum.Font.GothamSemibold
CopyButton.TextSize = 16
CopyButton.AutoButtonColor = false

local CopyCorner = Instance.new("UICorner")
CopyCorner.Parent = CopyButton
CopyCorner.CornerRadius = UDim.new(0, 8)

local CopyStroke = Instance.new("UIStroke")
CopyStroke.Parent = CopyButton
CopyStroke.Color = Color3.fromRGB(80, 80, 150)
CopyStroke.Thickness = 1.5
CopyStroke.Transparency = 0.2

local ExitButton = Instance.new("TextButton")
ExitButton.Name = "ExitButton"
ExitButton.Parent = AdFrame
ExitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
ExitButton.Position = UDim2.new(0.5, 0, 0.7, 0)
ExitButton.Text = "Close"
ExitButton.Visible = false
ExitButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
ExitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExitButton.Font = Enum.Font.GothamSemibold
ExitButton.TextSize = 16
ExitButton.AutoButtonColor = false

local ExitCorner = Instance.new("UICorner")
ExitCorner.Parent = ExitButton
ExitCorner.CornerRadius = UDim.new(0, 8)
local ExitStroke = Instance.new("UIStroke")
ExitStroke.Parent = ExitButton
ExitStroke.Color = Color3.fromRGB(80, 80, 150)
ExitStroke.Thickness = 1.5
ExitStroke.Transparency = 0.2

local WaitButton = Instance.new("TextButton")
WaitButton.Name = "WaitButton"
WaitButton.Parent = AdFrame
WaitButton.Size = UDim2.new(0.4, 0, 0.2, 0)
WaitButton.Position = UDim2.new(0.5, 0, 0.7, 0)
WaitButton.Text = "Please wait..."
WaitButton.Visible = true
WaitButton.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
WaitButton.TextColor3 = Color3.fromRGB(150, 150, 150)
WaitButton.Font = Enum.Font.GothamSemibold
WaitButton.TextSize = 16
WaitButton.AutoButtonColor = false

local WaitCorner = Instance.new("UICorner")
WaitCorner.Parent = WaitButton
WaitCorner.CornerRadius = UDim.new(0, 8)
local WaitStroke = Instance.new("UIStroke")
WaitStroke.Parent = WaitButton
WaitStroke.Color = Color3.fromRGB(80, 80, 150)
WaitStroke.Thickness = 1.5
WaitStroke.Transparency = 0.2

-- GLOW ANIMATION
local function AnimateGlow()
    local TweenService = game:GetService("TweenService")
    TweenService:Create(UIGlow, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        ImageTransparency = 0.4, Size = UDim2.new(1.12, 0, 1.12, 0)
    }):Play()
    TweenService:Create(OuterGlow, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        ImageTransparency = 0.7, Size = UDim2.new(1.25, 0, 1.25, 0)
    }):Play()
    TweenService:Create(AdFrameStroke, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Color = Color3.fromRGB(100, 200, 255)
    }):Play()
end
AnimateGlow()

local function AddButtonEffect(button)
    local originalSize = button.Size
    local originalPosition = button.Position
    local buttonStroke = button:FindFirstChildOfClass("UIStroke")
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            Size = UDim2.new(originalSize.X.Scale + 0.02, 0, originalSize.Y.Scale + 0.02, 0),
            BackgroundColor3 = button.BackgroundColor3:Lerp(Color3.fromRGB(70, 70, 120), 0.3)
        }):Play()
        if buttonStroke then
            game:GetService("TweenService"):Create(buttonStroke, TweenInfo.new(0.2), {
                Thickness = 2,
                Transparency = 0
            }):Play()
        end
        for _, child in pairs(button:GetChildren()) do
            if child:IsA("TextLabel") and child.Name:find("TextGlow") then
                game:GetService("TweenService"):Create(child, TweenInfo.new(0.2), {TextTransparency = 0.4}):Play()
            end
        end
    end)
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
            Size = originalSize,
            Position = originalPosition,
            BackgroundColor3 = button.BackgroundColor3
        }):Play()
        if buttonStroke then
            game:GetService("TweenService"):Create(buttonStroke, TweenInfo.new(0.2), {
                Thickness = 1.5,
                Transparency = 0.2
            }):Play()
        end
        for _, child in pairs(button:GetChildren()) do
            if child:IsA("TextLabel") and child.Name:find("TextGlow") then
                game:GetService("TweenService"):Create(child, TweenInfo.new(0.2), {TextTransparency = 0.7}):Play()
            end
        end
    end)
    button.MouseButton1Down:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {
            Size = UDim2.new(originalSize.X.Scale - 0.01, 0, originalSize.Y.Scale - 0.01, 0)
        }):Play()
        if buttonStroke then
            game:GetService("TweenService"):Create(buttonStroke, TweenInfo.new(0.1), {
                Thickness = 1.2,
                Transparency = 0.3
            }):Play()
        end
    end)
    button.MouseButton1Up:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.1), {Size = originalSize}):Play()
        if buttonStroke then
            game:GetService("TweenService"):Create(buttonStroke, TweenInfo.new(0.1), {
                Thickness = 1.5,
                Transparency = 0.2
            }):Play()
        end
    end)
    CreateTextGlow(button)
end
AddButtonEffect(CopyButton)
AddButtonEffect(ExitButton)
AddButtonEffect(WaitButton)

-- AdFrame DRAGGING
local dragInput, dragStart, startPos
local function UpdateDrag(input)
    local delta = input.Position - dragStart
    local dragSpeed = 0.2
    game:GetService("TweenService"):Create(AdFrame, TweenInfo.new(dragSpeed), {
        Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    }):Play()
    local glowStrength = math.min(1, delta.Magnitude / 100)
    game:GetService("TweenService"):Create(UIGlow, TweenInfo.new(dragSpeed), {
        ImageTransparency = 0.6 - (glowStrength * 0.3),
        Size = UDim2.new(1.1 + (glowStrength * 0.1), 0, 1.1 + (glowStrength * 0.1), 0)
    }):Play()
end
AdFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        startPos = AdFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragInput = nil
                game:GetService("TweenService"):Create(UIGlow, TweenInfo.new(0.3), {
                    ImageTransparency = 0.6,
                    Size = UDim2.new(1.1, 0, 1.1, 0)
                }):Play()
            end
        end)
    end
end)
AdFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragInput then
        UpdateDrag(input)
    end
end)

-- WaitButton shows for 5 seconds then fade in Close
task.delay(5, function()
    game:GetService("TweenService"):Create(WaitButton, TweenInfo.new(0.3), {
        BackgroundTransparency = 1, TextTransparency = 1
    }):Play()
    if WaitStroke then
        game:GetService("TweenService"):Create(WaitStroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
    end
    for _, child in pairs(WaitButton:GetChildren()) do
        if child:IsA("TextLabel") and child.Name:find("TextGlow") then
            game:GetService("TweenService"):Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
        end
    end
    task.wait(0.3)
    WaitButton.Visible = false
    ExitButton.Visible = true
    ExitButton.BackgroundTransparency = 1
    ExitButton.TextTransparency = 1
    if ExitStroke then ExitStroke.Transparency = 1 end
    for _, child in pairs(ExitButton:GetChildren()) do
        if child:IsA("TextLabel") and child.Name:find("TextGlow") then
            child.TextTransparency = 1
        end
    end
    game:GetService("TweenService"):Create(ExitButton, TweenInfo.new(0.3), {
        BackgroundTransparency = 0, TextTransparency = 0
    }):Play()
    if ExitStroke then
        game:GetService("TweenService"):Create(ExitStroke, TweenInfo.new(0.3), {Transparency = 0.2}):Play()
    end
    for _, child in pairs(ExitButton:GetChildren()) do
        if child:IsA("TextLabel") and child.Name:find("TextGlow") then
            game:GetService("TweenService"):Create(child, TweenInfo.new(0.3), {TextTransparency = 0.7}):Play()
        end
    end
end)

-- CopyButton copy to clipboard
CopyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/SfrMMwHnxB")
        local originalText = CopyButton.Text
        game:GetService("TweenService"):Create(CopyButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(50, 200, 100)
        }):Play()
        if CopyStroke then
            game:GetService("TweenService"):Create(CopyStroke, TweenInfo.new(0.3), {
                Color = Color3.fromRGB(100, 230, 150)
            }):Play()
        end
        for _, child in pairs(CopyButton:GetChildren()) do
            if child:IsA("TextLabel") and child.Name:find("TextGlow") then
                game:GetService("TweenService"):Create(child, TweenInfo.new(0.3), {
                    TextColor3 = Color3.fromRGB(0, 200, 100)
                }):Play()
            end
        end
        CopyButton.Text = "Copied!"
        task.wait(1.2)
        game:GetService("TweenService"):Create(CopyButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(40, 40, 70)
        }):Play()
        if CopyStroke then
            game:GetService("TweenService"):Create(CopyStroke, TweenInfo.new(0.3), {
                Color = Color3.fromRGB(80, 80, 150)
            }):Play()
        end
        for _, child in pairs(CopyButton:GetChildren()) do
            if child:IsA("TextLabel") and child.Name:find("TextGlow") then
                game:GetService("TweenService"):Create(child, TweenInfo.new(0.3), {
                    TextColor3 = Color3.fromRGB(0, 150, 255)
                }):Play()
            end
        end
        CopyButton.Text = originalText
    end
end)

-- ExitButton animation and destroy
ExitButton.MouseButton1Click:Connect(function()
    local TweenService = game:GetService("TweenService")
    local SpinningIcon = Instance.new("ImageLabel")
    SpinningIcon.Name = "LurnaiLogo"
    SpinningIcon.Parent = ScreenGui
    SpinningIcon.BackgroundTransparency = 1
    SpinningIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    SpinningIcon.Size = UDim2.new(0, 0, 0, 0)
    SpinningIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    SpinningIcon.Image = "rbxassetid://129069615357738"
    SpinningIcon.ImageTransparency = 1
    local IconGlow = Instance.new("ImageLabel")
    IconGlow.Name = "IconGlow"
    IconGlow.Parent = SpinningIcon
    IconGlow.BackgroundTransparency = 1
    IconGlow.Position = UDim2.new(0.5, 0, 0.5, 0)
    IconGlow.Size = UDim2.new(1.4, 0, 1.4, 0)
    IconGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    IconGlow.Image = "rbxassetid://6015897843"
    IconGlow.ImageColor3 = Color3.fromRGB(0, 100, 255)
    IconGlow.ImageTransparency = 1
    IconGlow.ZIndex = -1
    local exitTween = TweenService:Create(AdFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0), Rotation = 10
    })
    local glowTween = TweenService:Create(UIGlow, TweenInfo.new(0.5), {
        Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1
    })
    local outerGlowTween = TweenService:Create(OuterGlow, TweenInfo.new(0.7), {
        Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1
    })
    local fadeTween = TweenService:Create(AdFrame, TweenInfo.new(0.4), {
        BackgroundTransparency = 1
    })
    local strokeTween = TweenService:Create(AdFrameStroke, TweenInfo.new(0.3), {
        Transparency = 1
    })
    for _, obj in pairs(AdFrame:GetDescendants()) do
        if obj:IsA("TextButton") or obj:IsA("TextLabel") then
            TweenService:Create(obj, TweenInfo.new(0.3), {
                TextTransparency = 1, BackgroundTransparency = 1
            }):Play()
        elseif obj:IsA("UIStroke") then
            TweenService:Create(obj, TweenInfo.new(0.3), {Transparency = 1}):Play()
        elseif obj:IsA("ImageLabel") then
            TweenService:Create(obj, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        end
    end
    glowTween:Play(); outerGlowTween:Play(); strokeTween:Play(); fadeTween:Play(); exitTween:Play()
    task.wait(0.3)
    TweenService:Create(SpinningIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0.15, 0, 0.15, 0), ImageTransparency = 0
    }):Play()
    TweenService:Create(IconGlow, TweenInfo.new(0.3), {ImageTransparency = 0.7}):Play()
    local fastSpin = TweenService:Create(SpinningIcon, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
        Rotation = 720
    })
    fastSpin:Play()
    fastSpin.Completed:Connect(function()
        local slowSpin = TweenService:Create(SpinningIcon, TweenInfo.new(1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Rotation = SpinningIcon.Rotation + 360
        })
        slowSpin:Play()
        TweenService:Create(IconGlow, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 2, true), {
            Size = UDim2.new(1.6, 0, 1.6, 0), ImageTransparency = 0.5
        }):Play()
        task.delay(1.2, function()
            TweenService:Create(SpinningIcon, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1,
                Rotation = SpinningIcon.Rotation + 180
            }):Play()
            TweenService:Create(IconGlow, TweenInfo.new(0.6), {
                Size = UDim2.new(0, 0, 0, 0), ImageTransparency = 1
            }):Play()
            task.delay(0.8, function()
                ScreenGui:Destroy()
            end)
        end)
    end)
end)

-- REMOTE HOTLOAD UI EXECUTION
task.spawn(function()
    pcall(function()
        local success, content = pcall(function() 
            return game:HttpGet("https://raw.githubusercontent.com/HVX-Havoc/Lurnai-Hub/refs/heads/main/Github/UI/Execution")
        end)
        if success and content then
            local func = loadstring(content)
            if type(func) == "function" then func() end
        end
    end)
end)
