_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

Hooks:PostHook(PlayerTweakData, "_init_new_stances", "S2PP2S_PlayerTweakData__init_new_stances", function(ptw)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if ptw and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate"
			if ptw and ptw.stances[weapon_id] then
				ptw.stances[second_weapon_id] = deep_clone(ptw.stances[weapon_id])
			end
		end
	end
end )