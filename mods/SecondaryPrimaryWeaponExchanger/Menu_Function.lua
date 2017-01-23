Hooks:Add("LocalizationManagerPostInit", "SecondaryPrimaryWeapon_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["SecondaryPrimaryWeapon_menu_title"] = "Weapon Exchanger",
		["SecondaryPrimaryWeapon_menu_desc"] = "Clone weapon and change it from secondary to primary or primary to secondary",
		["SecondaryPrimaryWeapon_menu_forced_update_officially_title"] = "Update , Only Officially",
		["SecondaryPrimaryWeapon_menu_forced_update_officially_desc"] = " ",
		["SecondaryPrimaryWeapon_menu_forced_update_all_title"] = "Update , All",
		["SecondaryPrimaryWeapon_menu_forced_update_all_desc"] = " ",
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", "SecondaryPrimaryWeaponOptions", function( menu_manager, nodes )
	MenuHelper:NewMenu( "SecondaryPrimaryWeapon_menu" )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "SecondaryPrimaryWeaponOptions", function( menu_manager, nodes )
	MenuCallbackHandler.SecondaryPrimaryWeapon_menu_forced_update_all_callback = function(self, item)
		item = item or {}
		item.update_all = true
		MenuCallbackHandler.SecondaryPrimaryWeapon_menu_forced_update_callback(self, item)
	end	
	MenuCallbackHandler.SecondaryPrimaryWeapon_menu_forced_update_callback = function(self, item)
		local _file = io.open('assets/mod_overrides/SecondaryPrimaryWeaponExchanger/main.xml', "w")
		local banned = {saw = true, saw_secondary = true}
		if _file then
			_file:write('<table name=\"SecondaryPrimaryWeaponExchanger\"> \n')
			local _, _, _, _weapon_lists, _, _, _, _, _ = tweak_data.statistics:statistics_table()
			if item.update_all then
				_weapon_lists = {}
				for _weapon_id, _ in pairs(tweak_data.weapon) do
					_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(_weapon_id)
					if _factory_id then
						table.insert(_weapon_lists, _weapon_id)
					end
				end
			end
			local _factory_id = ""
			for _, _weapon_id in pairs(_weapon_lists) do
				if not banned[_weapon_id] and not _weapon_id:find('_besecondary') then
					_factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(_weapon_id)
					if _factory_id then
						local _wd = tweak_data.weapon[_weapon_id] or nil
						local _wfd = tweak_data.weapon.factory[_factory_id] or nil
						if _wd and _wfd then
							local _locked = ''
							_locked = string.format('%s %s', (_wd.global_value and 'global_value="'.. _wd.global_value ..'"' or ''), (_wd.texture_bundle_folder and 'texture_bundle_folder="'.. _wd.texture_bundle_folder ..'"' or ''))
							_file:write('	<WeaponNew> \n')
							_file:write('		<weapon id="'.. _weapon_id ..'_besecondary" based_on="'.. _weapon_id ..'" category="'.. _wd.category ..'" name_id="'.. _wd.name_id ..'" desc_id ="'.. _wd.desc_id ..'" description_id="'.. _wd.description_id ..'" '.. _locked..'> \n')
							if _wd.use_data.selection_index == 1 then
								_file:write('			<use_data selection_index="2"/> \n')
							else
								_file:write('			<use_data selection_index="1"/> \n')
							end
							_file:write('		</weapon> \n')
							_file:write('		<factory id="'.. _factory_id ..'_besecondary" based_on="'.. _factory_id ..'" unit="'.. _wfd.unit ..'"> \n')
							_file:write('			<default_blueprint> \n')
							for _, _part in pairs(_wfd.default_blueprint) do
								_file:write('				<value_node value="'.. _part ..'"/> \n')
							end
							_file:write('			</default_blueprint> \n')
							_file:write('			<uses_parts> \n')
							for _, _part in pairs(_wfd.uses_parts) do
								_file:write('				<value_node value="'.. _part ..'"/> \n')
							end
							_file:write('			</uses_parts> \n')
							_file:write('		</factory> \n')
							_file:write('		<stance/> \n')
							_file:write('	</WeaponNew> \n')
						end
					end
				end
			end
			_file:write('	<Hooks directory="Hooks"> \n')
			_file:write('		<hook file="blackmarketmanager.lua" source_file="lib/managers/blackmarketmanager"/> \n')
			_file:write('		<hook file="weapontweakdata.lua" source_file="lib/tweak_data/weapontweakdata"/> \n')
			_file:write('		<hook file="playerinventory.lua" source_file="lib/units/beings/player/playerinventory"/> \n')
			_file:write('	</Hooks> \n')
			_file:write('</table>')
			_file:close()
			local _dialog_data = {
				title = "[Secondary\\Primary Weapon Exchanger]",
				text = "Please reboot the game.",
				button_list = {{ text = "[OK]", is_cancel_button = true }},
				id = tostring(math.random(0,0xFFFFFFFF))
			}
			managers.system_menu:show(_dialog_data)
		end
	end
	MenuHelper:AddButton({
		id = "SecondaryPrimaryWeapon_menu_forced_update_callback",
		title = "SecondaryPrimaryWeapon_menu_forced_update_officially_title",
		desc = "SecondaryPrimaryWeapon_menu_forced_update_officially_desc",
		callback = "SecondaryPrimaryWeapon_menu_forced_update_callback",
		menu_id = "SecondaryPrimaryWeapon_menu",
	})
	MenuHelper:AddButton({
		id = "SecondaryPrimaryWeapon_menu_forced_update_all_callback",
		title = "SecondaryPrimaryWeapon_menu_forced_update_all_title",
		desc = "SecondaryPrimaryWeapon_menu_forced_update_all_desc",
		callback = "SecondaryPrimaryWeapon_menu_forced_update_all_callback",
		menu_id = "SecondaryPrimaryWeapon_menu",
	})
end)

Hooks:Add("MenuManagerBuildCustomMenus", "SecondaryPrimaryWeaponOptions", function(menu_manager, nodes)
	nodes["SecondaryPrimaryWeapon_menu"] = MenuHelper:BuildMenu( "SecondaryPrimaryWeapon_menu" )
	MenuHelper:AddMenuItem( MenuHelper.menus.lua_mod_options_menu, "SecondaryPrimaryWeapon_menu", "SecondaryPrimaryWeapon_menu_title", "SecondaryPrimaryWeapon_menu_desc")
end)

Announcer:AddHostMod('Weapon Exchanger, (Clone weapon and change it from secondary to primary or primary to secondary)')
Announcer:AddClientMod('Weapon Exchanger, (Clone weapon and change it from secondary to primary or primary to secondary)')