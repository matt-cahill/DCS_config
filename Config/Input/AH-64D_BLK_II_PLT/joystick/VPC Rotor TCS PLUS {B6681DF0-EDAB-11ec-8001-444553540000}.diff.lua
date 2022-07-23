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
		["a3042cd25"] = {
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
			["name"] = "HOCAS Cursor Controller - X axis",
		},
		["a3043cd25"] = {
			["added"] = {
				[1] = {
					["filter"] = {
						["curvature"] = {
							[1] = 0.3,
						},
						["deadzone"] = 0.02,
						["invert"] = true,
						["saturationX"] = 1,
						["saturationY"] = 1,
						["slider"] = false,
					},
					["key"] = "JOY_RY",
				},
			},
			["name"] = "HOCAS Cursor Controller - Y axis",
		},
	},
	["keyDiffs"] = {
		["d3001pnilu3001cd77vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN43",
				},
			},
			["name"] = "L OUTBD Station Select Pushbutton - ARM/SAFE",
		},
		["d3002pnilu3002cd77vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN44",
				},
			},
			["name"] = "L INBD Station Select Pushbutton - ARM/SAFE",
		},
		["d3003pnilu3003cd77vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN45",
				},
			},
			["name"] = "R INBD Station Select Pushbutton - ARM/SAFE",
		},
		["d3004pnilu3004cd77vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN46",
				},
			},
			["name"] = "R OUTBD Station Select Pushbutton - ARM/SAFE",
		},
		["d3005pnilu3005cd50vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN19",
				},
			},
			["name"] = "RTS Rocker Switch - Up",
		},
		["d3006pnilu3006cd50vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN21",
				},
			},
			["name"] = "RTS Rocker Switch - Down",
		},
		["d3006pnilunilcd5vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN36",
				},
			},
			["name"] = "Rotor Brake Switch - BRK",
		},
		["d3006pnilunilcd5vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN35",
				},
			},
			["name"] = "Rotor Brake Switch - OFF",
		},
		["d3007pnilu3007cd77vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN50",
				},
				[2] = {
					["key"] = "JOY_BTN51",
				},
			},
			["name"] = "JETT Pushbutton",
		},
		["d3011pnilu3011cd2vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN72",
				},
			},
			["name"] = "Power Lever Finger Lift (Left) - UP/DOWN",
		},
		["d3012pnilu3012cd2vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN77",
				},
			},
			["name"] = "Power Lever Finger Lift (Right) - UP/DOWN",
		},
		["d3017pnilu3017cd25vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN22",
				},
			},
			["name"] = "PTT/RTS Switch - RADIO/Left (call radio menu)",
		},
		["d3018pnilu3018cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN20",
				},
			},
			["name"] = "PTT/RTS Switch - ICS/Right (call radio menu)",
		},
		["d3019pnilunilcd3vd0.5vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN58",
				},
			},
			["name"] = "Master Ignition Switch - BATT",
		},
		["d3019pnilunilcd3vd0vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN59",
				},
			},
			["name"] = "Master Ignition Switch - OFF",
		},
		["d3019pnilunilcd3vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN57",
				},
			},
			["name"] = "Master Ignition Switch - EXT PWR",
		},
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
		["d3028pnilu3028cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN14",
				},
			},
			["name"] = "Sight Select Switch - HMD/Up",
		},
		["d3029pnilu3029cd25vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN16",
				},
			},
			["name"] = "Sight Select Switch - LINK/Down",
		},
		["d3030pnilu3030cd25vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN17",
				},
			},
			["name"] = "Sight Select Switch - FCR/Left",
		},
		["d3031pnilu3031cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN15",
				},
			},
			["name"] = "Sight Select Switch - TADS/Right",
		},
		["d3035pnilu3035cd6vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN27",
				},
			},
			["name"] = "APU Pushbutton - Start/Stop",
		},
		["d3037pnilunilcd6vd1vpnilvunil"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN26",
				},
			},
			["name"] = "APU Pushbutton Cover - OPEN/CLOSE",
		},
		["d3038pnilu3038cd6vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN71",
				},
			},
			["name"] = "No.1 Engine Start Switch - START",
		},
		["d3039pnilu3039cd6vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN73",
				},
			},
			["name"] = "No.1 Engine Start Switch - IGN ORIDE",
		},
		["d3040pnilu3040cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN8",
				},
			},
			["name"] = "Cursor Enter - Depress",
		},
		["d3040pnilu3040cd6vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN76",
				},
			},
			["name"] = "No.2 Engine Start Switch - START",
		},
		["d3041pnilu3041cd6vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN78",
				},
			},
			["name"] = "No.2 Engine Start Switch - IGN ORIDE",
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
					["key"] = "JOY_BTN24",
				},
			},
			["name"] = "A/S Pushbutton",
		},
		["d3044pnilu3044cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN4",
				},
			},
			["name"] = "Cursor Display Select Button - Depress",
		},
		["d3051pnilu3051cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN11",
				},
			},
			["name"] = "NVS Select Switch - TADS",
		},
		["d3052pnilu3052cd25vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN9",
				},
			},
			["name"] = "NVS Select Switch - PNVS",
		},
		["d3053pnilu3053cd25vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN12",
				},
			},
			["name"] = "Boresight/Polarity Switch - B/S",
		},
		["d3054pnilu3054cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN10",
				},
			},
			["name"] = "Boresight/Polarity Switch - PLRT",
		},
		["d3055pnilu3055cd25vd-1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN5",
				},
			},
			["name"] = "Stabilator Control Switch - NU",
		},
		["d3056pnilu3056cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN6",
				},
			},
			["name"] = "Stabilator Control Switch - ND",
		},
		["d3057pnilu3057cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN7",
				},
			},
			["name"] = "Stabilator Control Switch - Depress",
		},
		["d3066pnilu3066cd25vd1vpnilvu0"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN13",
				},
			},
			["name"] = "Tail Wheel Lock/Unlock Button - Depress",
		},
		["d313pnilu311cdnilvd1vpnilvu1"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN69",
				},
			},
			["name"] = "Power Lever (Left) - OFF(hold)<>IDLE",
		},
		["d314pnilu312cdnilvd1vpnilvu1"] = {
			["added"] = {
				[1] = {
					["key"] = "JOY_BTN70",
				},
			},
			["name"] = "Power Lever (Right) - OFF(hold)<>IDLE",
		},
	},
}
return diff