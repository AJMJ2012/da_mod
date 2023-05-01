dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/entities/projectiles/deck/pollen.xml"
-- Remove Friendly Fire
script.replace([[friendly_fire="0"]], [[friendly_fire="1"]], file)
