local diff = {
	["axisDiffs"] = {
		["a2012cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = -0.2,
						},
						["deadzone"] = 0.04,
						["invert"] = false,
						["saturationX"] = 0.95,
						["saturationY"] = 1,
						["slider"] = true,
					},
					["key"] = "JOY_SLIDER1",
				},
			},
			["name"] = "Zoom View",
		},
		["a2033cdnil"] = {
			["changed"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_X",
				},
			},
			["name"] = "HOTAS Slew Horizontal",
		},
		["a2034cdnil"] = {
			["changed"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_Y",
				},
			},
			["name"] = "HOTAS Slew Vertical",
		},
	},
}
return diff