dofile_once("data/scripts/lib/utilities.lua")
if (ModSettingGet("da_mod.enemies_attract_exploding_gold") and GameHasFlagRun( "exploding_gold" )) then
	local entity_id = GetUpdatedEntityID()
	local attract_items_count = 0
	for i,child in ipairs(EntityGetAllChildren( entity_id )) do
		for i,component in ipairs(EntityGetComponent( child, "UIIconComponent" )) do
			if (ComponentGetValue2(component, "name") == "$perk_attract_items") then
				attract_items_count = attract_items_count + 1
			end
		end
	end
	if (attract_items_count > 0) then
		local pos_x, pos_y = EntityGetTransform( entity_id )
		local distance_full = tonumber( GlobalsGetValue( "PERK_ATTRACT_ITEMS_RANGE", "72" ) ) / 2
		local enemies = EntityGetInRadiusWithTag(pos_x, pos_y, 260 * 2, "enemy")
		if ( distance_full > 0 and #enemies > 0 ) then
			for i, enemy in ipairs(enemies) do
				local x, y = EntityGetTransform( enemy )
				local items = EntityGetWithTag( "gold_nugget" )
				local power = math.min( distance_full / 8, 20 )
				if ( #items > 0 ) then
					for i,item_id in ipairs(items) do	
						local px, py = EntityGetTransform( item_id )
						
						local distance = math.abs( x - px ) + math.abs( y - py )
						
						if ( distance < distance_full * 1.25 and ( ( ModSettingGet("da_mod.attract_gold_los") and not RaytracePlatforms(x, y, px, py) ) or not ModSettingGet("da_mod.attract_gold_los") ) ) then
							distance = math.sqrt( ( x - px ) ^ 2 + ( y - py ) ^ 2 )
							direction = 0 - math.atan2( ( y - py ), ( x - px ) )
					
							if ( distance < distance_full ) then
								local physicscomponents = EntityGetComponent( item_id, "PhysicsBodyComponent" )
								
								if ( physicscomponents ~= nil ) then
									local vel_x = math.cos( direction ) * power
									local vel_y = 0 - math.sin( direction ) * power
									
									PhysicsApplyForce( item_id, vel_x, vel_y )
								end
							end
						end
					end
				end
			end
		end
	end
end