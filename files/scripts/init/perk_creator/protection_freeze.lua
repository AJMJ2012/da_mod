dofile_once("mods/da_mod/lib/lib.lua")
dofile_once("mods/da_mod/lib/material_damage_changer.lua")

-- Freeze Protection
AddPerk({
	id = "PROTECTION_FREEZE",
	ui_name = "$perk_protection_freeze",
	ui_description = "$perkdesc_protection_freeze",
	ui_icon = "data/ui_gfx/perk_icons/protection_freeze.png",
	perk_icon = "data/items_gfx/perks/protection_freeze.png",
	game_effect = "PROTECTION_FREEZE",
	usable_by_enemies = true,
	func = function(perk_item, entity_who_picked, item_name)
		change_materials_that_damage(entity_who_picked, { blood_cold_vapour = 0 })
		change_materials_that_damage(entity_who_picked, { blood_cold = 0 })
	end,
	func_remove = function(perk_item, entity_who_picked, item_name)
		change_materials_that_damage(entity_who_picked, { blood_cold_vapour = 1 })
		change_materials_that_damage(entity_who_picked, { blood_cold = 1 })
	end,
})