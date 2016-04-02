_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

local _f_PlayerTweakData_init_new_stances = PlayerTweakData._init_new_stances

function PlayerTweakData:_init_new_stances()
	_f_PlayerTweakData_init_new_stances(self)
	SecondaryPrimaryWeapon:_init_new_stances(self)
end

function SecondaryPrimaryWeapon:_init_new_stances(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			local second_weapon_id = weapon_id .. "_duplicate"
			if them and them.stances[weapon_id] then
				them.stances[second_weapon_id] = deep_clone(them.stances[weapon_id])
			end
		end
	end
end