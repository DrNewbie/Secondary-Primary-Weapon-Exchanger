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

local _f_WeaponTweakData_precalculate_values = WeaponTweakData._precalculate_values
function WeaponTweakData:_precalculate_values()
	_f_WeaponTweakData_precalculate_values(self)
	SecondaryPrimaryWeapon:_init_data_weapon_npc(self)
end

local _f_WeaponTweakData_init_new_weapons = WeaponTweakData._init_new_weapons
function WeaponTweakData:_init_new_weapons(...)
	_f_WeaponTweakData_init_new_weapons(self, ...)
	SecondaryPrimaryWeapon:_init_new_weapons(self)	
end

local _f_WeaponTweakData_init_data_offhand_weapons = WeaponTweakData._init_data_offhand_weapons
function WeaponTweakData:_init_data_offhand_weapons()
	_f_WeaponTweakData_init_data_offhand_weapons(self)
	SecondaryPrimaryWeapon:_init_data_offhand_weapons(self)
end

local _f_WeaponTweakData_create_table_structure = WeaponTweakData._create_table_structure
function WeaponTweakData:_create_table_structure()
	_f_WeaponTweakData_create_table_structure(self)
	SecondaryPrimaryWeapon:_create_table_structure(self)
end

function SecondaryPrimaryWeapon:_init_data_weapon_npc(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate_npc"
			local weapon_id2 = weapon_id .. "_npc"
			if them then
				if them[weapon_id2] then
					weapon_id = weapon_id2
					if weapon_id and weapon_id ~= "" and them[weapon_id] then
						them[second_weapon_id] = deep_clone(them[weapon_id])
						them[second_weapon_id].use_data.selection_index = them[weapon_id].use_data.selection_index == 1 and 2 or 1
					end
				else
					weapon_id = "NONE_LATER_FIXED"
				end
			end
		end
	end
end

function SecondaryPrimaryWeapon:_init_new_weapons(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate"
			if them and them[weapon_id] then
				them[second_weapon_id] = deep_clone(them[weapon_id])
				them[second_weapon_id].use_data.selection_index = them[weapon_id].use_data.selection_index == 1 and 2 or 1
				them[second_weapon_id].animations.reload_name_id = weapon_id
				them[second_weapon_id].use_stance = weapon_id
				them[second_weapon_id].texture_name = weapon_id
				them[second_weapon_id].weapon_hold = weapon_id
			end
		end
	end
end

function SecondaryPrimaryWeapon:_init_data_offhand_weapons(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate"
			if them[weapon_id] then
				them[second_weapon_id] = deep_clone(them[weapon_id])
				them[second_weapon_id].use_data.selection_index = them[weapon_id].use_data.selection_index == 1 and 2 or 1
				them[second_weapon_id].animations.reload_name_id = weapon_id
				them[second_weapon_id].use_stance = weapon_id
				them[second_weapon_id].texture_name = weapon_id
				them[second_weapon_id].weapon_hold = weapon_id
			end
		end
	end
end

function SecondaryPrimaryWeapon:_create_table_structure(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate_npc"
			local weapon_id2 = weapon_id .. "_npc"
			if them[weapon_id2] then
				weapon_id = weapon_id2
				if weapon_id and weapon_id ~= "" and them[weapon_id] then
					them[second_weapon_id] = deep_clone(them[weapon_id])
				end
			else
				weapon_id = "NONE_LATER_FIXED"
			end
		end	
	end
end