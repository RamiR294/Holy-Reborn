
local x = 15  // расположение худа
local y = ScrH() - 150
local w, h = 300, 20
local lerphp, lerparm, lerphg = 100, 0, 100

local logo = "materials/logo.png"
local tlogo = "materials/tlogo.png"


function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", })do
		if name == v then return false end
	end
	if togglethirdperson then
		if name == "CHudCrosshair" then
			return false
		end
	else
		if name == "CHudCrosshair" then
			return true
		end
	end
end

hook.Add("HUDShouldDraw", "HideOurHud", hidehud)

local function HolyHud() 

	local ply = LocalPlayer() //облегчаем,обозначаем обозначения
	local hp = ply:Health()/100 
	local arm = ply:Armor() 
	local maxhp = ply:GetMaxHealth() 

	draw.RoundedBox(5, x, y, math.Clamp(200*hp, 0, maxhp), 27, Color(255,255,255,255)) // рисуем само начало худа
end

hook.Add('HUDPaint', 'holyhud', HolyHud)
