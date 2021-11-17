print("Худ успешно завершил загрузку")

HOLY_ADDONS = { }

if (SERVER) then
	AddCSLuaFile()
	AddCSLuaFile 'holy_api/sh_loader.lua'
end
HOLY_ADDONS.LOADER = include 'holy_api/sh_loader.lua'

HOLY_ADDONS.LOADER:IncludeDir('holy_modules/hud', true)
