--[[ 
    MOBILE KEY SYSTEM VERSION
    BASED ON JUNKIE KEY SYSTEM
]]

Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791",
    service = "Saltink",
    provider = "Anubis"
}

--------------------------------------------------
-- MAIN SCRIPT (БЕЗ ИЗМЕНЕНИЙ)
--------------------------------------------------
local function main()
    print("Key Validated! Starting Script...")

    local ITEM_NAME = "Combat"
    local player = game:GetService("Players").LocalPlayer

    local function equipLoop()
        while true do
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local backpack = player:FindFirstChild("Backpack")
                if not character:FindFirstChild(ITEM_NAME) then
                    if backpack then
                        local item = backpack:FindFirstChild(ITEM_NAME)
                        if item and humanoid then
                            humanoid:EquipTool(item)
                        end
                    end
                end
            end
            task.wait(2)
        end
    end
    task.spawn(equipLoop)

    local VirtualUser = game:GetService("VirtualUser")
    task.spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851,158), workspace.CurrentCamera.CFrame)
            task.wait(0.05)
        end
    end)

    task.spawn(function()
        local player = game:GetService("Players").LocalPlayer
        while true do
            wait(15)
            player.Character.HumanoidRootPart.CFrame =
                workspace.Bosses.Waiting.Titan.qw.CFrame
            wait(8)
            if workspace.RespawnMobs.Titan.Titan.Titan then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.RespawnMobs.Titan.Titan.CFrame
            end
            wait(27)
            player.Character.HumanoidRootPart.CFrame =
                workspace.Bosses.Waiting.Muscle.qw.CFrame
            wait(8)
            if workspace.RespawnMobs.Muscle.Muscle then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.RespawnMobs.Muscle.Muscle.CFrame
            end
            wait(1)
        end
    end)
end

--------------------------------------------------
-- MOBILE KEY SYSTEM
--------------------------------------------------
if getgenv().MobileKeySys then return end
getgenv().MobileKeySys = true

local CoreGui = game:GetService("CoreGui")

local Colors = {
    BG = Color3.fromRGB(30,30,35),
    Red = Color3.fromRGB(220,50,50),
    Green = Color3.fromRGB(80,200,80),
    Button = Color3.fromRGB(45,45,50),
    Input = Color3.fromRGB(25,25,30),
    Discord = Color3.fromRGB(88,101,242)
}

local Gui = Instance.new("ScreenGui", CoreGui)
Gui.Name = "MobileKeySystem"
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 330, 0, 280)
Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Colors.BG
Frame.BorderSizePixel = 0
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "Anubis HUB Key System"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Colors.Red

local KeyBox = Instance.new("TextBox", Frame)
KeyBox.Size = UDim2.new(0.9, 0, 0, 42)
KeyBox.Position = UDim2.new(0.5, 0, 0.28, 0)
KeyBox.AnchorPoint = Vector2.new(0.5, 0)
KeyBox.PlaceholderText = "Enter your key..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Colors.Input
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 8)

local function makeButton(text, y, color)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(0.9, 0, 0, 42)
    b.Position = UDim2.new(0.5, 0, y, 0)
    b.AnchorPoint = Vector2.new(0.5, 0)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    b.AutoButtonColor = true
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    return b
end

local VerifyBtn = makeButton("VERIFY KEY", 0.46, Colors.Button)
local GetKeyBtn = makeButton("GET KEY", 0.63, Colors.Button)
local DiscordBtn = makeButton("DISCORD", 0.80, Colors.Discord)

local Status = Instance.new("TextLabel", Frame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.92, 0)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 12
Status.Text = ""
Status.TextColor3 = Colors.Red

local function setStatus(t, c)
    Status.Text = t
    Status.TextColor3 = c
end

-- GET KEY
GetKeyBtn.Activated:Connect(function()
    local Junkie = loadstring(game:HttpGet(
        "https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local link = Junkie.getLink(Config.api, Config.provider, Config.service)
    if setclipboard then setclipboard(link) end
    setStatus("Key link copied!", Colors.Green)
end)

-- VERIFY KEY
VerifyBtn.Activated:Connect(function()
    local key = KeyBox.Text:gsub("%s+", "")
    if key == "" then
        setStatus("Enter a key!", Colors.Red)
        return
    end
    setStatus("Checking key...", Color3.fromRGB(255,170,0))
    local Junkie = loadstring(game:HttpGet(
        "https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    if Junkie.verifyKey(Config.api, key, Config.service) then
        setStatus("Key valid!", Colors.Green)
        task.wait(0.5)
        Gui:Destroy()
        main()
    else
        setStatus("Invalid key!", Colors.Red)
    end
end)

-- DISCORD
DiscordBtn.Activated:Connect(function()
    local link = "https://discord.gg/FeSD9YyA4r"
    if setclipboard then setclipboard(link) end
    setStatus("Discord copied!", Colors.Green)
end)
