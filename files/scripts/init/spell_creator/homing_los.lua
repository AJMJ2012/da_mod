dofile_once("mods/da_mod/lib/lib.lua")

AddSpell({
	id                     = "HOMING_LOS",
	name 		           = "$action_homing_los",
	description            = "$actiondesc_homing_los",
	sprite 		           = "mods/da_mod/files/ui_gfx/gun_actions/homing_los.png",
	sprite_unidentified    = "data/ui_gfx/gun_actions/homing_unidentified.png",
	related_extra_entities = { "mods/da_mod/files/entities/misc/homing_los.xml" },
	type 		           = ACTION_TYPE_MODIFIER, --ACTION_TYPE_UTILITY,
	spawn_level            = "1,2,3,4,5,6",
	spawn_probability      = "0.2,0.8,0.8,0.8,0.8,0.8",
	price                  = 320,
	mana                   = 20,
	action                 = function()
		c.extra_entities = c.extra_entities .. "mods/da_mod/files/entities/misc/homing_los.xml,"
		draw_actions( 1, true )
	end,
})