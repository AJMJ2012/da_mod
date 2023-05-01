dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/perks/lukki_minion_movement.lua"
-- Increase enemy targeting range
script.replace([[local targets2 = EntityGetInRadiusWithTag( x, y, 64, "enemy" )]], [[local targets2 = EntityGetInRadiusWithTag( x, y, 32, "enemy" )]], file)