if not game:IsLoaded() then
    repeat task.wait(3) until game:IsLoaded()
end
local Allusion_DarkLoader = "https://raw.githubusercontent.com/darkallusion1/Allusion/refs/heads/main/Loader.lua"
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local PlaceId = game.PlaceId
local Games = {
    [0] = "",
}
local FoundGame = Games[PlaceId] or false
local FoundGame2 = Allusion_DarkLoader ~= "" and loadstring(game:HttpGet(Allusion_DarkLoader))() or false
if FoundGame then
    loadstring(game:HttpGet(FoundGame))()
elseif FoundGame2 then
    FoundGame2()
else
    Player:Kick("Allusion : Game Not Support")
end
