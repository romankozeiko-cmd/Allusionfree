--[[
    MOBILE VERSION (FIXED BUTTONS)
    Original by @uerd
    Mobile Adaptation: Added Toggle Menu & UI
    Fix: Changed CoreGui to PlayerGui for mobile touch support
]]

Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791", 
    service = "Saltink",
    provider = "Anubis"
}

-- Глобальные настройки
getgenv().FarmSettings = {
    AutoEquip = false,
    AutoClick = false,
    AutoFarm = false
}

-- ФУНКЦИЯ MAIN: Запускается после проверки ключа
local function main()
    print("Key Validated! Loading Mobile UI...")
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")
    local VirtualUser = game:GetService("VirtualUser")

    -- /// ЛОГИКА ФАРМА /// --

    -- 1. Auto Equip
    task.spawn(function()
        local ITEM_NAME = "Combat"
        while true do
            if getgenv().FarmSettings.AutoEquip then
                pcall(function()
                    local character = LocalPlayer.Character
                    if character then
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        local backpack = LocalPlayer:FindFirstChild("Backpack")
                        
                        if not character:FindFirstChild(ITEM_NAME) and backpack then
                            local item = backpack:FindFirstChild(ITEM_NAME)
                            if item and humanoid then
                                humanoid:EquipTool(item)
                            end
                        end
                    end
                end)
            end
            task.wait(1)
        end
    end)

    -- 2. Auto Clicker
    task.spawn(function()
        while true do
            if getgenv().FarmSettings.AutoClick then
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
                end)
                task.wait(0.1)
            else
                task.wait(1)
            end
        end
    end)

    -- 3. Teleport Farm
    task.spawn(function()
        while true do
            if getgenv().FarmSettings.AutoFarm then
                pcall(function()
                    LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Waiting.Titan.qw.CFrame
                    task.wait(8)
                    if not getgenv().FarmSettings.AutoFarm then return end
                    
                    if game:GetService("Workspace").RespawnMobs.Titan:FindFirstChild("Titan") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnMobs.Titan.Titan.CFrame
                    end
                    task.wait(27) 
                    if not getgenv().FarmSettings.AutoFarm then return end

                    LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Waiting.Muscle.qw.CFrame
                    task.wait(8)
                    if not getgenv().FarmSettings.AutoFarm then return end

                    if game:GetService("Workspace").RespawnMobs.Muscle:FindFirstChild("Muscle") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnMobs.Muscle.Muscle.CFrame
                    end
                end)
            end
            task.wait(1)
        end
    end)

    -- /// МОБИЛЬНЫЙ GUI (ФАРМ) /// --
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FarmMobileUI"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 10000

    -- Кнопка открытия
    local OpenButton = Instance.new("TextButton")
    OpenButton.Name = "ToggleMenu"
    OpenButton.Parent = ScreenGui
    OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    OpenButton.Position = UDim2.new(0.85, 0, 0.4, 0)
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Text = "⚙️"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 24
    Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 10)
    
    -- Меню
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    MainFrame.Position = UDim2.new(0.5, -100, 0.5, -100)
    MainFrame.Size = UDim2.new(0, 200, 0, 220)
    MainFrame.Visible = false
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
    
    local Title = Instance.new("TextLabel")
    Title.Parent = MainFrame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 0, 0, 5)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "FARM CONTROL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    local function CreateToggle(name, text, settingName, yPos)
        local Button = Instance.new("TextButton")
        Button.Parent = MainFrame
        Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        Button.Position = UDim2.new(0.1, 0, 0, yPos)
        Button.Size = UDim2.new(0.8, 0, 0, 35)
        Button.Text = text .. ": OFF"
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamBold
        Button.TextSize = 14
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)

        Button.MouseButton1Click:Connect(function()
            getgenv().FarmSettings[settingName] = not getgenv().FarmSettings[settingName]
            local state = getgenv().FarmSettings[settingName]
            
            if state then
                Button.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
                Button.Text = text .. ": ON"
            else
                Button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
                Button.Text = text .. ": OFF"
            end
        end)
    end

    CreateToggle("EquipBtn", "Auto Equip", "AutoEquip", 50)
    CreateToggle("ClickBtn", "Auto Click", "AutoClick", 100)
    CreateToggle("FarmBtn", "Auto Farm", "AutoFarm", 150)

    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    
    -- Draggable Button
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        OpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    OpenButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = OpenButton.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    OpenButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end

