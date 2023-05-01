dofile_once("mods/da_mod/lib/lib.lua")

local perk = "ATTRACT_ITEMS"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].usable_by_enemies = false
end