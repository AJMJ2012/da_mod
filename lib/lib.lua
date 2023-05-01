dofile("data/scripts/lib/utilities.lua")

function GetTableIndex(table, id)
	for index, value in pairs(table) do
		if value.id == id then
			return index
		end
	end
	return nil
end
function GetArrayIndex(array, search)
	for index, value in pairs(array) do
		if value == search then
		return index
			end
	end
	return nil
end


dofile_once("data/scripts/gun/gun_actions.lua")
function AddSpell(action)
--	local idx = GetTableIndex(actions, action.id)
--	if idx ~= nil then
		table.insert(actions, action)
--		print("Added Spell " .. action.id)
--	else
--		print("Error: Spell " .. action.id .. " already exists")
--	end
end


dofile_once("data/scripts/perks/perk_list.lua")
function AddPerk(perk)
--	local idx = GetTableIndex(perk_list, perk.id)
--	if idx ~= nil then
		table.insert(perk_list, perk)
--		print("Added Perk " .. perk.id)
--	else
--		print("Error: Perk " .. perk.id .. " already exists")
--	end
end
function RemovePerk(perk)
	local idx = GetTableIndex(perk_list, perk)
	if (idx ~= nil) then
		perk_list[idx].not_in_default_perk_pool = true
--		print("Removed Perk: " .. perk .. " (" .. idx .. ")")
--	else
--		print("Error: Couldn't find perk " .. perk .. "")
	end
end


function RegisterLocalizations(translation_file)
    local loc_content = ModTextFileGetContent("data/translations/common.csv") -- Gets the original translations of the game
	local append_content = ModTextFileGetContent(translation_file) -- Gets my own translations file
	local i = 0
	lines = {}
	for s in append_content:gmatch("[^\r\n]+") do
		i = i + 1
		if(i ~= 1)then
			table.insert(lines, s)
		end
	end
	for k, v in pairs(lines)do
		if(k ~= 1)then
			loc_content = loc_content .. string.char(10) .. v
		else
			loc_content = loc_content .. v
		end
	end
	ModTextFileSetContent("data/translations/common.csv", loc_content)
end

-- Debug Stuff --

function dump(o, d)
	if type(o) == 'table' then
		 d = tonumber(d) or 0
		 local s = '{ ' .. "\n"
		 for k,v in pairs(o) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i=0,d,1 do s = s .. "    " end
			s = s .. '['..k..'] = ' .. dump(v, d+1) .. ',' .. "\n"
		 end
		 for i=1,d,1 do s = s .. "    " end
		 return s .. '}'
	else
		 return tostring(o)
	end
end