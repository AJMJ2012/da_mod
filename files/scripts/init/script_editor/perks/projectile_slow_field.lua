dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/perks/projectile_slow_field.lua"
-- Fix Y offset
script.append([[y = y - 5]], [[local x, y = EntityGetTransform( entity_id )]], file)
-- Exclude non colliding projectiles
script.append([[if (ComponentGetValueBool(EntityGetFirstComponent(projectile_id, "ProjectileComponent"), "collide_with_world") ~= false) then]], [[for i,projectile_id in ipairs(projectiles) do]], file)
	script.append([[end]], [[end)]], file)