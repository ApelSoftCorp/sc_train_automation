local conf = {
	["name"] = "Solas - Residential",
	["arrival"] = {
		["arrival_01"] = {
			["AC"] = "f8d4",
			["AD"] = "9436",
			["brake"] = 0.10,
			["switch"] = "switch_A",
			["railway"] = {
				"platform_01",
				"highway_02",
			},
		},
	},
	["platform"] = {
		["platform_01"] = {
			["AC"] = {
				["end"] = "d6af",
				["deadend"] = "6dfe",
			},
			["AD"] = {
				["end"] = "df0c",
			},
			["available"] = true,
			-- ["depart_time"] = 360,
			["depart_time"] = 10,
			["throttle"] = 0.50,
		},
	},
	["highway"] = {
		["highway_02"] = {
			["AC"] = "a5d0",
			["AD"] = "6a5d",
			["available"] = true,
		},
	},
	["switch"] = {
		["switch_A"] = {
			["railway"] = {
				["platform_01"] = 1,
				["highway_02"] = 0,
			},
			["periph"] = "6624",
			["side"] = 1,
			["state"] = "platform_01",
		},
	},
}

return conf
