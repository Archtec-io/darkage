-- Based on https://raw.githubusercontent.com/blert2112/darkage/reg_ore-FIX/mapgen.lua

local seed = minetest.get_mapgen_setting("seed")

-- Generate desert stone with iron in derset.
minetest.register_ore({
	ore_type = "scatter",
	ore = "darkage:desert_stone_with_iron",
	wherein = "default:desert_stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 3,
	clust_size = 2,
	y_min = -1,
	y_max = 200,
})

-- Generate chalk inside mountains
minetest.register_ore({
	ore_type = "sheet",
	ore = "darkage:chalk",
	wherein = {"default:stone"},
	column_height_max = 30,
	column_height_min = 20,
	y_min = -20,
	y_max = 50,
	noise_threshold = 0.45,
	noise_params = {
		offset = 0.35,
		scale = 0.2,
		spread = {x = 30, y = 30, z = 30},
		octaves = 1,
		persistence = 0.6,
	},
})

minetest.register_ore({
	ore_type = "sheet",
	ore = "darkage:tuff",
	wherein = {"default:stone", "default:dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 20,
	column_height_min = 15,
	y_min = -200,
	y_max = 200,
	noise_threshold = 0.5,
	noise_params = {
		offset = 0.35,
		scale = 0.19,
		seed = seed + 12,
		spread = {x = 45, y = 45, z = 45},
		octaves = 1,
		persistence = 0.6,
	},
})

minetest.register_ore({
	ore_type = "sheet",
	ore = "darkage:rhyolitic_tuff",
	wherein = {"default:stone", "default:dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 20,
	column_height_min = 15,
	y_min = -2000,
	y_max = 200,
	noise_threshold = 0.53,
	noise_params = {
		offset = 0.35,
		scale = 0.2,
		seed = seed + 13,
		spread = {x = 100, y = 100, z = 100},
		octaves = 1,
		persistence = 0.6,
	},
})

--old red sandstone
minetest.register_ore({
	ore_type = "sheet",
	ore = "darkage:ors",
	wherein = {"default:stone", "default:dirt", "default:gravel", "default:stone_with_coal"},
	column_height_max = 8,
	column_height_min = 6,
	y_min = -200,
	y_max = 500,
	noise_threshold = 0.49,
	noise_params = {
		offset = 0.28,
		scale = 0.3,
		seed = seed + 4,
		spread = {x = 10, y = 10, z = 10},
		octaves = 1,
		persistence = 0.6,
	},
})

local claylike = {
	{name = "mud", wherein = "sand", min_y = -1, max_y = 1},
	{name = "silt", wherein = "sand", min_y = -1, max_y = 1},
}

local ores = {
	{name = "shale", wherein = "stone", thickness = 4, min_y = -50, max_y = 20, threshold = 1.50},
	{name = "slate", wherein = "stone", thickness = 3, min_y = -500, max_y = 0, threshold = 1.50},
	{name = "schist", wherein = "stone", thickness = 3, min_y = -31000, max_y = -10, threshold = 1.75},
	{name = "basalt", wherein = "stone", thickness = 4, min_y = -31000, max_y = -50, threshold = 0.75},
	{name = "marble", wherein = "stone", thickness = 5, min_y = -31000, max_y = -75, threshold = 2.00},
	{name = "serpentine", wherein = "stone", thickness = 6, min_y = -31000, max_y = -300, threshold = 2.50},
	{name = "gneiss", wherein = "stone", thickness = 3, min_y = -31000, max_y = -250, threshold = 1.75},
}

local claylike_count

for i, data in ipairs(claylike) do
	minetest.register_ore({
		ore_type = "sheet",
		ore = "darkage:" .. data.name,
		wherein = "default:" .. data.wherein,
		column_height_min = 1,
		column_height_max = 2,
		column_midpoint_factor = 0.5,
		y_min = data.min_y,
		y_max = data.max_y,
		noise_threshold = 0.50,
		spawn_by = "default:water",
		noise_params = {
			offset = 0,
			scale = 1,
			spread = {x = 15, y = 15, z = 15},
			seed = seed + 2112 + i,
			octaves = 2,
			persist = 0.8,
		},
	})
	claylike_count = i
end

for i, data in ipairs(ores) do
	if data.thickness - 2 < 1 then
		data.thickness = 3
	end
	minetest.register_ore({
		ore_type = "sheet",
		ore = "darkage:" .. data.name,
		wherein = "default:" .. data.wherein,
		column_height_min = data.thickness - 2,
		column_height_max = data.thickness,
		column_midpoint_factor = 0.5,
		y_min = data.min_y,
		y_max = data.max_y,
		noise_threshold = data.threshold,
		noise_params = {
			offset = 0,
			scale = 2,
			spread = {x = 20, y = 20, z = 10},
			seed = seed + claylike_count + 2112 + i,
			octaves = 2,
			persist = 0.8,
		},
	})
end