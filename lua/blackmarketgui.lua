_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

Hooks:PreHook(BlackMarketGui, "reload", "S2PP2S_BlackMarketGui_reload", function(...)
	SecondaryPrimaryWeapon:_BlackMarketManager_load_done()
end )