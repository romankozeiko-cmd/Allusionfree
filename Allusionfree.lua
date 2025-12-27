-- Ждем, пока игрок полностью загрузится, чтобы не мешать Key System
repeat task.wait(1) until game:IsLoaded()

local player = game:GetService("Players").LocalPlayer

-- Функция для экипировки Combat
local function startEquipLoop()
    while true do
        -- Ждем 2 секунды между проверками, чтобы не лагало на телефоне
        task.wait(2)
        
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local backpack = player:FindFirstChild("Backpack")
            
            -- Проверяем: если предмета нет в руках, берем из рюкзака
            if not character:FindFirstChild("Combat") then
                if backpack then
                    local item = backpack:FindFirstChild("Combat")
                    if item then
                        character.Humanoid:EquipTool(item)
                    end
                end
            end
        end
    end
end

-- Ждем появления персонажа (это гарантирует, что меню ключа уже прогрузилось)
if not player.Character then
    player.CharacterAdded:Wait()
end

-- Даем еще 5 секунд на ввод ключа в Mobile Hub, прежде чем скрипт начнет работать
task.delay(5, function()
    print("Авто-экипировка запущена!")
    startEquipLoop()
end)
