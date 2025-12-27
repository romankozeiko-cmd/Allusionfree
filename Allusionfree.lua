--==============================
-- FIXED MOBILE GUI
--==============================
local Gui = Instance.new("ScreenGui", game:GetService("CoreGui"))
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true -- ВАЖНО ДЛЯ MOBILE

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 300, 0, 260) -- 👈 ФИКС РАЗМЕРА
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 14)

--==============================
-- TITLE BAR
--==============================
local TitleBar = Instance.new("Frame", Frame)
TitleBar.Size = UDim2.new(1, 0, 0, 36)
TitleBar.BackgroundColor3 = Color3.fromRGB(30,30,35)
TitleBar.BorderSizePixel = 0
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,14)

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "ANUBIS HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(220,50,50)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- CLOSE
local Close = Instance.new("TextButton", TitleBar)
Close.Size = UDim2.new(0, 36, 0, 36)
Close.Position = UDim2.new(1, -36, 0, 0)
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.BackgroundColor3 = Color3.fromRGB(170,50,50)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close).CornerRadius = UDim.new(0,14)

--==============================
-- CONTENT (SCROLL SAFE)
--==============================
local Scroll = Instance.new("ScrollingFrame", Frame)
Scroll.Position = UDim2.new(0, 10, 0, 46)
Scroll.Size = UDim2.new(1, -20, 1, -56)
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.ScrollBarImageTransparency = 1
Scroll.BackgroundTransparency = 1
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local Layout = Instance.new("UIListLayout", Scroll)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--==============================
-- ELEMENTS
--==============================
local function rounded(obj, r)
    Instance.new("UICorner", obj).CornerRadius = UDim.new(0, r)
end

local KeyBox = Instance.new("TextBox", Scroll)
KeyBox.Size = UDim2.new(1,0,0,38)
KeyBox.PlaceholderText = "Enter key..."
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,40)
KeyBox.TextColor3 = Color3.new(1,1,1)
rounded(KeyBox, 8)

local function button(text,color)
    local b = Instance.new("TextButton", Scroll)
    b.Size = UDim2.new(1,0,0,36)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    rounded(b, 8)
    return b
end

local Verify = button("VERIFY KEY", Color3.fromRGB(45,45,55))
local GetKey = button("GET KEY", Color3.fromRGB(45,45,55))
local Discord = button("DISCORD", Color3.fromRGB(88,101,242))
local ToggleFarm = button("FARM: ON", Color3.fromRGB(50,120,50))

local Status = Instance.new("TextLabel", Scroll)
Status.Size = UDim2.new(1,0,0,18)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.TextColor3 = Color3.fromRGB(220,50,50)
Status.Text = ""

--==============================
-- CLOSE
--==============================
Close.Activated:Connect(function()
    Gui:Destroy()
end)

--==============================
-- DRAG (MOBILE SAFE)
--==============================
local dragging, dragStart, startPos

TitleBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1
    or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = Frame.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(i)
    if dragging then
        local delta = i.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)
