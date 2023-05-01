dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/scripts/gun/procedural/gun_procedural_better.lua"
-- Add Utility Spells
script.prepend([[if( card_count > 1 and Random( 0, 100 ) < 1 ) then
	card = GetRandomActionWithType( x, y, level, ACTION_TYPE_UTILITY, 2 )
	AddGunAction( entity_id, card )
	card_count = card_count - 1
end]], [[if( card_count > 1 and Random( 0, 100 ) < 20 ) then
	card = GetRandomActionWithType( x, y, level, ACTION_TYPE_MODIFIER, 2 )
	AddGunAction( entity_id, card )
	card_count = card_count - 1
end]], file)
script.prepend([[if( card_count > 1 and Random( 0, 100 ) < 4 ) then
	card = GetRandomActionWithType( x, y, level, ACTION_TYPE_UTILITY, 2 )
	AddGunAction( entity_id, card )
	card_count = card_count - 1
end]], [[-- DRAW_MANY + MOD]], file)

-- Move Modifiers above Draw Many
script.replace([[]], [[if( Random( 0, 100 ) < 80 ) then
	card = GetRandomActionWithType( x, y, level, ACTION_TYPE_MODIFIER, 2 )
	AddGunAction( entity_id, card )
	card_count = card_count - 1
end]], file)

script.prepend([[if( Random( 0, 100 ) < 80 ) then
	card = GetRandomActionWithType( x, y, level, ACTION_TYPE_MODIFIER, 2 )
	AddGunAction( entity_id, card )
	card_count = card_count - 1
end]], [[-- DRAW_MANY + MOD]], file)