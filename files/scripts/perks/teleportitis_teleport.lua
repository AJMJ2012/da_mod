dofile_once("data/scripts/lib/utilities.lua")

-- TODO: Debug teleporting upward going into the terrain.

local function teleport(entity_id, from_x, from_y, to_x, to_y)
	local root_id = EntityGetRootEntity(entity_id)
	EntitySetTransform(root_id, to_x, to_y)
	EntityLoad("data/entities/particles/teleportation_source.xml", from_x, from_y)
	EntityLoad("data/entities/particles/teleportation_target.xml", to_x, to_y)
	GamePlaySound("data/audio/Desktop/misc.bank", "misc/teleport_use", to_x, to_y)

	-- punch a hole to make sure player doesn't get stuck
	LoadPixelScene("data/biome_impl/teleportitis_dodge_hole.png", "", to_x-3, to_y-12, "", true)
end

function TeleportitisDodge(entity_id, entity_who_caused, teleport_range, search_nums)
	if (search_nums == nil) or (search_nums < 1) then
		search_nums = 1
	end

	local x, y = EntityGetTransform(entity_id)
	local hitboxcomponent = EntityGetFirstComponent(entity_id, "HitboxComponent")
	local hitbox_left = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_min_x") or -1)
	local hitbox_right = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_max_x") or 1)
	local hitbox_top = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_min_y") or -1)
	local hitbox_bottom = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_max_y") or 1)
	local hitbox_horizontal = math.max(hitbox_left, hitbox_right)
	local hitbox_vertical = math.max(hitbox_top, hitbox_bottom)

	local ent_x, ent_y = EntityGetTransform(entity_who_caused)
	SetRandomSeed(GameGetFrameNum(), x + y + entity_id)
	local positions = {}
	-- Right in front the attacking vector is skipped to prevent teleporting into a projectile's path.
	local step = 2 / (search_nums + 1)
	local angle_base = math.rad(Random(1, 360))
	for i=1, search_nums do

		local angle = angle_base
		if (ent_x ~= nil and ent_y ~= nil) then
			angle = math.atan2(ent_y - y, ent_x - x)
		else
			ent_x = x
			ent_y = y
		end
		angle = 0 - angle - (math.pi * (i * step)) + math.rad(Random(-2, 2))

		-- get the vectors of the angles
		local vector_x = math.cos(angle)
		local vector_y = math.sin(angle)
		
		-- set the teleport destination
		local to_x = x + vector_x * teleport_range
		local to_y = y + vector_y * teleport_range

		-- check if the teleport will collide with any solids
		local collide
		collide, to_x, to_y = RaytracePlatforms(x, y, to_x, to_y)

		-- offset away from the solids if they would be collided with
		if (collide == true) then
			to_x = to_x - vector_x * hitbox_horizontal * 1.5
			to_y = to_y - vector_y * hitbox_vertical * 1.5
		end

		positions[i] = {
			distance = math.min(get_magnitude(x - to_x, y - to_y), get_magnitude(ent_x - to_x, ent_y - to_y)), -- Distance from the player or the inflitor
			x = to_x,
			y = to_y
		}
	end

	local idx = math.floor((search_nums / 2) + 0.5)
	local max = math.abs(positions[idx].distance)
	for i=1, search_nums do
		local dist = math.abs(positions[i].distance)
		if (dist > max) then
			max = dist
			idx = i
		end
	end

	teleport(entity_id, x, y, positions[idx].x, positions[idx].y)
end

function TeleportitisBehind(entity_id, entity_who_caused, teleport_range)
	if (entity_who_caused ~= nil) then
		local x, y = EntityGetTransform(entity_id)
		local hitboxcomponent = EntityGetFirstComponent(entity_id, "HitboxComponent")
		local hitbox_left = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_min_x") or -1)
		local hitbox_right = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_max_x") or 1)
		local hitbox_top = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_min_y") or -1)
		local hitbox_bottom = math.abs(ComponentGetValue2(hitboxcomponent, "aabb_max_y") or 1)
		local hitbox_horizontal = math.max(hitbox_left, hitbox_right)
		local hitbox_vertical = math.max(hitbox_top, hitbox_bottom)

		local ent_x, ent_y = EntityGetTransform(entity_who_caused)
		local ent_hitboxcomponent = EntityGetFirstComponent(entity_who_caused, "HitboxComponent")
		local ent_hitbox_left = math.abs(ComponentGetValue2(ent_hitboxcomponent, "aabb_min_x") or -1)
		local ent_hitbox_right = math.abs(ComponentGetValue2(ent_hitboxcomponent, "aabb_max_x") or 1)
		local ent_hitbox_top = math.abs(ComponentGetValue2(ent_hitboxcomponent, "aabb_min_y") or -1)
		local ent_hitbox_bottom = math.abs(ComponentGetValue2(ent_hitboxcomponent, "aabb_max_y") or 1)
		local ent_hitbox_horizontal = math.max(ent_hitbox_left, ent_hitbox_right)
		local ent_hitbox_vertical = math.max(ent_hitbox_top, ent_hitbox_bottom)

		-- get the angle between the entity and the player
		local angle = math.atan2(ent_y - y, ent_x - x)

		-- get the vectors of the angles
		local vector_x = math.cos(angle)
		local vector_y = math.sin(angle)
		
		-- set the teleport source
		local from_x = ent_x
		local from_y = y
		
		-- set the teleport destination
		local to_x = from_x + vector_x * ent_hitbox_horizontal * teleport_range
		local to_y = from_y + vector_y * teleport_range

		-- check if the teleport will collide with any solids
		local collide
		collide, to_x, to_y = RaytracePlatforms(from_x, from_y, to_x, to_y)

		-- offset away from the solids if they would be collided with
		if (collide == true) then
			to_x = to_x - vector_x * hitbox_horizontal * 1.5
			to_y = to_y - vector_y * hitbox_vertical * 1.5
		end

		teleport(entity_id, x, y, to_x, to_y)
	end
end