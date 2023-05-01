dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/da_mod/files/scripts/perks/teleportitis_teleport.lua")

local teleport_range = 8
local time_cooldown = 120

function damage_received(damage, desc, entity_who_caused, is_fatal)
	if (desc == "melee" or desc == "hit" or desc == "drill" or desc == "$damage_melee" or desc == "$damage_hit" or desc == "$damage_drill") then
		local entity_id = GetUpdatedEntityID()
	
		-- don't teleport if there is no entity causing damage
		if (entity_who_caused == nil) then return end

		-- check that we're only teleporting half second
		if (script_wait_frames(entity_id, time_cooldown)) then return end

		-- refund health taken
		-- todo: make melee actually deal no damage while this is active
		if (damage > 0) then
			local damagemodels = EntityGetComponent( entity_id, "DamageModelComponent" )
			if( damagemodels ~= nil ) then
				for i,damagemodel in ipairs(damagemodels) do
					ComponentSetValue(damagemodel, "hp", ComponentGetValue2(damagemodel, "hp") + damage)
				end
			end
		end

		-- set velocity to 0
		local velocitycomponents = EntityGetComponent( entity_id, "VelocityComponent" )
		if( velocitycomponents ~= nil ) then
			for i,velocitycomponent in ipairs(velocitycomponents) do
				ComponentSetValue(velocitycomponent, "mVelocity", 0, 0)
			end
		end

		-- teleport behind
		TeleportitisBehind(entity_id, entity_who_caused, teleport_range)
	end
end
