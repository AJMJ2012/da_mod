function floaty_text(entity_id, text, text_name, text_font, offset_y_add)
	if (offset_y_add == nil) then
		offset_y_add = 0
	end
	-- Create the text
	text_entity = EntityCreateNew("text_above_head")
	EntityAddTag(text_entity, text_name)
	text = tostring(text)
	local offset_x = #text * 2
	local offset_y = 6 + tonumber(offset_y_add)
	EntityAddComponent2(text_entity, "SpriteComponent",
	{
		image_file=text_font,
		is_text_sprite=true,
		offset_x=offset_x,
		offset_y=offset_y,
		text=text, 
		has_special_scale=true,
		special_scale_x=0.8,
		special_scale_y=0.8,
		alpha=2.0,
		emissive=true,
	})
	EntityAddComponent2(text_entity, "LuaComponent",
	{
		script_source_file="mods/da_mod/files/scripts/fonts/floaty_text.lua",
		execute_every_n_frame=1
	})
	local x, y = EntityGetTransform(entity_id)
	EntitySetTransform(text_entity, x, y)
end

function floaty_number(entity_id, value, text_name, text_font, offset_y_add)
	-- Text Effect
	-- Get existing text value and remove the entity
	value = tonumber(value)
	local x, y = EntityGetTransform(entity_id)
	local text_entity = EntityGetClosestWithTag(x, y, text_name)
	if (text_entity ~= nil and text_entity ~= 0) then
		local s = EntityGetComponent(text_entity, "SpriteComponent")
		if (s ~= nil) then
			for i,v in ipairs(s) do
				if (ComponentGetValue2(v, "alpha") >= 0.75) then
					value = value + ComponentGetValue2(v, "text")
				end
				break
			end
		end
		EntityKill(text_entity)
	end
	floaty_text(entity_id, value, text_name, text_font, offset_y_add)
end