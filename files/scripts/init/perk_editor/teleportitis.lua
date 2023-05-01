dofile_once("mods/da_mod/lib/lib.lua")

local perk = "TELEPORTITIS"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].game_effect = nil
	perk_list[idx].func = function(entity_perk_item, entity_who_picked, item_name)
		EntityAddComponent(entity_who_picked, "LuaComponent", {
			_tags = "perk_component",
			script_damage_received = "mods/da_mod/files/scripts/perks/teleportitis.lua",
			execute_every_n_frame = "-1",
		})
		-- Need to manually add the damage resistance since the original game effect isn't used anymore
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance / 1.2
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
	end
	perk_list[idx].func_remove = function(entity_who_picked)		
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance * 1.2
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
	end
	perk_list[idx].usable_by_enemies = true
	perk_list[idx].func_enemy = function(entity_perk_item, entity_who_picked, item_name)
		EntityAddComponent(entity_who_picked, "LuaComponent", {
			_tags = "perk_component",
			script_damage_received = "mods/da_mod/files/scripts/perks/teleportitis.lua",
			execute_every_n_frame = "-1",
		})
		-- Need to manually add the damage resistance since the original game effect isn't used anymore
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance / 1.2
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
	end
end