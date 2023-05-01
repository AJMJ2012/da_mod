dofile("mods/da_mod/lib/script_utilities.lua")
-- Add LOS check
script.replace([[if ( distance < distance_full * 1.25 and ( ( ModSettingGet("da_mod.attract_gold_los") and not RaytracePlatforms(x, y, px, py) ) or not ModSettingGet("da_mod.attract_gold_los") ) ) then]], [[if ( distance < distance_full * 1.25 ) then]], "data/scripts/perks/attract_items.lua")