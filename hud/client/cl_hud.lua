AddCSLuaFile("cl_fonts.lua") 
include("client/cl_fonts.lua")// подгружаем шрифты

local x =   // расположение худа
local y = 
local logo = "materials/logo.png"



local function HUDHide (hudo) // Выключаем стандартные худы от гмода
	for k, v in pairs ('CHudHealth', 'CHudBattery', 'CHudAmmo') do 
		if hudo == v then return false end
	end
end

hook.Add('HUDShouldDraw', 'hideoff', HUDHide)

local function HolyHud() 

	local ply = LocalPlayer() //облегчаем,обозначаем обозначения
	local hp = Ply:Health() 
	local arm = Ply:Armor() 
	local maxhp = GetMaxHealth() 

	draw.RoundedBox(5, x, y, 200, 27, Color()) // рисуем само начало худа

end

hook.Add('HUDPaint', 'holyhud', HolyHud)