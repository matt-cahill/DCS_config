dofile(lfs.writedir()..[[Scripts\Helios\Helios_Includes.lua]])

Helios = {}

Helios.DebugFile = nil
Helios.Interval = 0.1 -- frequency of export events (sec)
Helios.LowTickInterval = 2  -- export events call ProcessLowImportance every this many events.

Helios.Aircraft = nil -- Table with aircrafts functions
Helios.LastName = ""
Helios.LastIdent = 0
Helios.AircraftList = {} -- Table with aircrafts

function Helios.Start()
	Helios.DebugFile = io.open(lfs.writedir()..[[Logs\HeliosDebug.log]], "wa")
	
	log.write('HELIOS EXPORT',log.INFO,'Mission Started')

	if not Helios_Udp.Start() then
		if Helios.DebugFile then
			Helios.DebugFile:write("ERROR CREATING HELIOS SOCKET!\r\n")
		end

		return
	end	

	if Helios.DebugFile then
		Helios.DebugFile:write("HELIOS SOCKET CREATED!\r\n")
	end

	Helios.Aircraft = nil
	Helios.AircraftList = {}
	
	-- Add aircraft profiles
	table.insert(Helios.AircraftList, Helios_FC)

	table.insert(Helios.AircraftList, Helios_Huey)
	table.insert(Helios.AircraftList, Helios_MI8)
	table.insert(Helios.AircraftList, Helios_KA50)
	table.insert(Helios.AircraftList, Helios_SA342)
	
	table.insert(Helios.AircraftList, Helios_A10C)
	table.insert(Helios.AircraftList, Helios_F18C)	
	table.insert(Helios.AircraftList, Helios_P51)
	table.insert(Helios.AircraftList, Helios_Harrier)
	table.insert(Helios.AircraftList, Helios_F14)
	table.insert(Helios.AircraftList, Helios_F16C)
	
	table.insert(Helios.AircraftList, Helios_Mig21Bis)
	table.insert(Helios.AircraftList, Helios_L39)
end

function Helios.BeforeNextFrame()
	local data = Helios_Udp.Receive()
	
	if data == nil then return end
	if Helios.Aircraft == nil then return end
	
	Helios.ProcessInput(data)
end

function Helios.ActivityNextEvent()
	Helios_Udp.TickCount = Helios_Udp.TickCount + 1

	local selfdata = LoGetSelfData()
	
	-- Check if we are on an aircraft
	if not Helios.CheckAircraft(selfdata) then return end
	
	if Helios.Aircraft.FlamingCliffsAircraft then
		Helios.ProcessExports(selfdata)
	else
		local lDevice = GetDevice(0)

		if type(lDevice) == "table" then
		
			lDevice:update_arguments()

			-- Handle the simple-case data that can be simply read via device:get_argument_value
			Helios.ProcessArguments(lDevice, Helios.Aircraft.HighImportanceArguments)
			
			-- Handle the more complex calculations that need special logic...			
			Helios.HighImportance(lDevice)

			if Helios_Udp.TickCount >= Helios.LowTickInterval then
			
				-- Handle the simple-case data that can be simply read via device:get_argument_value
				Helios.ProcessArguments(lDevice, Helios.Aircraft.LowImportanceArguments)
				
				-- Handle the more complex calculations that need special logic...
				Helios.LowImportance(lDevice)
								
				Helios_Udp.TickCount = 0 -- start Low Importance tick counting again
			end
			
			
			Helios_Udp.Flush()
		end
	end
end

function Helios.Stop()
	Helios_Udp.Stop()

	log.write('HELIOS EXPORT',log.INFO,'Mission Ended')

	if Helios.DebugFile then
		Helios.DebugFile:write("LuaExportStop called.\r\n")
		io.close(Helios.DebugFile)
	end
end

-- Get index of aircraft in AircraftList, or -1 if not exist
function Helios.GetIndex(aircraft)
	if Helios.AircraftList == nil then return -1 end
	
	local strcompare = nil
	
	for a = 1, #Helios.AircraftList do
		
		strcompare = Helios_Util.Split(Helios.AircraftList[a].Name, ";")
		
		for b = 1, #strcompare do
			if Helios_Util.CompareString(aircraft, strcompare[b]) then
				return a
			end
		end
	end
	
	return -1
end

