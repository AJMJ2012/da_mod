dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/perks/perk.lua")

function OnPlayerSpawned_StartPerk(player_entity)
	local flag = "qol_start_perk"
	if (GameHasFlagRun(flag) or GlobalsGetValue("NIGHTMARE_MOD_TRYING_TO_LOAD_PIXELS_SCENES_ONLY_ONCE") == "yes") then return end
	GameAddFlagRun(flag)
	if (ModSettingGet("da_mod.start_perk")) then
		local x = 585
		local y = -96
		perk_spawn_many(x, y)
	end
end