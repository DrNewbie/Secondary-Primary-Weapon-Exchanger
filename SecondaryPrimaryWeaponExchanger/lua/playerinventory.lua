local _f10 = PlayerInventory.add_unit
function PlayerInventory:add_unit(new_unit, is_equip, equip_is_instant)
	local new_selection = {}
	local use_data = new_unit:base():get_use_data(self._use_data_alias)
	new_selection.use_data = use_data
	new_selection.unit = new_unit
	new_unit:base():add_destroy_listener(self._listener_id, callback(self, self, "clbk_weapon_unit_destroyed"))
	local selection_index = use_data.selection_index
	local _factory_id = new_unit:base()._factory_id or ""
	if _factory_id:find("duplicate") then
		use_data.selection_index = use_data.selection_index == 1 and 2 or 1
	end
	_f10(self, new_unit, is_equip, equip_is_instant)
end