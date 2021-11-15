local x =   // расположение худа
local y = 



local function HUDHide (hudo) // Выключаем стандартные худы от гмода
	for k, v in pairs ('CHudHealth', 'CHudBattery', 'CHudAmmo') do 
		if hudo == v then return false end
	end
end

hook.Add('HUDShouldDraw', 'hideoff', HUDHide)

local function HolyHud() // рисуем само начало худа
	draw.RoundedBox(5, x, y, 200, 27, Color())


hook.Add('HUDPaint', 'holyhud', HolyHud)