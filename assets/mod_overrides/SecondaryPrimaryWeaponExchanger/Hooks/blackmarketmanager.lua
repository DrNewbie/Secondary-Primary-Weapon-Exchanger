local BeSecondary_BlackMarketManager_get_weapon_icon_path = BlackMarketManager.get_weapon_icon_path

function BlackMarketManager:get_weapon_icon_path(weapon_id, ...)
	if weapon_id and type(weapon_id) == "string" and weapon_id:find("_besecondary") then
		weapon_id = weapon_id:gsub("_besecondary", "")
	end
	return BeSecondary_BlackMarketManager_get_weapon_icon_path(self, weapon_id, ...)
end