-- ver 1.1
-- Add this line to Scripts/Export.lua to enable  :
-- local dcsRg=require('lfs');dofile(dcsRg.writedir()..[[Scripts\DCS-raygun.lua]])
--
-- Make sure you COPY this file to the same location as the Export.lua as well.
-- If an Export.lua doesn't exist, just create one and add the single line in it.
--
-- Edits by Matt Cahill 17.08.19
-- Added "Rg" name space to all global variables and local functions to avoid
-- conflicts with other exports.
-- Added chaining to global functions to allow previous declarations of the same
-- funtion in other exports to be called.
-- Removed unused LuaExportActivityNextEvent function call.
-- Stored socket port in a varaible.

RgHost = "127.0.0.1"
RgPort = 8124
RgArguments = {[404]="%.1f"}

-- Simulation id
RgSimID = string.format("%08x",os.time())

-- State data for export
RgSendStrings = {RgSimID, '*'}
RgLastData = {}

-- Prev Export functions.
local PastExport = {}
PastExport.ResetChangeValues = ResetChangeValues
PastExport.LuaExportStart = LuaExportStart
PastExport.LuaExportStop = LuaExportStop
PastExport.LuaExportAfterNextFrame = LuaExportAfterNextFrame

-- Status Gathering Functions
function RgProcessMainPanel()
	local lArgument , lFormat , lArgumentValue
	local lDevice = GetDevice(0)
	lDevice:update_arguments()

	for lArgument, lFormat in pairs(RgArguments) do
		lArgumentValue = string.format(lFormat,lDevice:get_argument_value(lArgument))
		RgSendData(lArgument, lArgumentValue)
	end
end

-- Network Functions
function RgSendData(id, value)
	if string.len(value) > 3 and value == string.sub("-0.00000000",1, string.len(value)) then
		value = value:sub(2)
	end

	if RgLastData[id] ~= value then
		table.insert(RgSendStrings, id .. "=" .. value)
		RgLastData[id] = value

		if #RgSendStrings > 140 then
			socket.try(Rgc:send(table.concat(RgSendStrings, ":").."\n"))
			RgSendStrings = {RgSimID, '*'}
		end
	end
end

function RgFlushData()
	if #RgSendStrings > 0 then
		socket.try(Rgc:send(table.concat(RgSendStrings, ":").."\n"))
		RgSendStrings = {RgSimID, '*'}
	end
end

function ResetChangeValues()
	for lArgument, lFormat in pairs(RgArguments) do
		RgLastData[lArgument] = "99999"
	end

	-- Chain previously-included export as necessary
	if PastExport.ResetChangeValues then
		PastExport.ResetChangeValues()
	end
end

function RgProcessOutput()
	RgProcessMainPanel()
	RgFlushData()
end

function LuaExportStart()
	package.path  = package.path..";.\\LuaSocket\\?.lua"
	package.cpath = package.cpath..";.\\LuaSocket\\?.dll"

	socket = require("socket")

	Rgc = socket.udp()
	Rgc:setpeername(RgHost, RgPort)
	Rgc:settimeout(.0001) -- set the timeout for reading the socket

	-- Chain previously-included export as necessary
	if PastExport.LuaExportStart then
		PastExport.LuaExportStart()
	end
end

function LuaExportAfterNextFrame()
	RgProcessOutput()

	-- Chain previously-included export as necessary
	if PastExport.LuaExportAfterNextFrame then
		PastExport.LuaExportAfterNextFrame()
	end
end

function LuaExportStop()
  Rgc:close()

	-- Chain previously-included export as necessary
	if PastExport.LuaExportStop then
		PastExport.LuaExportStop()
	end
end
