dofile_once("mods/da_mod/lib/lib.lua")

local action = "ADD_TIMER"
local idx = GetTableIndex(actions, action)
if (idx ~= nil) then
	actions[idx].type = ACTION_TYPE_MODIFIER --ACTION_TYPE_UTILITY
	actions[idx].spawn_level = "1,2,3,4,5,6,7,8,9,10"
	actions[idx].spawn_probability = "0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25,0.25"
end