dofile_once("mods/da_mod/lib/lib.lua")
local nxml = dofile_once("mods/da_mod/lib/nxml.lua")

-- Rename gold to remove the amount --

local file = "data/entities/items/pickup/goldnugget.xml"
local data = nxml.parse(ModTextFileGetContent(file))
for i,d in ipairs(data["children"]) do
	if (d["name"] == "ItemComponent") then
		data["children"][i]["attr"]["item_name"] = "$item_goldnugget"
	end
end
ModTextFileSetContent(file, tostring(data))

for _,amount in ipairs({1,5,10,50,200,1000,10000,200000}) do
		local file = "data/entities/items/pickup/goldnugget_" .. amount .. ".xml"
	local data = nxml.parse(ModTextFileGetContent(file))
	for i,d in ipairs(data["children"]) do
		if (d["name"] == "ItemComponent") then
			data["children"][i]["attr"]["item_name"] = "$item_goldnugget"
		end
	end
	ModTextFileSetContent(file, tostring(data))
end

for _,amount in ipairs({1,5,10,50,200,1000,10000,200000}) do
		local file = "data/entities/items/pickup/bloodmoney_" .. amount .. ".xml"
	local data = nxml.parse(ModTextFileGetContent(file))
	for i,d in ipairs(data["children"]) do
		if (d["name"] == "ItemComponent") then
			data["children"][i]["attr"]["item_name"] = "$item_bloodmoney"
		end
	end
	ModTextFileSetContent(file, tostring(data))
end