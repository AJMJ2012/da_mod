dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/da_mod/files/scripts/perks/teleportitis_teleport.lua")

local sensor_range = 16
local teleport_range = 64
local time_cooldown = 120

local entity_id = GetUpdatedEntityID()
local root_id = EntityGetRootEntity(entity_id)
local x, y = EntityGetTransform(entity_id)

-- toggles vfx and sets script exec time
local function set_cooldown(on_cooldown, frames)
	EntitySetComponentsWithTagEnabled(entity_id, "teleportitis_dodge_vfx", not on_cooldown)
	component_write(GetUpdatedComponentID(), {
		execute_every_n_frame = frames,
		mNextExecutionTime = GameGetFrameNum() + frames,
	})
end

-- look for enemy projectiles
for _,proj_id in ipairs(EntityGetInRadiusWithTag(x, y, sensor_range, "projectile")) do
	local comp_proj = EntityGetFirstComponent(proj_id, "ProjectileComponent")
	if comp_proj ~= nil then
		local shooter_id = tonumber(ComponentGetValue(comp_proj, "mWhoShot"))
		if --[[shooter_id ~= 0 and]] shooter_id ~= root_id then
			local damage = ComponentGetValue2(comp_proj, "damage") +
				ComponentObjectGetValue(comp_proj, "config_explosion", "damage") +
				ComponentObjectGetValue(comp_proj, "damage_by_type", "melee") +
				ComponentObjectGetValue(comp_proj, "damage_by_type", "fire") + 
				ComponentObjectGetValue(comp_proj, "damage_by_type", "electricity") + 
				ComponentObjectGetValue(comp_proj, "damage_by_type", "radioactive") + 
				ComponentObjectGetValue(comp_proj, "damage_by_type", "slice") + 
				ComponentObjectGetValue(comp_proj, "damage_by_type", "drill") + 
				ComponentObjectGetValue(comp_proj, "damage_by_type", "ice")

			-- don't teleport if there is no damage
			if damage <= 0 then return end

			-- set velocity to 0
			local velocitycomponents = EntityGetComponent( entity_id, "VelocityComponent" )
			if( velocitycomponents ~= nil ) then
				for i,velocitycomponent in ipairs(velocitycomponents) do
					ComponentSetValue(velocitycomponent, "mVelocity", 0, 0)
				end
			end

			-- teleport away
			TeleportitisDodge(entity_id, shooter_id or comp_proj, teleport_range, 16)

			-- cooldown on
			set_cooldown(true, time_cooldown)
			return
		end
	end
end

-- cooldown off
set_cooldown(false, 1)
