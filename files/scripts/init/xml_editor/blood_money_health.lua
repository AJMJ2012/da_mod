dofile_once("mods/da_mod/lib/lib.lua")
local nxml = dofile_once("mods/da_mod/lib/nxml.lua")

-- Redo Blood Money Health --

for _,amount in ipairs({1,5,10,50,200,1000,10000,200000}) do
	local heal = math.sqrt(math.sqrt(amount)) / 10
	local file = "data/entities/items/pickup/bloodmoney_" .. amount .. ".xml"
	local data = nxml.parse(ModTextFileGetContent(file))
	for i,d in ipairs(data["children"]) do
		if (d["name"] == "VariableStorageComponent" and data["children"][i]["attr"]["name"] == "hp_value") then
			data["children"][i]["attr"]["value_float"] = heal
		end
	end
	ModTextFileSetContent(file, tostring(data))
end