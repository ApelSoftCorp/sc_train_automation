local conf = {
	["name"] = "Solas - Main Station",
	["arrival"] = {
		["arrival_01"] = {
			["AC"] = "2a7f",
			["AD"] = "d795",
			["brake"] = 0.30,
			["switch"] = {
				"switch_A",
			},
			["default_railway"] = "platform_01",
			["railway"] = {
				"platform_01",
				"highway_02",
			},
		},
	},
	["platform"] = {
		["platform_01"] = {
			["AC"] = {
				["end"] = "1c4e",
				["deadend"] = "c2fd",
			},
			["AD"] = {
				["end"] = "a19c",
			},
			["available"] = true,
			-- ["depart_time"] = 360,
			["depart_time"] = 10,
			["throttle"] = 0.50,
		},
	},
	["highway"] = {
		["highway_02"] = {
			["AC"] = "4cf6",
			["AD"] = "8c3a",
			["available"] = true,
		},
	},
	["switch"] = {
		["switch_A"] = {
			["railway"] = {
				["platform_01"] = 0,
				["highway_02"] = 1,
			},
			["periph"] = "9451",
			["side"] = 1,
			["state"] = "platform_01",
		},
	},
}

return conf
