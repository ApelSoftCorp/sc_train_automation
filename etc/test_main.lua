local conf = {
	["name"] = "TEST - Main Station",
	["arrival"] = {
		["arrival_01"] = {
			["AC"] = "4898",
			["AD"] = "bf0d",
			["brake"] = 0.6,
			["switch"] = {
				"switch_A",
				"switch_B",
			},
			["default_railway"] = "platform_02",
			["railway"] = {
				"platform_01",
				"platform_02",
				"highway_03",
			},
		},
	},
	["platform"] = {
		["platform_01"] = {
			["AC"] = {
				["end"] = "77cd",
				["deadend"] = "d527",
			},
			["AD"] = {
				["end"] = "0293",
			},
			["available"] = true,
			-- ["depart_time"] = 360,
			["depart_time"] = 60,
			["throttle"] = 0.50,
		},
		["platform_02"] = {
			["AC"] = {
				["end"] = "211f",
				["deadend"] = "22cf",
			},
			["AD"] = {
				["end"] = "e8c8",
			},
			["available"] = true,
			-- ["depart_time"] = 360,
			["depart_time"] = 60,
			["throttle"] = 0.50,
		},
	},
	["highway"] = {
		["highway_03"] = {
			["AC"] = "d1c7",
			["AD"] = "57c9",
			["available"] = true,
		},
	},
	["switch"] = {
		["switch_A"] = {
			["railway"] = {
				["platform_01"] = 1,
				["platform_02"] = 0,
				["highway_03"] = 0,
			},
			["periph"] = "52bd",
			["side"] = 1,
		},
		["switch_B"] = {
			["railway"] = {
				["platform_01"] = 0,
				["platform_02"] = 0,
				["highway_03"] = 1,
			},
			["periph"] = "8eb5",
			["side"] = 1,
		},
	},
}

return conf
