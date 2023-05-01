dofile_once("mods/da_mod/lib/lib.lua")
local glass_mult = 0.2
local perk = "GLASS_CANNON"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].func = function( entity_perk_item, entity_who_picked, item_name )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance / 5
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
--[[
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) ) * glass_mult
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) ) * glass_mult
				
				ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
			end
		end
]]
	end
	perk_list[idx].func_enemy = function( entity_perk_item, entity_who_picked )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance / 5
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
--[[
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) ) * glass_mult
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) ) * glass_mult
				
				ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
			end
		end
]]
		EntityAddComponent( entity_who_picked, "LuaComponent", 
		{ 
			script_shot = "data/scripts/perks/glass_cannon_enemy.lua",
			execute_every_n_frame = "-1",
		} )
	end
	perk_list[idx].func_remove = function( entity_who_picked )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance * 5
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
--[[
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) ) / glass_mult
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) ) / glass_mult
				
				ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
			end
		end
]]
	end
end