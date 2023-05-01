dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "da_mod"
mod_settings_version = 1
mod_settings = {
	{
		id = "start_perk",
		ui_name = "Spawn Starting Perks",
		value_default = true,
		scope = MOD_SETTING_SCOPE_NEW_GAME,
	},
	{
		id = "combine_gold",
		ui_name = "Combine Gold Drops",
		ui_description = "Affected by Attract Gold perk",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "attract_gold_los",
		ui_name = "Gold Attraction Requires Line of Sight",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	},
	{
		id = "enemies_attract_exploding_gold",
		ui_name = "Enemies Attract Exploding Gold",
		ui_description = "Only when you have the Attract Gold perk",
		value_default = true,
		scope = MOD_SETTING_SCOPE_NEW_GAME,
	},
	{
		id = "healing_hearts",
		ui_name = "Healing Hearts",
		value_default = true,
		scope = MOD_SETTING_SCOPE_NEW_GAME,
	},
	{
		id = "world_chaos",
		ui_name = "World descends into chaos when you die",
		ui_description = "May cause issues when using any respawn mods.",
		value_default = false,
		scope = MOD_SETTING_SCOPE_RUNTIME,
	}
}


function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id )
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end
