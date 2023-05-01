local nxml = dofile_once("mods/da_mod/lib/nxml.lua")

-- Gold combines into larger ones --

local file = "data/entities/items/pickup/goldnugget.xml"
local data = nxml.parse(ModTextFileGetContent(file))
data:add_child(nxml.parse([[
	<LuaComponent
		script_source_file="mods/da_mod/files/scripts/items/gold_combine.lua"
		execute_on_added="0"
		execute_every_n_frame="2"
		>
	</LuaComponent>
]]))
ModTextFileSetContent(file, tostring(data))

for _,type in ipairs({"goldnugget","bloodmoney"}) do
	for _,amount in ipairs({1,5,10,50,200,1000,10000,200000}) do
				local file = "data/entities/items/pickup/" .. type .. "_" .. amount .. ".xml"
		local data = nxml.parse(ModTextFileGetContent(file))
		data:add_child(nxml.parse([[
			<LuaComponent
				script_source_file="mods/da_mod/files/scripts/items/gold_combine.lua"
				execute_on_added="0"
				execute_every_n_frame="2"
				>
			</LuaComponent>
		]]))
		ModTextFileSetContent(file, tostring(data))
	end
end