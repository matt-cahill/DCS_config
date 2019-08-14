-- ver 1.0
-- Add this line to Scripts/Export.lua to enable  :
-- local dcsRg=require('lfs');dofile(dcsRg.writedir()..[[Scripts\DCS-raygun.lua]])
-- 
-- Make sure you COPY this file to the same location as the Export.lua as well.
-- If an Export.lua doesn't exist, just create one and add the single line in it.

host = "127.0.0.1"
gArguments = {[404]="%.1f"}

-- Simulation id
gSimID = string.format("%08x",os.time())

-- State data for export
gSendStrings = {gSimID, '*'}
gLastData = {}

-- Status Gathering Functions
function ProcessMainPanel()
		local lArgument , lFormat , lArgumentValue
		local lDevice = GetDevice(0)
		lDevice:update_arguments()
		
		for lArgument, lFormat in pairs(gArguments) do 
			lArgumentValue = string.format(lFormat,lDevice:get_argument_value(lArgument))
			SendData(lArgument, lArgumentValue)
		end
end

-- Network Functions

function SendData(id, value)
	
	if string.len(value) > 3 and value == string.sub("-0.00000000",1, string.len(value)) then
		value = value:sub(2)
	end
	
	if gLastData[id] ~= value then
		table.insert(gSendStrings, id .. "=" .. value)
		gLastData[id] = value
		
		if #gSendStrings > 140 then
			socket.try(c:send(table.concat(gSendStrings, ":").."\n"))
			gSendStrings = {gSimID, '*'}
		end		
	end	
end

function FlushData()
	if #gSendStrings > 0 then
		socket.try(c:send(table.concat(gSendStrings, ":").."\n"))
		gSendStrings = {gSimID, '*'}
	end
end

function ResetChangeValues()
	for lArgument, lFormat in pairs(gArguments) do
		gLastData[lArgument] = "99999" 
	end
end

function ProcessOutput()
	ProcessMainPanel()
	FlushData()
end

function LuaExportStart()
    package.path  = package.path..";.\\LuaSocket\\?.lua"
    package.cpath = package.cpath..";.\\LuaSocket\\?.dll"
   
    socket = require("socket")
    
    c = socket.udp()
    c:setpeername(host, 8124)
    c:settimeout(.0001) -- set the timeout for reading the socket 
end

function LuaExportAfterNextFrame()	
	ProcessOutput()
end

function LuaExportStop()
    c:close()
end

function LuaExportActivityNextEvent(t)
	local tNext = t
	
	return tNext
end