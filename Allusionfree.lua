--[[
    YOUTUBE TUTORIAL: https://www.youtube.com/watch?v=Yb2GXlsTmNM
    MADE BY @uerd
    MOBILE OPTIMIZED VERSION
]]

Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791", 
    service = "Saltink",
    provider = "Anubis"
}

-- Предварительная загрузка библиотеки (чтобы не было бесконечной загрузки при клике)
local JunkieKeySystem = nil
local success_load = pcall(function()
    JunkieKeySystem = loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
end)

local function main()
    print("Key Validated! Starting Script...")
    
    local ITEM_NAME = "Combat" 
    local player = game:GetService("Players").LocalPlayer

    -- Авто-экипировка
    task.spawn(function()
        while true do
            local char = player.Character
            if char and char:FindFirstChildOfClass("Humanoid") then
                local backpack = player:FindFirstChild("Backpack")
                if not char:FindFirstChild(ITEM_NAME) and backpack then
                    local item = backpack:FindFirstChild(ITEM_NAME)
                    if item then char.Humanoid:EquipTool(item) end
                end
            end
            task.wait(2)
        end
    end)

    -- Авто-кликер
    local VirtualUser = game:GetService("VirtualUser")
    task.spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
            task.wait(0.05) 
        end
    end)

    -- Телепорт (Боссы)
    task.spawn(function()
        while true do
            task.wait(15)
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                pcall(function()
                    player.Character.HumanoidRootPart.CFrame = workspace.Bosses.Waiting.Titan.qw.CFrame
                    task.wait(8)
                    if workspace.RespawnMobs.Titan.Titan:FindFirstChild("Titan") then
                        player.Character.HumanoidRootPart.CFrame = workspace.RespawnMobs.Titan.Titan.CFrame
                    end
                    task.wait(27)
                    player.Character.HumanoidRootPart.CFrame = workspace.Bosses.Waiting.Muscle.qw.CFrame
                    task.wait(8)
                    if workspace.RespawnMobs.Muscle:FindFirstChild("Muscle") then
                        player.Character.HumanoidRootPart.CFrame = workspace.RespawnMobs.Muscle.Muscle.CFrame
                    end
                end)
            end
            task.wait(1)
        end
    end)
end

if getgenv().RedExecutorKeySys then return end
getgenv().RedExecutorKeySys = true

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "AnubisKeySys"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.Size = UDim2.new(0, 320, 0, 220)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(220, 50, 50)

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "ANUBIS HUB | KEY SYSTEM"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.TextColor3 = Color3.fromRGB(220, 50, 50)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local KeyInput = Instance.new("TextBox", MainFrame)
KeyInput.PlaceholderText = "Paste key or link here..."
KeyInput.Size = UDim2.new(0, 260, 0, 40)
KeyInput.Position = UDim2.new(0.5, 0, 0.4, 0)
KeyInput.AnchorPoint = Vector2.new(0.5, 0.5)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyInput.TextColor3 = Color3.new(1,1,1)
KeyInput.ClearTextOnFocus = false
KeyInput.Text = ""

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.BackgroundTransparency = 1
Status.Text = not success_load and "API Error! Re-execute script." or "Ready"
Status.TextColor3 = Color3.new(1, 1, 1)
Status.TextSize = 12

-- Кнопки
local function CreateBtn(name, pos, text, color)
    local b = Instance.new("TextButton", MainFrame)
    b.Name = name
    b.Size = UDim2.new(0, 120, 0, 35)
    b.Position = pos
    b.AnchorPoint = Vector2.new(0.5, 0.5)
    b.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    b.Text = text
    b.TextColor3 = color
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    Instance.new("UICorner", b)
    return b
end

local VerifyBtn = CreateBtn("Verify", UDim2.new(0.3, 0, 0.65, 0), "Verify Key", Color3.fromRGB(80, 200, 80))
local GetBtn = CreateBtn("Get", UDim2.new(0.7, 0, 0.65, 0), "Get Key", Color3.fromRGB(220, 50, 50))

-- Логика кнопок
GetBtn.Activated:Connect(function()
    if not JunkieKeySystem then Status.Text = "API not loaded!"; return end
    Status.Text = "Getting link..."
    local link = JunkieKeySystem.getLink(Config.api, Config.provider, Config.service)
    if link then
        KeyInput.Text = link
        pcall(function() setclipboard(link) end)
        Status.Text = "Link copied to clipboard/textbox!"
        Status.TextColor3 = Color3.new(0,1,0)
    else
        Status.Text = "Error getting link!"
    end
end)

VerifyBtn.Activated:Connect(function()
    if not JunkieKeySystem then Status.Text = "API not loaded!"; return end
    local key = KeyInput.Text:gsub("%s+", "")
    if key == "" then Status.Text = "Enter key first!"; return end
    
    Status.Text = "Checking key..."
    Status.TextColor3 = Color3.new(1, 1, 0)
    
    -- Проверка ключа
    task.spawn(function()
        local ok, valid = pcall(function()
            return JunkieKeySystem.verifyKey(Config.api, key, Config.service)
        end)
        
        if ok and valid then
            Status.Text = "Valid! Loading..."
            Status.TextColor3 = Color3.new(0,1,0)
            task.wait(1)
            ScreenGui:Destroy()
            main()
        else
            Status.Text = "Invalid key! Try again."
            Status.TextColor3 = Color3.new(1,0,0)
        end
    end)
end)

-- Драг (перетаскивание)
local dragging, dragStart, startPos
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
