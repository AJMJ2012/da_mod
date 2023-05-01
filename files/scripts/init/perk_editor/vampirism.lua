dofile_once("mods/da_mod/lib/lib.lua")
-- Not really needed but just in case --
local vamp_mult = 0.75
local perk = "VAMPIRISM"
local idx = GetTableIndex(perk_list, perk)
if (idx ~= nil) then
	perk_list[idx].func = function( entity_perk_item, entity_who_picked, item_name )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance / (4/3)
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
--[[
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) ) * vamp_mult
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) ) * vamp_mult
				
				ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
			end
		end
]]
		add_halo_level(entity_who_picked, -1)
	end
	perk_list[idx].func_remove = function( entity_who_picked )
		local damagemodels = EntityGetComponent(entity_who_picked, "DamageModelComponent")
		if (damagemodels ~= nil) then
			local resists = { "melee", "projectile", "explosion", "electricity", "fire", "drill", "slice", "ice", "physics_hit", "radioactive", "poison" }
			for i,damagemodel in ipairs(damagemodels) do
				for j,type in ipairs(resists) do
					local resistance = tonumber(ComponentObjectGetValue(damagemodel, "damage_multipliers", type))
					resistance = resistance * (4/3)
					ComponentObjectSetValue(damagemodel, "damage_multipliers", type, tostring(resistance))
				end
			end
		end
--[[
		local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
		if( damagemodels ~= nil ) then
			for i,damagemodel in ipairs(damagemodels) do
				local hp = tonumber( ComponentGetValue( damagemodel, "hp" ) ) / vamp_mult
				local max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) ) / vamp_mult
				
				ComponentSetValue( damagemodel, "hp", math.min( hp, max_hp ) )
				ComponentSetValue( damagemodel, "max_hp", max_hp )
				ComponentSetValue( damagemodel, "max_hp_cap", max_hp )
			end
		end
]]
		add_halo_level(entity_who_picked, 1)
	end
end