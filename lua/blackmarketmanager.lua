_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}

local _f_BlackMarketManager_load_done = BlackMarketManager._load_done
local _f_BlackMarketManager_equipped_item = BlackMarketManager.equipped_item

function BlackMarketManager:_load_done()
	_f_BlackMarketManager_load_done(self)
	SecondaryPrimaryWeapon:_BlackMarketManager_load_done()
end

function BlackMarketManager:equipped_item(...)
	SecondaryPrimaryWeapon:_BlackMarketManager_load_done()
	return _f_BlackMarketManager_equipped_item(self, ...)
end

function SecondaryPrimaryWeapon:_BlackMarketManager_load_done()
	local _list = SecondaryPrimaryWeapon.List or {}
	local _weapon = Global.blackmarket_manager.weapons or {}
	if _weapon and _list then
		for weapon_id, v in pairs(_list) do
			weapon_id = tostring(weapon_id)
			if v and v[1] == true then
				local second_weapon_id = weapon_id .. "_duplicate"
				if weapon_id and weapon_id ~= "" and _weapon[weapon_id] and _weapon[second_weapon_id] then
					_weapon[second_weapon_id].unlocked = _weapon[weapon_id].unlocked
					if not _weapon[second_weapon_id].unlocked then
						_weapon[second_weapon_id].equipped = false
						managers.blackmarket:_verfify_equipped_category("primaries")
						managers.blackmarket:_verfify_equipped_category("secondaries")
					end
				end
			end
		end
	end
end