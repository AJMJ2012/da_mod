function OnPlayerSpawned_NoTempleInventoryAutoOpen(player_entity)
	local workshops = EntityGetWithTag("workshop_untouched");
	for _,workshop in pairs(workshops or {}) do
		EntityRemoveTag(workshop, "workshop_untouched");
	end
end