_G.SecondaryPrimaryWeapon = _G.SecondaryPrimaryWeapon or {}
SecondaryPrimaryWeapon.options_menu = "SecondaryPrimaryWeapon_menu"
SecondaryPrimaryWeapon.ModPath = ModPath
SecondaryPrimaryWeapon.SaveFile = SecondaryPrimaryWeapon.SaveFile or SavePath .. "SecondaryPrimaryWeapon.txt"
SecondaryPrimaryWeapon.ModOptions = SecondaryPrimaryWeapon.ModPath .. "menus/modoptions.txt"
SecondaryPrimaryWeapon.settings = SecondaryPrimaryWeapon.settings or {}

Hooks:Add("LocalizationManagerPostInit", "SecondaryPrimaryWeapon_loc", function(loc)
	LocalizationManager:add_localized_strings({
		["SecondaryPrimaryWeapon_menu_title"] = "Secondary\\Primary Weapon Exchanger",
		["SecondaryPrimaryWeapon_menu_desc"] = "",
		["SecondaryPrimaryWeapon_menu_forced_update_title"] = "Update Defined File",
		["SecondaryPrimaryWeapon_menu_forced_update_desc"] = "",
	})
end)

Hooks:Add("MenuManagerSetupCustomMenus", "SecondaryPrimaryWeaponOptions", function( menu_manager, nodes )
	MenuHelper:NewMenu( SecondaryPrimaryWeapon.options_menu )
end)

Hooks:Add("MenuManagerPopulateCustomMenus", "SecondaryPrimaryWeaponOptions", function( menu_manager, nodes )
	MenuCallbackHandler.SecondaryPrimaryWeapon_menu_forced_update_callback = function(self, item)
		os.remove("mods/SecondaryPrimaryWeaponExchanger/weapons.txt")
		local file = io.open("mods/SecondaryPrimaryWeaponExchanger/weapons.txt", "w")
		local banned = {saw = true, saw_secondary = true}
		if file then
			local _, _, _, weapon_list, _, _, _, _, _ = tweak_data.statistics:statistics_table()
			local factory_id = ""
			for _, weapon_id in pairs(weapon_list) do
				if not weapon_id:find("_duplicate") and not banned[weapon_id] then
					factory_id = managers.weapon_factory:get_factory_id_by_weapon_id(weapon_id)
					if factory_id then
						file:write("".. weapon_id .." = {true, \"".. factory_id .."\"}, \n")				
					end
				end
			end
			file:close()
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
		title = "SecondaryPrimaryWeapon_menu_forced_update_title",
		desc = "SecondaryPrimaryWeapon_menu_forced_update_desc",
		callback = "SecondaryPrimaryWeapon_menu_forced_update_callback",
		menu_id = SecondaryPrimaryWeapon.options_menu,
	})
end)

Hooks:Add("MenuManagerBuildCustomMenus", "SecondaryPrimaryWeaponOptions", function(menu_manager, nodes)
	nodes[SecondaryPrimaryWeapon.options_menu] = MenuHelper:BuildMenu( SecondaryPrimaryWeapon.options_menu )
	MenuHelper:AddMenuItem( MenuHelper.menus.lua_mod_options_menu, SecondaryPrimaryWeapon.options_menu, "SecondaryPrimaryWeapon_menu_title", "SecondaryPrimaryWeapon_menu_desc", 1 )
end)