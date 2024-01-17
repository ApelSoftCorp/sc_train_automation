local conf = {
	["name"] = "TEST - 02",
	["arrival"] = {
		["arrival_01"] = {
			["AC"] = "6823",
			["AD"] = "870a",
			["brake"] = 0.6,
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
				["end"] = "4d07",
				["deadend"] = "06b5",
			},
			["AD"] = {
				["end"] = "f3e3",
			},
			["available"] = true,
			-- ["depart_time"] = 360,
			["depart_time"] = 60,
			["throttle"] = 0.50,
		},
	},
	["highway"] = {
		["highway_02"] = {
			["AC"] = "9c43",
			["AD"] = "95ab",
			["available"] = true,
		},
	},
	["switch"] = {
		["switch_A"] = {
			["railway"] = {
				["platform_01"] = 1,
				["highway_02"] = 0,
			},
			["periph"] = "f32b",
			["side"] = 1,
		},
	},
}

return conf
