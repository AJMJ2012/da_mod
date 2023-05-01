dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/game_helpers.lua")
dofile_once("mods/da_mod/lib/lib.lua")

if (ModSettingGet("da_mod.combine_gold")) then
	local entity_id = GetUpdatedEntityID()
	local x, y = EntityGetTransform(entity_id)

	local remove_gold_timer = false
	local comp_worldstate = EntityGetFirstComponent(GameGetWorldStateEntity(), "WorldStateComponent")
	if (comp_worldstate ~= nil) then
		if (ComponentGetValue2(comp_worldstate, "perk_gold_is_forever")) then
			remove_gold_timer = true
		end
	end


	local gold_upgrade = {
		1,
		5,
		10,
		50,
		200,
		1000,
		10000,
		200000
	}

	local search_ranges = {
		4,
		8,
		12,
		18,
		24,
		40,
		30,
		60
	}

	local base_item_component = EntityGetFirstComponent(entity_id, "ItemComponent")
	local base_item_name = ComponentGetValue2(base_item_component,"item_name")
	local base_info_component = EntityGetFirstComponent(entity_id, "UIInfoComponent")
	local base_info_name = ComponentGetValue2(base_info_component,"name")
	local base_storage_component = EntityGetFirstComponent(entity_id, "VariableStorageComponent")
	local base_gold_value = ComponentGetValue2(base_storage_component,"value_int")

	local index = GetArrayIndex(gold_upgrade, base_gold_value) or 0
	local next_gold = gold_upgrade[index + 1]
	local next_to_combine = next_gold / base_gold_value

	-- Attract Gold Together
	local gold_to_attract = {}
	local attract_range = tonumber(GlobalsGetValue( "PERK_ATTRACT_ITEMS_RANGE", "0")) + ((search_ranges[index] or 10) * 4.0);
	local nearby_gold = EntityGetInRadiusWithTag(x, y, attract_range, "gold_nugget")
	if (#nearby_gold >= next_to_combine) then
		for _,gold in ipairs(nearby_gold) do
			local gx, gy = EntityGetTransform(gold)
			if (#gold_to_attract < next_to_combine and ((ModSettingGet("da_mod.attract_gold_los") and not RaytracePlatforms(x, y, gx, gy)) or not ModSettingGet("da_mod.attract_gold_los"))) then
				local storage_component = EntityGetFirstComponent(gold, "VariableStorageComponent")
				if (storage_component ~= nil and ComponentGetValue2(storage_component, "value_int") == base_gold_value) then
					local info_component = EntityGetFirstComponent(gold, "UIInfoComponent")
					if (info_component ~= nil and ComponentGetValue2(info_component, "name") == base_info_name) then
						table.insert(gold_to_attract, gold)
					end
				end
			end
		end
		if (#gold_to_attract >= next_to_combine) then
			for _,gold in ipairs(gold_to_attract) do
				local gx, gy = EntityGetTransform(gold)
				local physicscomponents = EntityGetComponent(gold, "PhysicsBodyComponent")
				if (physicscomponents ~= nil) then
					local direction = 0 - math.atan2((y - gy), (x - gx))
					local vel_x = math.cos(direction) * 2
					local vel_y = 0 - math.sin(direction) * 2
					PhysicsApplyForce(gold, vel_x, vel_y)
				end
			end
		end
	end

	-- Combine Gold
	local gold_to_combine = {}
	local combine_range = search_ranges[index];
	local close_gold = EntityGetInRadiusWithTag(x, y, combine_range, "gold_nugget")
	if (#close_gold >= next_to_combine) then
		for _,gold in ipairs(close_gold) do
			if (#gold_to_combine < next_to_combine) then
				local storage_component = EntityGetFirstComponent(gold, "VariableStorageComponent")
				if (storage_component ~= nil and ComponentGetValue2(storage_component, "value_int") == base_gold_value) then
					local info_component = EntityGetFirstComponent(gold, "UIInfoComponent")
					if (info_component ~= nil and ComponentGetValue2(info_component, "name") == base_info_name) then
						table.insert(gold_to_combine, gold)
					end
				end
			end
		end
		if (#gold_to_combine >= next_to_combine) then
			local mx = 0
			local my = 0
			for _,gold in ipairs(gold_to_combine) do
				local gx, gy = EntityGetTransform(gold)
				mx = mx + gx
				my = my + gy
				EntityKill(gold)
			end
			mx = mx / #gold_to_combine
			my = my / #gold_to_combine
			if (base_info_name == "$item_bloodmoney") then
				load_gold_entity("data/entities/items/pickup/bloodmoney_" .. next_gold .. ".xml", mx, my, remove_gold_timer)
			else
				load_gold_entity("data/entities/items/pickup/goldnugget_" .. next_gold .. ".xml", mx, my, remove_gold_timer)
			end
		end
	end
end