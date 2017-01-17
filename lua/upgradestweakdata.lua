_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

Hooks:PostHook(UpgradesTweakData, "init", "S2PP2S_UpgradesTweakData_init", function(uutw)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if uutw and v and v[1] == true then
			if uutw.definitions[weapon_id] then
				local second_weapon_id = weapon_id .. "_duplicate"
				uutw.definitions[second_weapon_id] = deep_clone(uutw.definitions[weapon_id])
				uutw.definitions[second_weapon_id].weapon_id = second_weapon_id
				uutw.definitions[second_weapon_id].factory_id = uutw.definitions[weapon_id].factory_id .. "_duplicate"
			end
		end
	end
end )