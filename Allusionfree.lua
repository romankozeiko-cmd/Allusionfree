--[[
    YOUTUBE TUTORIAL: https://www.youtube.com/watch?v=Yb2GXlsTmNM
    ADAPTED FOR MOBILE BY GEMINI
]]

Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791", 
    service = "Saltink",
    provider = "Anubis"
}

-- ФУНКЦИЯ MAIN: Твой скрипт
local function main()
    print("Mobile Script Started!")

    local ITEM_NAME = "Combat" 
    local player = game:GetService("Players").LocalPlayer

    -- Цикл экипировки
    task.spawn(function()
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
    end)

    -- Автокликер (Работает и на мобилках через VirtualUser)
    local VirtualUser = game:GetService("VirtualUser")
    task.spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(0.05) 
        end
    end)

    -- Цикл телепортации по боссам
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

-- АДАПТАЦИЯ ИНТЕРФЕЙСА ДЛЯ МОБИЛОК --
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local KeySystemData = {
    Name = "Mobile Hub",
    Colors = {
        Background = Color3.fromRGB(30, 30, 35),
        Title = Color3.fromRGB(220, 50, 50),
        InputField = Color3.fromRGB(25, 25, 30),
        InputFieldBorder = Color3.fromRGB(180, 0, 0),
        Button = Color3.fromRGB(25, 25, 30),
        Success = Color3.fromRGB(80, 200, 80),
        Discord = Color3.fromRGB(88, 101, 242)
    },
    DiscordInvite = "uerd"
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MobileKeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = KeySystemData.Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Size = UDim2.new(0, 300, 0, 220) -- Чуть меньше для телефонов

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = KeySystemData.Name .. " Key System"
Title.TextColor3 = KeySystemData.Colors.Title
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.5, 0, 0.35, 0)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.BackgroundColor3 = KeySystemData.Colors.InputField
KeyInput.PlaceholderText = "Enter Key..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255,255,255)

local KeyCorner = Instance.new("UICorner")
KeyCorner.Parent = KeyInput

local SubmitButton = Instance.new("TextButton")
SubmitButton.Parent = MainFrame
SubmitButton.Size = UDim2.new(0.4, 0, 0, 35)
SubmitButton.Position = UDim2.new(0.25, 0, 0.6, 0)
SubmitButton.AnchorPoint = Vector2.new(0.5, 0.5)
SubmitButton.Text = "Verify"
SubmitButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Parent = MainFrame
GetKeyButton.Size = UDim2.new(0.4, 0, 0, 35)
GetKeyButton.Position = UDim2.new(0.75, 0, 0.6, 0)
GetKeyButton.AnchorPoint = Vector2.new(0.5, 0.5)
GetKeyButton.Text = "Get Key"
GetKeyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Логика перетаскивания для МОБИЛОК (Touch & Mouse)
local dragStart, startPos
local dragging = false

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- Логика кнопок
SubmitButton.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    
    local isValid = JunkieKeySystem.verifyKey(Config.api, userKey, Config.service)
    if isValid then
        ScreenGui:Destroy()
        main()
    else
        KeyInput.Text = "INVALID KEY!"
        task.wait(1)
        KeyInput.Text = ""
    end
end)

GetKeyButton.MouseButton1Click:Connect(function()
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local link = JunkieKeySystem.getLink(Config.api, Config.provider, Config.service)
    if setclipboard then
        setclipboard(link)
        print("Link copied!")
    end
end)
