dofile_once("data/scripts/lib/utilities.lua")

local base_global_genome_relations_modifier = nil

-- Try to reset world state to previous if respawned.
function OnPlayerSpawned_WorldChaos(player_entity)
	local world_entity_id = GameGetWorldStateEntity()
	if(world_entity_id ~= nil) then
		local comp_worldstate = EntityGetFirstComponent(world_entity_id, "WorldStateComponent")
		if(comp_worldstate ~= nil) then
			if (base_global_genome_relations_modifier ~= nil) then
				if (ModSettingGet("da_mod.world_chaos")) then
					GamePrint("The chaos is quelled.")
				end
				ComponentSetValue(comp_worldstate, "global_genome_relations_modifier", tostring(base_global_genome_relations_modifier))
				base_global_genome_relations_modifier = nil
			end
		end
	end
end

-- Cause world chaos when you die
function OnPlayerDied_WorldChaos(player_entity)
	local world_entity_id = GameGetWorldStateEntity()
	if(world_entity_id ~= nil) then
		local comp_worldstate = EntityGetFirstComponent(world_entity_id, "WorldStateComponent")
		if(comp_worldstate ~= nil) then
			base_global_genome_relations_modifier = tonumber(ComponentGetValue(comp_worldstate, "global_genome_relations_modifier"))
			if (ModSettingGet("da_mod.world_chaos")) then
				GamePrint("The world descends into chaos!")
				ComponentSetValue(comp_worldstate, "global_genome_relations_modifier", "-1000")
			end
		end
	end
end