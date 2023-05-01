dofile_once("mods/da_mod/lib/lib.lua")

local perk = "EXPLODING_GOLD"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].func = function(entity_perk_item, entity_who_picked, item_name)
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{
			_tags = "perk_component",
			script_source_file = "mods/da_mod/files/scripts/perks/attract_items_enemy.lua",
			execute_every_n_frame = "2",
		} )
		GameAddFlagRun( "exploding_gold" )
	end
	perk_list[idx].func_remove = function(entity_who_picked)
		GameRemoveFlagRun( "exploding_gold" )
	end
end