dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local homing_component = EntityGetFirstComponent(entity_id, "HomingComponent")

if (homing_component ~= nil) then
	-- Balance
	if (string.find(EntityGetTags(entity_id), "homing_further") == nil) then
		ComponentSetValue2(homing_component, "detect_distance", (ComponentGetValue2(homing_component, "detect_distance") or 150) * 1.5)
	end
	EntityAddTag(entity_id, "homing_further")
end
