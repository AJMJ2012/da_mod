dofile_once("data/scripts/gun/gun_extra_modifiers.lua")

extra_modifiers.lower_spread = function()
--	c.damage_explosion_mul = c.damage_explosion_mul + 0.5
--	c.damage_projectile_mul = c.damage_projectile_mul + 0.5
--	c.fire_rate_wait = c.fire_rate_wait * 1.5
--	shot_effects.recoil_knockback = shot_effects.recoil_knockback * 1.5

	c.damage_projectile_add = c.damage_projectile_add + 0.4
	c.gore_particles    = c.gore_particles + 5
	c.fire_rate_wait    = c.fire_rate_wait + 5
	shot_effects.recoil_knockback = shot_effects.recoil_knockback + 10.0
end