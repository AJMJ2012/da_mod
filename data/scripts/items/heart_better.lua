dofile( "data/scripts/game_helpers.lua" )

function item_pickup( entity_item, entity_who_picked, name )
	local glass_cannon_count = 0
	local vampirism_count = 0
--[[
	local children = EntityGetAllChildren( entity_who_picked )
	if( children ~= nil ) then
		for i,child in ipairs(children) do
			local components = EntityGetComponent( child, "UIIconComponent" )
			if ( components ~= nil ) then
				for i,component in ipairs(components) do
					if (ComponentGetValue2(component, "name") == "$perk_glass_cannon") then
						glass_cannon_count = glass_cannon_count + 1
					end
					if (ComponentGetValue2(component, "name") == "$perk_vampirism") then
						vampirism_count = vampirism_count + 1
					end
				end
			end
		end
	end
]]
	local max_hp = 0
	local max_hp_old = 0
	local hp = 0
	local hp_old = 0
	local multiplier = tonumber( GlobalsGetValue( "HEARTS_MORE_EXTRA_HP_MULTIPLIER", "1" ) )-- / math.max(1, glass_cannon_count / 0.2) / math.max(1, vampirism_count / 0.75)

	local x, y = EntityGetTransform( entity_item )

	local damagemodels = EntityGetComponent( entity_who_picked, "DamageModelComponent" )
	if( damagemodels ~= nil ) then
		for i,damagemodel in ipairs(damagemodels) do
			max_hp = tonumber( ComponentGetValue( damagemodel, "max_hp" ) )
			max_hp_old = max_hp
			max_hp = max_hp + 2 * multiplier

			local max_hp_cap = tonumber( ComponentGetValue( damagemodel, "max_hp_cap" ) )
			if max_hp_cap > 0 then
				max_hp_cap = math.max( max_hp, max_hp_cap )
			end

			ComponentSetValue( damagemodel, "max_hp_cap", max_hp_cap )
			ComponentSetValue( damagemodel, "max_hp_old", max_hp_old )
			ComponentSetValue( damagemodel, "max_hp", max_hp )
			ComponentSetValue( damagemodel, "mLastMaxHpChangeFrame", GameGetFrameNum() )

			hp = tonumber( ComponentGetValue( damagemodel, "hp" ) )
			hp_old = hp
			hp = hp + 2 * multiplier
			ComponentSetValue(damagemodel, "hp", hp)
		end
	end

	EntityLoad("data/entities/particles/image_emitters/heart_effect.xml", x, y-12)
	EntityLoad("data/entities/particles/heart_out.xml", x, y-8)
	local description = GameTextGet( "$logdesc_heart", tostring(math.floor((max_hp - max_hp_old) * 25)), tostring(math.floor(hp * 25)) )
	if max_hp == max_hp_old then
		description =  GameTextGet( "$logdesc_heart_blocked", tostring(math.floor(hp * 25) - math.floor(hp_old * 25)))
	end
	GamePrintImportant( "$log_heart", description )
	GameTriggerMusicCue( "item" )

	-- remove the item from the game
	EntityKill( entity_item )
end
