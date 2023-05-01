dofile("mods/da_mod/lib/script_utilities.lua")
local file = "data/entities/player_base.xml"
-- Decrease Flight Time
script.replace([[fly_time_max="2.4"]], [[fly_time_max="3.0"]], file)
-- Increase Flight and Run Speed
script.replace([[fly_speed_max_up="118.75"]], [[fly_speed_max_up="95"]], file)
script.replace([[run_velocity="192.5"]], [[run_velocity="154"]], file)
script.replace([[fly_velocity_x="65"]], [[fly_velocity_x="52"]], file)
script.replace([[velocity_min_x="-71.25"]], [[velocity_min_x="-57"]], file)
script.replace([[velocity_max_x="71.25"]], [[velocity_max_x="57"]], file)
script.replace([[velocity_min_y="-250"]], [[velocity_min_y="-200"]], file)
-- Increase Vampire Healing
script.replace([[blood_healing_speed="0.0032"]], [[blood_healing_speed="0.0016"]], file)