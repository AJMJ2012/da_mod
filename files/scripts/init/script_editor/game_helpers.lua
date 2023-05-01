dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/game_helpers.lua"
-- Add the library
script.prepend([[dofile_once( "mods/da_mod/lib/floaty_text.lua" )]], [[function heal_entity( entity_id, heal_amount )]], file)
-- Add the function call
script.append([[floaty_number( entity_id, math.floor((heal_amount * 25) + 0.5), "heal_world_text", "mods/da_mod/files/fonts/font_heal.xml", math.abs(ComponentGetValue2(EntityGetFirstComponent(entity_id, "HitboxComponent"), "aabb_min_y") or 0) + 6 )]], [[EntityAddChild( entity_id, entity_fx )]], file)