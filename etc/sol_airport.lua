local conf = {
	["name"] = "Solas - Airport",
	["arrival"] = {
		["01"] = {
			["AC"] = "76cb",
			["AD"] = "56ff",
			["brake"] = 0.10,
		},
	},
	["platform"] = {
		["01"] = {
			["AC"] = {
				["end"] = "3245",
				["deadend"] = "61be",
			},
			["AD"] = {
				["end"] = "487e",
			},
			["available"] = true,
			["depart_time"] = 360,
			["throttle"] = 0.50,
		},
	},
	["highway"] = {
		["02"] = {
			["AC"] = "ebb1",
			["AD"] = "36c6",
			["available"] = true,
		},
	},
	["switch"] = {
		["01-02"] = {
			["periph"] = "69b6",
			["side"] = 1,
			["state"] = 0,
		},
	},
}
return conf
