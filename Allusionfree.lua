-- COMPACT KEY SYSTEM + AUTOSAVE (FIXED SIZE)

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

    task.spawn(function()
        while true do
            local char = player.Character
            if char then
                local hum = char:FindFirstChildOfClass("Humanoid")
                local bp = player:FindFirstChild("Backpack")
                if hum and bp and not char:FindFirstChild(ITEM_NAME) then
                    local tool = bp:FindFirstChild(ITEM_NAME)
                    if tool then hum:EquipTool(tool) end
                end
            end
            task.wait(2)
        end
    end)

    local VirtualUser = game:GetService("VirtualUser")
    task.spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851,158), workspace.CurrentCamera.CFrame)
            task.wait(0.05)
        end
    end)

    task.spawn(function()
        while true do
            task.wait(15)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.Bosses.Waiting.Titan.qw.CFrame
            end

            task.wait(8)
            if workspace.RespawnMobs.Titan
                and workspace.RespawnMobs.Titan:FindFirstChild("Titan")
                and workspace.RespawnMobs.Titan.Titan:FindFirstChild("Titan")
            then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.RespawnMobs.Titan.Titan.CFrame
            end

            task.wait(27)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.Bosses.Waiting.Muscle.qw.CFrame
            end

            task.wait(8)
            if workspace.RespawnMobs.Muscle
                and workspace.RespawnMobs.Muscle:FindFirstChild("Muscle")
            then
                player.Character.HumanoidRootPart.CFrame =
                    workspace.RespawnMobs.Muscle.Muscle.CFrame
            end
        end
    end)
end

--------------------------------------------------
-- KEY SYSTEM
--------------------------------------------------
if getgenv().FixedKeySys then return end
getgenv().FixedKeySys = true

local CoreGui = game:GetService("CoreGui")
local SAVE_FILE = "anubis_key.txt"

local Colors = {
    BG = Color3.fromRGB(20,20,25),
    Red = Color3.fromRGB(220,50,50),
    Green = Color3.fromRGB(80,200,80),
    Button = Color3.fromRGB(45,45,55),
    Input = Color3.fromRGB(30,30,35),
    Discord = Color3.fromRGB(88,101,242)
}

--------------------------------------------------
-- FILE SYSTEM
--------------------------------------------------
local function saveKey(k)
    if writefile then writefile(SAVE_FILE, k) end
end

local function loadKey()
    if isfile and readfile and isfile(SAVE_FILE) then
        local k = readfile(SAVE_FILE)
        if k and #k > 5 then
            return k
        end
    end
end

--------------------------------------------------
-- GUI
--------------------------------------------------
local Gui = Instance.new("ScreenGui", CoreGui)
Gui.IgnoreGuiInset = false
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.fromOffset(420, 360) -- РЕАЛЬНЫЙ МАЛЕНЬКИЙ РАЗМЕР
Frame.Position = UDim2.fromScale(0.5, 0.5)
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Colors.BG
Frame.BorderSizePixel = 0

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,16)

local Stroke = Instance.new("UIStroke", Frame)
Stroke.Color = Color3.fromRGB(60,60,75)
Stroke.Thickness = 1
Stroke.Transparency = 0.15

local Constraint = Instance.new("UISizeConstraint", Frame)
Constraint.MinSize = Vector2.new(340, 300)
Constraint.MaxSize = Vector2.new(480, 420)

local Layout = Instance.new("UIListLayout", Frame)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Center
Layout.Padding = UDim.new(0,12)

local function label(text,size,color)
    local l = Instance.new("TextLabel", Frame)
    l.Size = UDim2.new(1,-40,0,size)
    l.BackgroundTransparency = 1
    l.Text = text
    l.Font = Enum.Font.GothamBold
    l.TextSize = size
    l.TextColor3 = color
    return l
end

label("ANUBIS HUB", 24, Colors.Red)
label("Key System", 13, Color3.fromRGB(180,180,180))

local KeyBox = Instance.new("TextBox", Frame)
KeyBox.Size = UDim2.new(0.85,0,0,42)
KeyBox.PlaceholderText = "Enter your key..."
KeyBox.Text = loadKey() or ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BackgroundColor3 = Colors.Input
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,10)

local function button(text,color)
    local b = Instance.new("TextButton", Frame)
    b.Size = UDim2.new(0.85,0,0,42)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = color
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    return b
end

local VerifyBtn = button("VERIFY KEY", Colors.Button)
local GetKeyBtn = button("GET KEY", Colors.Button)
local DiscordBtn = button("JOIN DISCORD", Colors.Discord)

local Status = label("", 13, Colors.Red)
local busy = false

local function setStatus(t,c)
    Status.Text = t
    Status.TextColor3 = c
end

--------------------------------------------------
-- JUNKIE
--------------------------------------------------
local function getJunkie()
    return loadstring(game:HttpGet(
        "https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
end

--------------------------------------------------
-- BUTTON LOGIC
--------------------------------------------------
GetKeyBtn.Activated:Connect(function()
    if busy then return end
    busy = true
    setStatus("Generating key link...", Color3.fromRGB(255,170,0))

    task.spawn(function()
        local ok,res = pcall(function()
            return getJunkie().getLink(Config.api, Config.provider, Config.service)
        end)

        if ok and res then
            if setclipboard then setclipboard(res) end
            setStatus("Key link copied ✔", Colors.Green)
        else
            setStatus("Failed to get key link", Colors.Red)
        end
        busy = false
    end)
end)

VerifyBtn.Activated:Connect(function()
    if busy then return end
    busy = true

    local key = KeyBox.Text:gsub("%s+","")
    if key == "" then
        setStatus("Enter a key!", Colors.Red)
        busy = false
        return
    end

    setStatus("Verifying key...", Color3.fromRGB(255,170,0))

    task.spawn(function()
        local ok,valid = pcall(function()
            return getJunkie().verifyKey(Config.api, key, Config.service)
        end)

        if ok and valid then
            saveKey(key)
            setStatus("Key valid ✔", Colors.Green)
            task.wait(0.5)
            Gui:Destroy()
            main()
        else
            setStatus("Invalid or expired key", Colors.Red)
            busy = false
        end
    end)
end)

DiscordBtn.Activated:Connect(function()
    if setclipboard then
        setclipboard("https://discord.gg/FeSD9YyA4r")
    end
    setStatus("Discord copied ✔", Colors.Green)
end)

--------------------------------------------------
-- AUTO CHECK SAVED KEY
--------------------------------------------------
task.spawn(function()
    local saved = loadKey()
    if not saved then return end
    busy = true
    setStatus("Checking saved key...", Color3.fromRGB(255,170,0))

    local ok,valid = pcall(function()
        return getJunkie().verifyKey(Config.api, saved, Config.service)
    end)

    if ok and valid then
        setStatus("Saved key valid ✔", Colors.Green)
        task.wait(0.5)
        Gui:Destroy()
        main()
    else
        setStatus("Saved key expired", Colors.Red)
        busy = false
    end
end)
