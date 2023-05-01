dofile_once("mods/da_mod/lib/lib.lua")

local perk = "EXPLODING_CORPSES"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].remove_other_perks = nil
	perk_list[idx].game_effect2 = nil
	perk_list[idx].func = nil
	perk_list[idx].func_remove = nil
end