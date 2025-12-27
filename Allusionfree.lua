--==============================
-- SERVICES
--==============================
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

--==============================
-- CONFIG
--==============================
local KEY = "1234"
local DISCORD_LINK = "https://discord.gg/yourdiscord"
local KEY_LINK = "https://yourkeysite.com"
local SAVE_FILE = "AnubisKey.json"

--==============================
-- SAVE / LOAD KEY
--==============================
local function saveKey(key)
    if writefile then
        writefile(SAVE_FILE, HttpService:JSONEncode({key = key}))
    end
end

local function loadKey()
    if readfile and isfile and isfile(SAVE_FILE) then
        return HttpService:JSONDecode(readfile(SAVE_FILE)).key
    end
end

--==============================
-- FARM STATE
--==============================
local FARM_ENABLED = true

--==============================
-- MAIN SCRIPT
--==============================
local function main()

    -- AUTO EQUIP
    task.spawn(function()
        while true do
            if FARM_ENABLED then
                local char = player.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local bp = player:FindFirstChild("Backpack")
                    if hum and bp and not char:FindFirstChild("Combat") then
                        local tool = bp:FindFirstChild("Combat")
                        if tool then hum:EquipTool(tool) end
                    end
                end
            end
            task.wait(2)
        end
    end)

    -- AUTO CLICK
    task.spawn(function()
        while true do
            if FARM_ENABLED then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton1(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end
            task.wait(0.05)
        end
    end)

    -- AUTO BOSS FARM
    task.spawn(function()
        while true do
            if not FARM_ENABLED then
                task.wait(1)
                continue
            end

            task.wait(15)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = workspace.Bosses.Waiting.Titan.qw.CFrame
            end

            task.wait(8)
            if workspace.RespawnMobs:FindFirstChild("Titan")
            and workspace.RespawnMobs.Titan:FindFirstChild("Titan") then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.RespawnMobs.Titan.Titan.CFrame
            end

            task.wait(27)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = workspace.Bosses.Waiting.Muscle.qw.CFrame
            end

            task.wait(8)
            if workspace.RespawnMobs:FindFirstChild("Muscle") then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.RespawnMobs.Muscle.Muscle.CFrame
            end
        end
    end)
end

--==============================
-- GUI
--==============================
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 320, 0, 310)
Frame.Position = UDim2.new(0.5,0,0.5,0)
Frame.AnchorPoint = Vector2.new(0.5,0.5)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,25)
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,14)

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,-40,0,36)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundColor3 = Color3.fromRGB(30,30,35)
Title.Text = "ANUBIS HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(220,50,50)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.PaddingLeft = UDim.new(0,12)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0,14)

-- CLOSE BUTTON
local Close = Instance.new("TextButton", Frame)
Close.Size = UDim2.new(0,36,0,36)
Close.Position = UDim2.new(1,-36,0,0)
Close.Text = "✕"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Close.BackgroundColor3 = Color3.fromRGB(170,50,50)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close).CornerRadius = UDim.new(0,14)

-- CONTENT
local Content = Instance.new("Frame", Frame)
Content.Position = UDim2.new(0,10,0,46)
Content.Size = UDim2.new(1,-20,1,-56)
Content.BackgroundTransparency = 1

local UIList = Instance.new("UIListLayout", Content)
UIList.Padding = UDim.new(0,10)

local KeyBox = Instance.new("TextBox", Content)
KeyBox.Size = UDim2.new(1,0,0,40)
KeyBox.PlaceholderText = "Enter key..."
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,40)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,8)

local function button(text,color)
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(1,0,0,38)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    return b
end

local Verify = button("VERIFY KEY", Color3.fromRGB(45,45,55))
local GetKey = button("GET KEY", Color3.fromRGB(45,45,55))
local Discord = button("DISCORD", Color3.fromRGB(88,101,242))
local ToggleFarm = button("FARM: ON", Color3.fromRGB(50,120,50))

local Status = Instance.new("TextLabel", Content)
Status.Size = UDim2.new(1,0,0,18)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(220,50,50)
Status.Text = ""

--==============================
-- BUTTON LOGIC
--==============================
Verify.Activated:Connect(function()
    if KeyBox.Text == KEY then
        Status.Text = "KEY VALID"
        saveKey(KEY)
        task.wait(0.3)
        main()
    else
        Status.Text = "INVALID KEY"
    end
end)

GetKey.Activated:Connect(function()
    if setclipboard then
        setclipboard(KEY_LINK)
        Status.Text = "KEY LINK COPIED"
    end
end)

Discord.Activated:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        Status.Text = "DISCORD COPIED"
    end
end)

ToggleFarm.Activated:Connect(function()
    FARM_ENABLED = not FARM_ENABLED
    ToggleFarm.Text = FARM_ENABLED and "FARM: ON" or "FARM: OFF"
    ToggleFarm.BackgroundColor3 = FARM_ENABLED
        and Color3.fromRGB(50,120,50)
        or Color3.fromRGB(120,50,50)
end)

Close.Activated:Connect(function()
    Gui:Destroy()
end)

--==============================
-- AUTO LOAD KEY
--==============================
if loadKey() == KEY then
    main()
end

--==============================
-- DRAG (MOBILE + PC)
--==============================
local dragging, dragStart, startPos

Title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = i.Position
        startPos = Frame.Position
        i.Changed:Connect(function()
            if i.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

Title.InputChanged:Connect(function(i)
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
