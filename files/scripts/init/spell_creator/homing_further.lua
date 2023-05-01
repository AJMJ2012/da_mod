dofile_once("mods/da_mod/lib/lib.lua")

AddSpell({
	id                     = "HOMING_FURTHER",
	name 		           = "$action_homing_further",
	description            = "$actiondesc_homing_further",
	sprite 		           = "mods/da_mod/files/ui_gfx/gun_actions/homing_further.png",
	sprite_unidentified    = "data/ui_gfx/gun_actions/homing_unidentified.png",
	related_extra_entities = { "mods/da_mod/files/entities/misc/homing_further.xml" },
	type 		           = ACTION_TYPE_MODIFIER, --ACTION_TYPE_UTILITY,
	spawn_level            = "1,2,3,4,5,6",
	spawn_probability      = "0.1,0.4,0.4,0.4,0.4,0.4",
	price                  = 320,
	mana                   = 30,
	action                 = function()
		c.extra_entities = c.extra_entities .. "mods/da_mod/files/entities/misc/homing_further.xml,"
		draw_actions( 1, true )
	end,
})