if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

-- /// KEY SYSTEM FIX /// --
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- ИСПОЛЬЗУЕМ PLAYERGUI ВМЕСТО COREGUI ДЛЯ МОБИЛОК
local ParentGui = Player:WaitForChild("PlayerGui")

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
    DiscordInvite = "uerd"
}

local function CreateObject(class, props)
    local obj = Instance.new(class)
    for prop, value in pairs(props) do 
        if prop ~= "Parent" then
            obj[prop] = value
        end
    end
    if props.Parent then
        obj.Parent = props.Parent
    end
    return obj
end

local function SmoothTween(obj, time, properties)
    local tween = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local ScreenGui = CreateObject("ScreenGui", {
    Name = "RedExecutorKeySystem", 
    Parent = ParentGui, -- FIX: Parented to PlayerGui
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 10000 -- FIX: High DisplayOrder
})

local MainFrame = CreateObject("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    BackgroundColor3 = KeySystemData.Colors.Background,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 2,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.new(0, 350, 0, 250),
    ClipsDescendants = true,
    Active = true -- FIX: Active true
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8), Parent = MainFrame})

local TitleBar = CreateObject("Frame", {
    Name = "TitleBar",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Background,
    Size = UDim2.new(1, 0, 0, 30),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 0),
    Active = true
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 8, 0, 0), Parent = TitleBar})

local Title = CreateObject("TextLabel", {
    Name = "Title",
    Parent = TitleBar,
    BackgroundTransparency = 1,
    Text = KeySystemData.Name .. " Key System",
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 200, 0, 20),
    Font = Enum.Font.GothamBold,
    TextColor3 = KeySystemData.Colors.Title,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0.5)
})

local KeyInput = CreateObject("TextBox", {
    Name = "KeyInput",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.InputField,
    Text = "",
    PlaceholderText = "Enter your key here...",
    Position = UDim2.new(0.5, 0, 0.3, 0),
    Size = UDim2.new(0, 280, 0, 35),
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(220, 220, 220),
    PlaceholderColor3 = Color3.fromRGB(140, 140, 140),
    TextXAlignment = Enum.TextXAlignment.Left,
    AnchorPoint = Vector2.new(0.5, 0),
    ClipsDescendants = true,
    ClearTextOnFocus = false
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = KeyInput})
CreateObject("UIStroke", {
    Parent = KeyInput,
    Color = KeySystemData.Colors.InputFieldBorder,
    Thickness = 1,
    Transparency = 0.8
})
CreateObject("UIPadding", {
    Parent = KeyInput,
    PaddingLeft = UDim.new(0, 10)
})

local SubmitButton = CreateObject("TextButton", {
    Name = "ValidateButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Button,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 1,
    Position = UDim2.new(0.3, 0, 0.55, 0),
    Size = UDim2.new(0, 110, 0, 32),
    Text = "Verify Key",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = KeySystemData.Colors.Title,
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Active = true,
    ZIndex = 2
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = SubmitButton})

local GetKeyButton = CreateObject("TextButton", {
    Name = "GetKeyButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Button,
    BorderColor3 = KeySystemData.Colors.InputFieldBorder,
    BorderSizePixel = 1,
    Position = UDim2.new(0.7, 0, 0.55, 0),
    Size = UDim2.new(0, 110, 0, 32),
    Text = "Get Key",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = KeySystemData.Colors.Title,
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Active = true,
    ZIndex = 2
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = GetKeyButton})

