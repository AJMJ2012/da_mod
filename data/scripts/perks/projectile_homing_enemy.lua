dofile_once("data/scripts/lib/utilities.lua")

function shot( entity_id )
	if( EntityGetComponent( entity_id, "ProjectileComponent" ) ~= nil and EntityGetComponent( entity_id, "HomingComponent" ) ~= nil ) then
		EntityAddComponent( entity_id, "HomingComponent", 
		{ 
			homing_targeting_coeff = "130.0",
			homing_velocity_multiplier = "0.86",
		} )
		EntityAddComponent( entity_id, "LuaComponent", 
		{ 
			script_source_file = "mods/da_mod/files/scripts/actions/projectile_homing_los.lua",
			execute_on_added = "1",
			execute_every_n_frame = "2",
		} )
	end
end