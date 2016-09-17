_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

local _f_WeaponFactoryTweakData_init = WeaponFactoryTweakData._init_content_unfinished

function WeaponFactoryTweakData:_init_content_unfinished()
	_f_WeaponFactoryTweakData_init(self)
	SecondaryPrimaryWeapon:_WeaponFactoryTweakData_init(self)
end

function SecondaryPrimaryWeapon:_WeaponFactoryTweakData_init(them)
	local _list = SecondaryPrimaryWeapon.List or {}
	for weapon_id, v in pairs(_list) do
		weapon_id = tostring(weapon_id)
		if them and v and v[1] == true then
			local _factory_id2, _factory_id = "", v[2]
			if them and _factory_id and _factory_id ~= "" and them[_factory_id] then
				_factory_id2 = _factory_id .. "_duplicate"
				them[_factory_id2] = deep_clone(them[_factory_id])
				_factory_id2 = _factory_id2 .. "_npc"
				them[_factory_id2] = deep_clone(them[_factory_id])
			end
		end
	end
end