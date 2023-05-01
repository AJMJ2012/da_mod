dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/items/gold_pickup.lua"
-- Add the library
script.prepend([[dofile_once( "mods/da_mod/lib/floaty_text.lua" )]], [[function item_pickup( entity_item, entity_who_picked, item_name )]], file)
-- Add the function call
script.prepend([[floaty_number( entity_item, value, "gold_world_text", "mods/da_mod/files/fonts/font_gold.xml" )]], [[EntityKill( entity_item )]], file)