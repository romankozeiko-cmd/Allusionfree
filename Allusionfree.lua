--[[
    ANUBIS HUB: SUPER-LITE (MOBILE STABLE)
]]

local Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791", 
    service = "Saltink",
    provider = "Anubis"
}

-- 1. Функция самого чита (Main)
local function startScript()
    print("SUCCESS: LOADING MAIN SCRIPT")
    -- Твой основной функционал (авто-кликер и ТП)
    local player = game:GetService("Players").LocalPlayer
    local VirtualUser = game:GetService("VirtualUser")
    
    task.spawn(function()
        while task.wait(0.05) do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
        end
    end)

    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                -- Твой цикл телепортации здесь
                task.wait(15)
                player.Character.HumanoidRootPart.CFrame = workspace.Bosses.Waiting.Titan.qw.CFrame
            end)
        end
    end)
end

-- 2. Попытка загрузки системы ключей
local Junkie = nil
local success, err = pcall(function()
    return loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
end)
Junkie = success and err or nil

-- 3. Создание простейшего интерфейса
local sg = Instance.new("ScreenGui", game:GetService("CoreGui"))
local frame = Instance.new("Frame", sg)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true -- Включено стандартное перетаскивание Roblox

local label = Instance.new("TextLabel", frame)
label.Size = UDim2.new(1, 0, 0, 30)
label.Text = "ANUBIS KEY SYSTEM"
label.TextColor3 = Color3.new(1, 0, 0)

local box = Instance.new("TextBox", frame)
box.Size = UDim2.new(0, 250, 0, 40)
box.Position = UDim2.new(0.5, 0, 0.4, 0)
box.AnchorPoint = Vector2.new(0.5, 0.5)
box.Text = ""
box.PlaceholderText = "Paste Key Here"

local btnV = Instance.new("TextButton", frame)
btnV.Size = UDim2.new(0, 120, 0, 40)
btnV.Position = UDim2.new(0.25, 0, 0.75, 0)
btnV.AnchorPoint = Vector2.new(0.5, 0.5)
btnV.Text = "VERIFY"
btnV.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnV.TextColor3 = Color3.new(1,1,1)

local btnG = Instance.new("TextButton", frame)
btnG.Size = UDim2.new(0, 120, 0, 40)
btnG.Position = UDim2.new(0.75, 0, 0.75, 0)
btnG.AnchorPoint = Vector2.new(0.5, 0.5)
btnG.Text = "GET LINK"
btnG.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
btnG.TextColor3 = Color3.new(1,1,1)

if not Junkie then
    label.Text = "ERROR: SYSTEM OFFLINE"
    box.Text = tostring(err) -- Выведет ошибку загрузки, если она есть
end

-- 4. Логика кнопок через Activated (лучше для мобильных)
btnG.Activated:Connect(function()
    if Junkie then
        local link = Junkie.getLink(Config.api, Config.provider, Config.service)
        box.Text = link
        if setclipboard then setclipboard(link) end
        label.Text = "COPIED TO BOX"
    end
end)

btnV.Activated:Connect(function()
    if Junkie then
        label.Text = "CHECKING..."
        local key = box.Text:gsub("%s+", "")
        local is_valid = Junkie.verifyKey(Config.api, key, Config.service)
        if is_valid then
            label.Text = "VALID!"
            task.wait(1)
            sg:Destroy()
            startScript()
        else
            label.Text = "INVALID KEY"
        end
    end
end)
