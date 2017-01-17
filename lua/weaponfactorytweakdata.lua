_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

Hooks:PostHook(WeaponFactoryTweakData, "_init_content_unfinished", "S2PP2S_WeaponFactoryTweakData__init_content_unfinished", function(wff)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if wff and v and v[1] == true then
			local _factory_id2, _factory_id = "", v[2]
			if wff and _factory_id and _factory_id ~= "" and wff[_factory_id] then
				_factory_id2 = _factory_id .. "_duplicate"
				wff[_factory_id2] = deep_clone(wff[_factory_id])
				_factory_id2 = _factory_id2 .. "_npc"
				wff[_factory_id2] = deep_clone(wff[_factory_id])
			end
		end
	end
end )