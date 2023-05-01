-- Edit Perks
print("Editing Perks")

-- Perk Entries
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/attract_items.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/exploding_corpses.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/exploding_gold.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/glass_cannon.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/teleportitis.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/teleportitis_dodge.lua")
ModLuaFileAppend("data/scripts/perks/perk_list.lua", "mods/da_mod/files/scripts/init/perk_editor/vampirism.lua")

-- Perk Effects
ModLuaFileAppend("data/scripts/gun/gun_extra_modifiers.lua", "mods/da_mod/files/scripts/init/perk_editor/modifiers/lower_spread.lua")