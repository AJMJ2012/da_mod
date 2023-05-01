dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/da_mod/files/scripts/perks/teleportitis_teleport.lua")

local teleport_range = 64
local time_cooldown = 30

function damage_received(damage, desc, entity_who_caused, is_fatal)
	local entity_id = GetUpdatedEntityID()

	-- don't teleport if there is no damage
	if (damage <= 0) then return end

	-- don't teleport if there is no entity causing damage
	if (entity_who_caused == nil or entity_who_caused == 0) then return end

	-- check that we're only teleporting half second
	if (script_wait_frames(entity_id, time_cooldown)) then return end

	-- set velocity to 0
	local velocitycomponents = EntityGetComponent( entity_id, "VelocityComponent" )
	if( velocitycomponents ~= nil ) then
		for i,velocitycomponent in ipairs(velocitycomponents) do
			ComponentSetValue(velocitycomponent, "mVelocity", 0, 0)
		end
	end

	-- teleport away
	TeleportitisDodge(entity_id, entity_who_caused, teleport_range, 16)
end
