--[[
    YOUTUBE TUTORIAL: https://www.youtube.com/watch?v=Yb2GXlsTmNM
    MADE BY @uerd
]]

Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791", 
    service = "Saltink",
    provider = "Anubis"
}

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
            VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
            task.wait(0.05) 
        end
    end)

    task.spawn(function()
        while true do
            task.wait(15)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Waiting.Titan.qw.CFrame
                task.wait(8)
                if game:GetService("Workspace").RespawnMobs.Titan.Titan:FindFirstChild("Titan") then
                    player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnMobs.Titan.Titan.CFrame
                end
                task.wait(27)
                player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Waiting.Muscle.qw.CFrame
                task.wait(8)
                if game:GetService("Workspace").RespawnMobs.Muscle:FindFirstChild("Muscle") then
                    player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnMobs.Muscle.Muscle.CFrame
                end
            end
            task.wait(1)
        end
    end)
end

if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local KeySystemData = {
    Name = "Anubis HUB",
    Colors = {
        Background = Color3.fromRGB(30, 30, 35),
        Title = Color3.fromRGB(220, 50, 50),
        InputField = Color3.fromRGB(25, 25, 30),
        InputFieldBorder = Color3.fromRGB(180, 0, 0),
        Button = Color3.fromRGB(25, 25, 30),
        ButtonHover = Color3.fromRGB(35, 35, 40),
        Error = Color3.fromRGB(220, 50, 50),
        Success = Color3.fromRGB(80, 200, 80),
        Discord = Color3.fromRGB(88, 101, 242)
    },
    DiscordInvite = "FeSD9YyA4r"
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RedExecutorKeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = KeySystemData.Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 350, 0, 250)
MainFrame.ZIndex = 1

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = KeySystemData.Colors.Background
TitleBar.Size = UDim2.new(1, 0, 0, 40) -- Чуть увеличил для удобства нажатия
TitleBar.ZIndex = 2

local Title = Instance.new("TextLabel")
Title.Parent = TitleBar
Title.BackgroundTransparency = 1
Title.Text = KeySystemData.Name .. " Key System"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = KeySystemData.Colors.Title
Title.TextSize = 16
Title.ZIndex = 3

local KeyInput = Instance.new("TextBox")
KeyInput.Name = "KeyInput"
KeyInput.Parent = MainFrame
KeyInput.BackgroundColor3 = KeySystemData.Colors.InputField
KeyInput.Text = ""
KeyInput.PlaceholderText = "Enter key or link will appear here..."
KeyInput.Position = UDim2.new(0.5, 0, 0.4, 0)
KeyInput.Size = UDim2.new(0, 280, 0, 40)
KeyInput.Font = Enum.Font.Gotham
KeyInput.TextColor3 = Color3.fromRGB(220, 220, 220)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.ZIndex = 4

local SubmitButton = Instance.new("TextButton")
SubmitButton.Name = "ValidateButton"
SubmitButton.Parent = MainFrame
SubmitButton.BackgroundColor3 = KeySystemData.Colors.Button
SubmitButton.Position = UDim2.new(0.28, 0, 0.65, 0)
SubmitButton.Size = UDim2.new(0, 120, 0, 35)
SubmitButton.Text = "Verify Key"
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextColor3 = KeySystemData.Colors.Title
SubmitButton.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitButton.ZIndex = 5

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Name = "GetKeyButton"
GetKeyButton.Parent = MainFrame
GetKeyButton.BackgroundColor3 = KeySystemData.Colors.Button
GetKeyButton.Position = UDim2.new(0.72, 0, 0.65, 0)
GetKeyButton.Size = UDim2.new(0, 120, 0, 35)
GetKeyButton.Text = "Get Key"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextColor3 = KeySystemData.Colors.Title
GetKeyButton.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyButton.ZIndex = 5

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0.5, 0, 0.85, 0)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = ""
StatusLabel.TextColor3 = KeySystemData.Colors.Error
StatusLabel.AnchorPoint = Vector2.new(0.5, 0.5)
StatusLabel.ZIndex = 5

-- Функции
local function ShowStatus(msg, col)
    StatusLabel.Text = msg
    StatusLabel.TextColor3 = col
end

local function openGetKey()
    ShowStatus("Generating link...", Color3.fromRGB(255, 200, 0))
    local success, link = pcall(function()
        local Junkie = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
        return Junkie.getLink(Config.api, Config.provider, Config.service)
    end)
    
    if success and link then
        KeyInput.Text = link
        pcall(function() setclipboard(link) end)
        ShowStatus("Link copied & put in textbox!", KeySystemData.Colors.Success)
    else
        ShowStatus("Error getting link!", KeySystemData.Colors.Error)
    end
end

local function validateKey()
    local userKey = KeyInput.Text:gsub("%s+", "")
    if userKey == "" then ShowStatus("Enter a key first!", KeySystemData.Colors.Error) return end

    ShowStatus("Checking...", Color3.fromRGB(255, 200, 0))
    local success, isValid = pcall(function()
        local Junkie = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
        return Junkie.verifyKey(Config.api, userKey, Config.service)
    end)

    if success and isValid then
        ShowStatus("Success!", KeySystemData.Colors.Success)
        task.wait(0.5)
        ScreenGui:Destroy()
        main()
    else
        ShowStatus("Invalid Key!", KeySystemData.Colors.Error)
    end
end

-- Использование .Activated вместо .MouseButton1Click для мобильных
SubmitButton.Activated:Connect(validateKey)
GetKeyButton.Activated:Connect(openGetKey)

-- Простейший драг для мобилок
local dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragStart then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

TitleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = nil
    end
end)
