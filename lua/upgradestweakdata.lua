_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

local _f_UpgradesTweakData_init = UpgradesTweakData.init

function UpgradesTweakData:init()
	_f_UpgradesTweakData_init(self)
	SecondaryPrimaryWeapon:_init_definitions(self)
end

function SecondaryPrimaryWeapon:_init_definitions(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			if them.definitions[weapon_id] then
				local second_weapon_id = weapon_id .. "_duplicate"
				them.definitions[second_weapon_id] = deep_clone(them.definitions[weapon_id])
				them.definitions[second_weapon_id].weapon_id = second_weapon_id
				them.definitions[second_weapon_id].factory_id = them.definitions[weapon_id].factory_id .. "_duplicate"
			end
		end
	end
end