local DiscordButton = CreateObject("TextButton", {
    Name = "DiscordButton",
    Parent = MainFrame,
    BackgroundColor3 = KeySystemData.Colors.Discord,
    Position = UDim2.new(0.5, 0, 0.75, 0),
    Size = UDim2.new(0, 220, 0, 32),
    Text = "Join Discord",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    AutoButtonColor = false,
    AnchorPoint = Vector2.new(0.5, 0),
    Active = true,
    ZIndex = 2
})
CreateObject("UICorner", {CornerRadius = UDim.new(0, 6), Parent = DiscordButton})

local StatusLabel = CreateObject("TextLabel", {
    Name = "StatusLabel",
    Parent = MainFrame,
    BackgroundTransparency = 1,
    Position = UDim2.new(0.5, 0, 0.9, 0),
    Size = UDim2.new(0, 280, 0, 20),
    Font = Enum.Font.Gotham,
    Text = "",
    TextColor3 = KeySystemData.Colors.Error,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Center,
    AnchorPoint = Vector2.new(0.5, 0),
    TextTransparency = 1
})

local function ShowStatusMessage(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color
    StatusLabel.TextTransparency = 0
    SmoothTween(StatusLabel, 0.3, {TextTransparency = 0})
    
    task.spawn(function()
        task.wait(3)
        if StatusLabel.Text == text then
            SmoothTween(StatusLabel, 0.5, {TextTransparency = 1})
        end
    end)
end

local function openGetKey()
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local API_KEY = Config.api
    local PROVIDER = Config.provider
    local SERVICE = Config.service
    local link = JunkieKeySystem.getLink(API_KEY, PROVIDER, SERVICE)
    if link then
        if setclipboard then
            setclipboard(link)
            ShowStatusMessage("Copied to clipboard!", KeySystemData.Colors.Success)
        else
            ShowStatusMessage("Link created", KeySystemData.Colors.Success)
        end
    else
        ShowStatusMessage("Failed to generate link", KeySystemData.Colors.Error)
    end
end

local function validateKey()
    local userKey = KeyInput.Text:gsub("%s+", "")
    if not userKey or userKey == "" then
        ShowStatusMessage("Enter a key first!", KeySystemData.Colors.Error)
        return
    end

    ShowStatusMessage("Checking...", Color3.fromRGB(255, 165, 0))
    local JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    local API_KEY = Config.api
    local SERVICE = Config.service
    local isValid = JunkieKeySystem.verifyKey(API_KEY, userKey, SERVICE)
    
    if isValid then
        ShowStatusMessage("Success!", KeySystemData.Colors.Success)
        SmoothTween(MainFrame, 0.5, {
            Position = UDim2.new(0.5, 0, -0.5, 0),
            BackgroundTransparency = 1
        })
        task.wait(0.5)
        ScreenGui:Destroy()
        main() -- START MOBILE MAIN
    else
        ShowStatusMessage("Wrong Key!", KeySystemData.Colors.Error)
    end
end

SubmitButton.MouseButton1Click:Connect(validateKey)
GetKeyButton.MouseButton1Click:Connect(openGetKey)

-- Simple Dragging Logic (Fixed for Mobile)
local dragging, dragInput, dragStart, startPos
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

DiscordButton.MouseButton1Click:Connect(function()
    local discordUrl = "https://discord.gg/" .. KeySystemData.DiscordInvite
    if setclipboard then
        setclipboard(discordUrl)
        ShowStatusMessage("Discord Copied!", Color3.fromRGB(123, 48, 220))
    end
end)

-- Start Animation
MainFrame.Position = UDim2.new(0.5, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.BackgroundTransparency = 1
SmoothTween(MainFrame, 0.5, {
    Size = UDim2.new(0, 350, 0, 250), 
    Position = UDim2.new(0.5, 0, 0.5, 0),
    BackgroundTransparency = 0
})
