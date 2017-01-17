_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}
------------------
--- Clone list ---
------------------
SecondaryPrimaryWeapon.List = {}

local file = io.open("mods/SecondaryPrimaryWeaponExchanger/weapons.txt", "r")
if file then
	local txt = file:read("*a")
	file:close()
	SecondaryPrimaryWeapon.List = assert(loadstring("return {\n".. txt .."\n}"))()
	txt = ""
end
------------------
------------------
------------------

Hooks:PostHook(WeaponTweakData, "_precalculate_values", "S2PP2S_WeaponTweakData__precalculate_values", function(wtt)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if wtt and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate_npc"
			local weapon_id2 = weapon_id .. "_npc"
			if wtt then
				if wtt[weapon_id2] then
					weapon_id = weapon_id2
					if weapon_id and weapon_id ~= "" and wtt[weapon_id] then
						wtt[second_weapon_id] = deep_clone(wtt[weapon_id])
						wtt[second_weapon_id].use_data.selection_index = wtt[weapon_id].use_data.selection_index == 1 and 2 or 1
					end
				else
					weapon_id = "NONE_LATER_FIXED"
				end
			end
		end
	end
end )

Hooks:PostHook(WeaponTweakData, "_init_new_weapons", "S2PP2S_WeaponTweakData__init_new_weapons", function(wtt)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if wtt and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate"
			if wtt and wtt[weapon_id] then
				wtt[second_weapon_id] = deep_clone(wtt[weapon_id])
				wtt[second_weapon_id].use_data.selection_index = wtt[weapon_id].use_data.selection_index == 1 and 2 or 1
				wtt[second_weapon_id].animations.reload_name_id = weapon_id
				wtt[second_weapon_id].use_stance = weapon_id
				wtt[second_weapon_id].texture_name = weapon_id
				wtt[second_weapon_id].weapon_hold = weapon_id
			end
		end
	end
end )

Hooks:PostHook(WeaponTweakData, "_init_data_offhand_weapons", "S2PP2S_WeaponTweakData__init_data_offhand_weapons", function(wtt)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if wtt and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate"
			if wtt[weapon_id] then
				wtt[second_weapon_id] = deep_clone(wtt[weapon_id])
				wtt[second_weapon_id].use_data.selection_index = wtt[weapon_id].use_data.selection_index == 1 and 2 or 1
				wtt[second_weapon_id].animations.reload_name_id = weapon_id
				wtt[second_weapon_id].use_stance = weapon_id
				wtt[second_weapon_id].texture_name = weapon_id
				wtt[second_weapon_id].weapon_hold = weapon_id
			end
		end
	end
end )

Hooks:PostHook(WeaponTweakData, "_f_WeaponTweakData_create_table_structure", "S2PP2S_WeaponTweakData__f_WeaponTweakData_create_table_structure", function(wtt)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if wtt and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate_npc"
			local weapon_id2 = weapon_id .. "_npc"
			if wtt[weapon_id2] then
				weapon_id = weapon_id2
				if weapon_id and weapon_id ~= "" and wtt[weapon_id] then
					wtt[second_weapon_id] = deep_clone(wtt[weapon_id])
				end
			else
				weapon_id = "NONE_LATER_FIXED"
			end
		end	
	end
end )