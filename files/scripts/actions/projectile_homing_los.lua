dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)
local homing_component = EntityGetFirstComponent(entity_id, "HomingComponent")

if (homing_component ~= nil) then
	-- Add target_tag if it doesn't exist
	if (ComponentHasTag( homing_component, "target_tag" ) == false) then
		ComponentAddTag( homing_component, "target_tag" )
	end

	local closest_target = EntityGetClosestWithTag(x, y, "homing_target")
	-- Check LOS for closest target
	if (closest_target ~= nil) then
		local closest_x, closest_y = EntityGetTransform(closest_target)
		-- Make solid projectiles like rocks still be able to home in
		-- Bit of a hack but it works
		local angle = math.atan2(closest_y - y, closest_x - x)
		local vector_x = math.cos(angle)
		local vector_y = math.sin(angle)
		local start_x = x + vector_x * 8
		local start_y = y + vector_y * 8
		local end_x = closest_x - vector_x * 8
		local end_y = closest_y - vector_y * 8

		-- Set target_tag
		if (get_magnitude(x - closest_x, y - closest_y) <= 16 or RaytracePlatforms(start_x, start_y, end_x, end_y) == false) then
			ComponentSetValue2(homing_component, "target_tag", "homing_target")
		else
			ComponentSetValue2(homing_component, "target_tag", "-")
		end
	end
end