function Helios.CheckAircraft(data)
	if data == nil then return false end

	-- Check if we have changed aircraft
	if (Helios.Aircraft == nil) or (not Helios_Util.CompareString(Helios.LastName, data.Name) or Helios.LastIdent ~= LoGetPlayerPlaneId()) then
		-- if no aircraft has been added
		if Helios.AircraftList == nil then
			Helios.Aircraft = nil
			return false
		end

		-- Search the list of aircrafts, if there is one with which the user has entered
		local index = Helios.GetIndex(data.Name)
		
		if index == -1 then
			Helios.Aircraft = nil
			return false
		end
		
		-- One has been found
		Helios.LastName = data.Name
		Helios.LastIdent = LoGetPlayerPlaneId()

		Helios.Aircraft = Helios.AircraftList[index]
		
		if Helios_Util.TableCheckFunction(Helios.Aircraft, "ProcessInput") then
			Helios.ProcessInput = Helios.Aircraft.ProcessInput
		end

		if Helios_Util.TableCheckFunction(Helios.Aircraft, "ProcessExports") then
			Helios.ProcessExports = Helios.Aircraft.ProcessExports
		end

		if Helios_Util.TableCheckFunction(Helios.Aircraft, "HighImportance") then
			Helios.HighImportance = Helios.Aircraft.HighImportance
		end
		
		if Helios_Util.TableCheckFunction(Helios.Aircraft, "LowImportance") then
			Helios.LowImportance = Helios.Aircraft.LowImportance
		end

		Helios_Udp.ResetChangeValues()

		Helios.DebugFile:write("Aircraft detected: "..data.Name.."\n")
	end

	if Helios.Aircraft == nil then return false end
	
	return true
end

-- Take any inputs from Helios and pass them to DCS World
function Helios.ProcessInput(data)
	local lCommand, lCommandArgs, lDevice, lArgument, lLastValue

	lCommand = string.sub(data,1,1)

	if lCommand == "R" then
		Helios_Udp.ResetChangeValues()
	end

	if (lCommand == "C") then
		lCommandArgs = Helios_Util.Split(string.sub(data,2),",")
		
			--[[
		------------------- correct the changes on the A-10C TACAN device from DCS 1.5.6.1938 - added by Capt Zeen  
		if Helios.LastName == "A-10C" and lCommandArgs[1] == "51" then
			local command_temp="3000"
			if lCommandArgs[2] == "3006" then command_temp="3004" end
			if lCommandArgs[2] == "3007" then command_temp="3005" end
			if lCommandArgs[2] == "3001" then command_temp="3001" end
			if lCommandArgs[2] == "3003" then command_temp="3002" end
			if lCommandArgs[2] == "3005" then
				command_temp="3003"
				if lCommandArgs[3] <="0.9" then
					lCommandArgs[3]=0
				else
					lCommandArgs[3]=1
				end
			end
			if lCommandArgs[2] == "3008" then command_temp="3006" end
			if command_temp ~= "3000" then
				lCommandArgs[2] = command_temp
				lCommandArgs[1] = "74"
			end
		end
		------------------------------- end of TACAN fix
		--]]
		lDevice = GetDevice(lCommandArgs[1])
		
		if type(lDevice) == "table" then
			lDevice:performClickableAction(lCommandArgs[2],lCommandArgs[3])	
		end
	end
end

-- Handles simple-case data that can be simply read via device:get_argument_value
function Helios.ProcessArguments(device, arguments)
	if arguments == nil then return end
	
	local lArgument , lFormat , lArgumentValue
	--[[	
	if Helios.LastName == "A-10C" then ----------------------------- A10C TACAN FIX for Helios & DCS 1.5.6+
		for lArgument, lFormat in pairs(arguments) do 
			lArgumentValue = string.format(lFormat,device:get_argument_value(lArgument))
			if lArgument == 266 then -- x/y tacan mode display
				if device:get_argument_value(lArgument)==0 then
					lArgumentValue = string.format(lFormat,0)
				else
					lArgumentValue = string.format(lFormat,1)
				end
			end
			if lArgument == 258 then -- x/y tacan mode switch
				if device:get_argument_value(lArgument)==0 then
					lArgumentValue = string.format(lFormat,0.87)
				else
					lArgumentValue = string.format(lFormat,0.93)
				end
			end
			Helios_Udp.Send(lArgument, lArgumentValue)		
		end	
	else 	
		]]--
	  -- Other airplanes
		for lArgument, lFormat in pairs(arguments) do 	
			lArgumentValue = string.format(lFormat,device:get_argument_value(lArgument))	
			Helios_Udp.Send(lArgument, lArgumentValue)
		end
	--end
end

function Helios.ProcessExports(data) end
function Helios.HighImportance(data) end
function Helios.LowImportance(data) end
