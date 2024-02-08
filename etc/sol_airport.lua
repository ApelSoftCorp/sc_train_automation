local conf = {
	["name"] = "Solas - Airport",
	["arrival"] = {
		["arrival_01"] = {
			["AC"] = "76cb",
			["AD"] = "56ff",
			["brake"] = 0.18,
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
				["end"] = "3245",
				["deadend"] = "61be",
			},
			["AD"] = {
				["end"] = "487e",
			},
			["available"] = true,
			-- ["depart_time"] = 360,
			["depart_time"] = 60,
			["throttle"] = 0.40,
		},
	},
	["highway"] = {
		["highway_02"] = {
			["AC"] = "ebb1",
			["AD"] = "36c6",
			["available"] = true,
		},
	},
	["switch"] = {
		["switch_A"] = {
			["railway"] = {
				["platform_01"] = 1,
				["highway_02"] = 0,
			},
			["periph"] = "6b0f",
			["side"] = 1,
			["state"] = "platform_01",
		},
	},
}

return conf
