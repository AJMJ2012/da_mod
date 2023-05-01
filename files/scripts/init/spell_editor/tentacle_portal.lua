dofile_once("mods/da_mod/lib/lib.lua")

local action = "TENTACLE_PORTAL"
local idx = GetTableIndex(actions, action)
if (idx ~= nil) then
	actions[idx].type = ACTION_TYPE_STATIC_PROJECTILE
end