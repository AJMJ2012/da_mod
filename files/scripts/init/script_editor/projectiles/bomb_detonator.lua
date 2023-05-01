dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/projectiles/bomb_detonator.lua"
-- Fix if error
script.replace([[if ( id1 == id2 ) and ((test1 == true) or (test2 == true) or (test3 > 2)) then]], [[if ( id1 == id2 ) and ((test1 == true) or (test2 == true) (test3 > 2)) then]], file)