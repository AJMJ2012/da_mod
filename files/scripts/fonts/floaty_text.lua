dofile_once("data/scripts/lib/utilities.lua")
local entity_id = GetUpdatedEntityID()
local alpha = 0.0
edit_component(entity_id, "SpriteComponent", function(comp,vars)
	alpha = ComponentGetValue2(comp, "alpha")
	ComponentSetValue2(comp, "alpha", alpha - 1.0 / (60.0 / 3.0))
	offset_y = ComponentGetValue2(comp, "offset_y")
	ComponentSetValue2(comp, "offset_y", offset_y + 0.75)
end)
if (alpha <= 0.0) then
	EntityKill(entity_id)
end