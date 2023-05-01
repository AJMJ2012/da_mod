dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/entities/props/physics_propane_tank.xml"
-- Replace Cold Vapour with Propane Gas
script.replace([[propane_gas]], [[blood_cold_vapour]], file)
