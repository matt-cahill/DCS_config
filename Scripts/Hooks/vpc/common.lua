if LoIsOwnshipExportAllowed() then
    local mechanisationStatus = LoGetMechInfo()
    local counterMeasures = LoGetSnares()
    local failureStatus = LoGetMCPState()
    local pitch, bank, yaw = LoGetADIPitchBankYaw();
	data['plane']        =  LoGetSelfData().Name;

    -- Mechanisation
    data["mech_Gear_Status"] = mechanisationStatus.gear.status
    data["mech_Gear_Value"] = string.format('%.0f', mechanisationStatus.gear.value * 100)
    if mechanisationStatus.hook then
        data["mech_Hook_Status"] = mechanisationStatus.hook.status
        data["mech_Hook_Value"] = mechanisationStatus.hook.value
    end
    data["mech_Flaps_Status"] = mechanisationStatus.flaps.status
    data["mech_Flaps_Value"] = string.format("%.0f", mechanisationStatus.flaps.value * 100)
    data["mech_Speedbrakes_Status"] = mechanisationStatus.speedbrakes.status
    data["mech_Speedbrakes_Value"] = mechanisationStatus.speedbrakes.value
    data["mech_Refuelingboom_Status"] = mechanisationStatus.refuelingboom.status
    data["mech_Refuelingboom_Value"] = mechanisationStatus.refuelingboom.value * 100
    if mechanisationStatus.airintake then
        data["mech_Airintake_Status"] = mechanisationStatus.airintake.status
        data["mech_Airintake_Value"] = mechanisationStatus.airintake.value
    end
    if mechanisationStatus.noseflap then
        data["mech_Noseflap_Status"] = mechanisationStatus.noseflap.status
        data["mech_Noseflap_Value"] = mechanisationStatus.noseflap.value
    end

    data["mech_Parachute_Status"] = mechanisationStatus.parachute.status
    data["mech_Parachute_Value"] = mechanisationStatus.parachute.value
    data["mech_Wheelbrakes_Status"] = mechanisationStatus.wheelbrakes.status
    data["mech_Wheelbrakes_Value"] = mechanisationStatus.wheelbrakes.value
    if mechanisationStatus.wing then
        data["mech_Wing_Status"] = mechanisationStatus.wing.status
        data["mech_Wing_Value"] = mechanisationStatus.wing.value
    end
    data["mech_Canopy_Status"] = mechanisationStatus.canopy.status
    data["mech_Canopy_Value"] = mechanisationStatus.canopy.value * 100

    -- Failures
    data["mcp_LeftEngineFailure"] = failureStatus.LeftEngineFailure or 0
    data["mcp_RightEngineFailure"] = failureStatus.RightEngineFailure or 0
    data["mcp_HydraulicsFailure"] = failureStatus.HydraulicsFailure or 0
    data["mcp_ACSFailure"] = failureStatus.ACSFailure or 0
    data["mcp_AutopilotFailure"] = failureStatus.AutopilotFailure or 0
    data["mcp_AutopilotOn"] = failureStatus.AutopilotOn or 0
    data["mcp_MasterWarning"] = failureStatus.MasterWarning or 0
    data["mcp_LeftTailPlaneFailure"] = failureStatus.LeftTailPlaneFailure or 0
    data["mcp_RightTailPlaneFailure"] = failureStatus.RightTailPlaneFailure or 0
    data["mcp_LeftAileronFailure"] = failureStatus.LeftAileronFailure or 0
    data["mcp_RightAileronFailure"] = failureStatus.RightAileronFailure or 0
    data["mcp_CanopyOpen"] = failureStatus.CanopyOpen or 0
    data["mcp_CannonFailure"] = failureStatus.CannonFailure or 0
    data["mcp_StallSignalization"] = failureStatus.StallSignalization or 0
    data["mcp_LeftMainPumpFailure"] = failureStatus.LeftMainPumpFailure or 0
    data["mcp_LeftWingPumpFailure"] = failureStatus.LeftWingPumpFailure or 0
    data["mcp_RightMainPumpFailure"] = failureStatus.RightMainPumpFailure or 0
    data["mcp_RightWingPumpFailure"] = failureStatus.RightWingPumpFailure or 0
    data["mcp_RadarFailure"] = failureStatus.RadarFailure or 0
    data["mcp_EOSFailure"] = failureStatus.EOSFailure or 0
    data["mcp_MLWSFailure"] = failureStatus.MLWSFailure or 0
    data["mcp_RWSFailure"] = failureStatus.RWSFailure or 0
    data["mcp_ECMFailure"] = failureStatus.ECMFailure or 0
    data["mcp_GearFailure"] = failureStatus.GearFailure or 0
    data["mcp_MFDFailure"] = failureStatus.MFDFailure or 0
    data["mcp_HUDFailure"] = failureStatus.HUDFailure or 0
    data["mcp_HelmetFailure"] = failureStatus.HelmetFailure or 0
    data["mcp_FuelTankDamage"] = failureStatus.FuelTankDamage or 0

    -- Plane telemetry
    data["plane_IndicatedAirSpeed"] = string.format('%.0f', LoGetIndicatedAirSpeed()) or 0
    data["plane_AngleOfAttack"] = string.format('%.2f', LoGetAngleOfAttack()) or 0
    data["plane_AngleOfSideSlip"] = string.format('%.2f', LoGetAngleOfSideSlip()) or 0
    data["plane_AccelerationUnits_x"] = string.format('%.2f', LoGetAccelerationUnits().x) or 0.00
    data["plane_AccelerationUnits_y"] = string.format('%.2f', LoGetAccelerationUnits().y) or 0.00
    data["plane_AccelerationUnits_z"] = string.format('%.2f', LoGetAccelerationUnits().z) or 0.00
    data["plane_VerticalVelocity"] = string.format('%.0f', LoGetVerticalVelocity()) or 0
    data["plane_ADIPitch"] = string.format('%.0f', math.deg(pitch)) or 0
    data["plane_ADIBank"] = string.format('%.0f', math.deg(bank)) or 0
    data["plane_CurrentCourse"] = string.format('%.0f', math.deg(yaw)) or 0
    data["plane_TrueAirSpeed"] = string.format('%.0f', LoGetTrueAirSpeed()) or 0
    data["plane_AltitudeAboveSeaLevel"] = string.format('%.0f', LoGetAltitudeAboveSeaLevel()) or 0
    data["plane_AltitudeAboveGroundLevel"] = string.format('%.0f', LoGetAltitudeAboveGroundLevel()) or 0
    data["plane_MachNumber"] = string.format('%.2f', LoGetMachNumber()) or 0
    data["plane_RadarAltimeter"] = string.format('%.0f', LoGetRadarAltimeter()) or 0
    data["plane_MagneticYaw"] = string.format('%.2f', LoGetMagneticYaw()) or 0
    data["plane_GlideDeviation"] = LoGetGlideDeviation() or 0
    data["plane_SideDeviation"] = LoGetSideDeviation() or 0
    data["plane_SlipBallPosition"] = LoGetSlipBallPosition() or 0
    data["plane_BasicAtmospherePressure"] = LoGetBasicAtmospherePressure() or 0
    data["plane_Altitude"] = LoGetAltitude() or 0

    -- Countermeasures count
    data["plane_chaff"] = counterMeasures.chaff
    data["plane_flare"] = counterMeasures.flare
else
    data["export_allowed"] = 0
end
