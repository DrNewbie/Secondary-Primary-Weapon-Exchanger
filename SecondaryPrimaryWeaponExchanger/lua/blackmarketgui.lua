_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

local _f_BlackMarketGui_reload = BlackMarketGui.reload

function BlackMarketGui:reload()
	SecondaryPrimaryWeapon:_BlackMarketManager_load_done()
	_f_BlackMarketGui_reload(self)
end