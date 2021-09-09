if (vpcPanel:get_argument_value(80) == 0) then
    data["LandingGearGreenLight"] = "0"
else
    data["LandingGearGreenLight"] = "1"
end
if (vpcPanel:get_argument_value(82) == 0) then
    data["LandingGearRedLight"] = "0"
else
    data["LandingGearRedLight"] = "1"
end
if (vpcPanel:get_argument_value(122) == 0) then
    data["A_channel_light"] = "0"
else
    data["A_channel_light"] = "1"
end
if (vpcPanel:get_argument_value(123) == 0) then
    data["B_channel_light"] = "0"
else
    data["B_channel_light"] = "1"
end
if (vpcPanel:get_argument_value(124) == 0) then
    data["C_channel_light"] = "0"
else
    data["C_channel_light"] = "1"
end
if (vpcPanel:get_argument_value(125) == 0) then
    data["D_channel_light"] = "0"
else
    data["D_channel_light"] = "1"
end
if (vpcPanel:get_argument_value(126) == 0) then
    data["Transmit_light"] = "0"
else
    data["Transmit_light"] = "1"
end
