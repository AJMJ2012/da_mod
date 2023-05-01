dofile_once("mods/da_mod/lib/lib.lua")
dofile_once("mods/da_mod/lib/material_damage_changer.lua")

-- Teleportitis Assassin
AddPerk({
	id = "TELEPORTITIS_NEW",
	ui_name = "$perk_teleportitis_new",
	ui_description = "$perkdesc_teleportitis_new",
	ui_icon = "mods/da_mod/files/ui_gfx/perk_icons/teleportitis_new.png",
	perk_icon = "mods/da_mod/files/items_gfx/perks/teleportitis_new.png",
	stackable = STACKABLE_NO,
	usable_by_enemies = true,
	func = function(entity_perk_item, entity_who_picked, item_name)
		EntityAddComponent(entity_who_picked, "LuaComponent", {
			_tags = "perk_component",
			script_damage_received = "mods/da_mod/files/scripts/perks/teleportitis_new.lua",
			execute_every_n_frame = "-1",
		})
		-- Need to manually add the damage resistance since the original game effect isn't used anymore
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "drill", "melee" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance * 0.8
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
	end,
	func_remove = function(entity_who_picked)		
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "drill", "melee" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance * 1.25
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
	end,
	func_enemy = function(entity_perk_item, entity_who_picked, item_name)
		EntityAddComponent(entity_who_picked, "LuaComponent", {
			_tags = "perk_component",
			script_damage_received = "mods/da_mod/files/scripts/perks/teleportitis_new.lua",
			execute_every_n_frame = "-1",
		})
		-- Need to manually add the damage resistance since the original game effect isn't used anymore
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "drill", "melee" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance * 0.8
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
	end,
})


