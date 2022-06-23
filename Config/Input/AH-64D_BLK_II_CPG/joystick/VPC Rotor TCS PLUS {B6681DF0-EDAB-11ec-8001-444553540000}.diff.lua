local diff = {
	["axisDiffs"] = {
		["a2001cdnil"] = {
			["name"] = "Cyclic Pitch",
			["removed"] = {
				[1] = {
					["key"] = "JOY_Y",
				},
			},
		},
		["a2002cdnil"] = {
			["name"] = "Cyclic Roll",
			["removed"] = {
				[1] = {
					["key"] = "JOY_X",
				},
			},
		},
		["a2087cdnil"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0,
						},
						["deadzone"] = 0,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = true,
					},
					["key"] = "JOY_X",
				},
			},
			["name"] = "Collective",
			["removed"] = {
				[1] = {
					["key"] = "JOY_Z",
				},
			},
		},
		["a3087cd52"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0.02,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RX",
				},
			},
			["name"] = "RHG MAN TRK Controller - X axis",
		},
		["a3088cd52"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0.02,
						["invert"] = false,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RY",
				},
			},
			["name"] = "RHG MAN TRK Controller - Y axis",
		},
	},
	["keyDiffs"] = {
		["d3023pnilunilcd3vd-1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN64",
				},
			},
			["name"] = "PLT NVS MODE Switch - OFF",
		},
		["d3023pnilunilcd3vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN63",
				},
			},
			["name"] = "PLT NVS MODE Switch - NORM",
		},
		["d3023pnilunilcd3vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN62",
				},
			},
			["name"] = "PLT NVS MODE Switch - FIXED",
		},
		["d3030pnilu3030cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN4",
				},
			},
			["name"] = "LHG Image AutoTrack/Offset Switch - IAT/Center",
		},
		["d3032pnilu3032cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN9",
				},
			},
			["name"] = "LHG TADS FOV Switch - Z (Zoom)",
		},
		["d3033pnilu3033cd52vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN11",
				},
			},
			["name"] = "LHG TADS FOV Switch - M (Medium)",
		},
		["d3034pnilu3034cd52vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN12",
				},
			},
			["name"] = "LHG TADS FOV Switch - N (Narrow)",
		},
		["d3035pnilu3035cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN10",
				},
			},
			["name"] = "LHG TADS FOV Switch - W (Wide)",
		},
		["d3036pnilunilcd52vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN5",
				},
			},
			["name"] = "LHG TADS Sensor Select Switch - FLIR",
		},
		["d3037pnilunilcd52vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN6",
				},
			},
			["name"] = "LHG TADS Sensor Select Switch - TV",
		},
		["d3039pnilu3039cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN13",
				},
			},
			["name"] = "LHG STORE/Update Switch - STORE/Center",
		},
		["d3042pnilu3042cd3vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN25",
				},
			},
			["name"] = "GND ORIDE Pushbutton",
		},
		["d3043pnilu3043cd3vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN35",
				},
				[2] = {
					["key"] = "JOY_BTN24",
				},
			},
			["name"] = "A/S Pushbutton",
		},
		["d3044pnilu3044cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN8",
				},
			},
			["name"] = "LHG Linear Motion Compensation (LMC) Button",
		},
		["d3053pnilu3053cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN19",
				},
			},
			["name"] = "LHG Cursor - Up",
		},
		["d3054pnilu3054cd52vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN21",
				},
			},
			["name"] = "LHG Cursor - Down",
		},
		["d3055pnilu3055cd52vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN22",
				},
			},
			["name"] = "LHG Cursor - Left",
		},
		["d3056pnilu3056cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN20",
				},
			},
			["name"] = "LHG Cursor - Right",
		},
		["d3057pnilu3057cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN23",
				},
			},
			["name"] = "LHG Cursor Enter Trigger",
		},
		["d3057pnilu3057cd6vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN31",
				},
			},
			["name"] = "Fire Detection Circuit Test Switch - 1",
		},
		["d3058pnilu3058cd6vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN32",
				},
			},
			["name"] = "Fire Detection Circuit Test Switch - 2",
		},
		["d3063pnilu3063cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN14",
				},
			},
			["name"] = "RHG Sight Select Switch - HMD",
		},
		["d3064pnilu3064cd52vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN16",
				},
			},
			["name"] = "RHG Sight Select Switch - LINK",
		},
		["d3065pnilu3065cd52vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN17",
				},
			},
			["name"] = "RHG Sight Select Switch - FCR",
		},
		["d3066pnilu3066cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN15",
				},
			},
			["name"] = "RHG Sight Select Switch - TADS",
		},
		["d3075pnilu3075cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN7",
				},
			},
			["name"] = "RHG FLIR Polarity Button",
		},
		["d3076pnilu3076cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN18",
				},
			},
			["name"] = "RHG Sight Slave Button",
		},
		["d3078pnilu3078cd52vd0.5vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN2",
				},
			},
			["name"] = "RHG LRFD Trigger - FIRST DETENT",
		},
		["d3078pnilu3078cd52vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN3",
				},
			},
			["name"] = "RHG LRFD Trigger - SECOND DETENT",
		},
	},
}
return diff