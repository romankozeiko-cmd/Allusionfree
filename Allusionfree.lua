Config = {
    api = "7a4939b2-37ac-4a92-98d2-b2bacdf36791", 
    service = "Saltink",
    provider = "Anubis"
}

-- ФУНКЦИЯ MAIN: Основной скрипт
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
    print("Hack Script: Auto-Clicker Started")

    task.spawn(function()
        while true do
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(851, 158), workspace.CurrentCamera.CFrame)
            task.wait(0.05) 
        end
    end)

    task.spawn(function()
        local player = game:GetService("Players").LocalPlayer
        while true do
            wait(15)
            player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Waiting.Titan.qw.CFrame
            wait(8)
            if game:GetService("Workspace").RespawnMobs.Titan.Titan.Titan  then
                player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnMobs.Titan.Titan.CFrame
            end
            wait (27)
            player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Bosses.Waiting.Muscle.qw.CFrame
            wait(8)
            if game:GetService("Workspace").RespawnMobs.Muscle.Muscle then
                player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").RespawnMobs.Muscle.Muscle.CFrame
            end
            task.wait(1)
        end
    end)
end

-- ЛОГИКА АВТО-ПРОВЕРКИ КЛЮЧА --
local function checkKeySilent()
    local userKey = _G.Key or ""
    userKey = userKey:gsub("%s+", "") -- Убираем пробелы
    
    if userKey == "" then
        warn("Ключ не найден! Введите его в _G.Key в начале скрипта.")
        return false
    end

    -- Загружаем SDK системы ключей
    local success, JunkieKeySystem = pcall(function()
        return loadstring(game:HttpGet("https://junkie-development.de/sdk/JunkieKeySystem.lua"))()
    end)

    if not success then
        warn("Ошибка загрузки системы ключей!")
        return false
    end

    local isValid = JunkieKeySystem.verifyKey(Config.api, userKey, Config.service)
    return isValid
end

-- Запуск
if checkKeySilent() then
    main()
else
    -- Если ключ неверный, можно вывести уведомление в консоль или создать GUI (как было раньше)
    warn("Ключ неверный или истек! Скрипт остановлен.")
    
    -- ОПЦИОНАЛЬНО: Если хотите, чтобы GUI всё-таки открывалось при ошибке ключа, 
    -- сюда можно вставить ваш старый код отрисовки ScreenGui.
end
