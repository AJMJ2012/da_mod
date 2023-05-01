dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/perks/revenge_rats.lua"
-- don't revenge rat if there is no entity causing damage
script.append([[local ent_x, ent_y = EntityGetTransform(entity_who_caused) if (ent_x == nil or ent_y == nil) then return end]], [[if ( damage < 0 ) or ( #rats >= 20 ) then return end]], file)