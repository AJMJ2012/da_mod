print("========== Loading Dark Assassin's Mod ==========")
dofile("mods/da_mod/files/scripts/init/translations.lua")
dofile("mods/da_mod/files/scripts/init/magic_numbers.lua")
dofile("mods/da_mod/files/scripts/init/materials.lua")
dofile("mods/da_mod/files/scripts/init/scripts.lua")
dofile("mods/da_mod/files/scripts/init/spell_creator.lua")
dofile("mods/da_mod/files/scripts/init/perk_creator.lua")
dofile("mods/da_mod/files/scripts/init/spell_editor.lua")
dofile("mods/da_mod/files/scripts/init/perk_editor.lua")
dofile("mods/da_mod/files/scripts/init/script_editor.lua")
dofile("mods/da_mod/files/scripts/init/xml_editor.lua")
print("=================================================")

-- Urgh, can't have multiple of this function.
-- I should create a list.
dofile_once("data/scripts/lib/utilities.lua")
function OnPlayerSpawned(player_entity)
	OnPlayerSpawned_NoTempleInventoryAutoOpen(player_entity)
	OnPlayerSpawned_StartPerk(player_entity)
	OnPlayerSpawned_WorldChaos(player_entity)
end

function OnPlayerDied(player_entity)
	OnPlayerDied_WorldChaos(player_entity)
end