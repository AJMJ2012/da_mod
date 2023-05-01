dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/projectiles/homing_cursor.lua"
-- Homes in on cursor instead of rotating towards direction
script.prepend([[local x,y = EntityGetTransform( entity_id ) local mouse_x, mouse_y = DEBUG_GetMouseWorld() dir = 0 - math.atan2(mouse_y - y, mouse_x - x)]], [[local dir2 = 0 - math.atan2( vel_y, vel_x )]], file)