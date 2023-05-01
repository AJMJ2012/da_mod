dofile_once("mods/da_mod/lib/lib.lua")

local perk = "TELEPORTITIS_DODGE"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].func = function(entity_perk_item, entity_who_picked, item_name)
		local x,y = EntityGetTransform( entity_who_picked )
		local child_id = EntityLoad( "data/entities/misc/perks/teleportitis_dodge.xml", x, y )
		EntityAddTag( child_id, "perk_entity" )
		EntityAddChild( entity_who_picked, child_id )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "projectile", "slice" }
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
			local resists = { "projectile", "slice" }
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
		local x,y = EntityGetTransform( entity_who_picked )
		local child_id = EntityLoad( "data/entities/misc/perks/teleportitis_dodge.xml", x, y )
		EntityAddTag( child_id, "perk_entity" )
		EntityAddChild( entity_who_picked, child_id )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "projectile", "slice" }
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