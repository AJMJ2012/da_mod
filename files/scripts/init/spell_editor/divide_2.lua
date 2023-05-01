dofile_once("mods/da_mod/lib/lib.lua")

local action = "DIVIDE_2"
local idx = GetTableIndex(actions, action)
if (idx ~= nil) then
	actions[idx].type = ACTION_TYPE_UTILITY
end