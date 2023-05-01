dofile_once("mods/da_mod/lib/lib.lua")
-- Add LOS Homing
local action = "MISSILE"
local idx = GetTableIndex(actions, action)
if (idx ~= nil) then
	actions[idx].action = function()
		c.extra_entities = c.extra_entities .. "mods/da_mod/files/entities/misc/homing_los.xml,"
		add_projectile("data/entities/projectiles/deck/rocket_player.xml")
		current_reload_time = current_reload_time + 30
		c.spread_degrees = c.spread_degrees + 3.0
		shot_effects.recoil_knockback = shot_effects.recoil_knockback + 60.0
	end
end