local socket = require("socket")

Helios_Udp = {}

Helios_Udp.Host = "127.0.0.1"
Helios_Udp.Port = 9089

Helios_Udp.Socket = nil

-- Simulation id
Helios_Udp.SimID = string.format("%08x*", os.time())

-- State data for export
Helios_Udp.PacketSize = 0
Helios_Udp.SendStrings = {}
Helios_Udp.LastData = {}

-- Frame counter for non important data
Helios_Udp.TickCount = 0

function Helios_Udp.Start()
	if Helios_Udp.Socket ~= nil then
		Helios_Udp.Socket:close()
		Helios_Udp.Socket = nil
	end
	
	Helios_Udp.PacketSize = 0
	Helios_Udp.SendStrings = {}
	Helios_Udp.LastData = {}

	Helios_Udp.Socket = socket.udp()

	if Helios_Udp.Socket == nil then return false end
	
	Helios_Udp.Socket:setsockname("*", 0)
	Helios_Udp.Socket:setoption('broadcast', true)
	Helios_Udp.Socket:settimeout(.001) -- set the timeout for reading the socket
	
	return true
end

function Helios_Udp.Stop()
	if Helios_Udp.Socket ~= nil then
		Helios_Udp.Socket:close()
	end
end

function Helios_Udp.Receive()
	if Helios_Udp.Socket == nil then return nil end
	
	return Helios_Udp.Socket:receive()
end

function Helios_Udp.Send(id, value)
	if string.len(value) > 3 and value == string.sub("-0.00000000", 1, string.len(value)) then
		value = value:sub(2)
	end
	
	if Helios_Udp.LastData[id] == nil or Helios_Udp.LastData[id] ~= value then
		local data =  id .. "=" .. value
		local dataLen = string.len(data)

		if dataLen + Helios_Udp.PacketSize > 576 then
			Helios_Udp.Flush()
		end

		table.insert(Helios_Udp.SendStrings, data)
		
		Helios_Udp.LastData[id] = value	
		Helios_Udp.PacketSize = Helios_Udp.PacketSize + dataLen + 1
	end	
end

function Helios_Udp.Flush()
	if #Helios_Udp.SendStrings > 0 then
		local packet = Helios_Udp.SimID..table.concat(Helios_Udp.SendStrings, ":").."\n"
		
		socket.try(Helios_Udp.Socket:sendto(packet, Helios_Udp.Host, Helios_Udp.Port))
		
		Helios_Udp.SendStrings = {}
		Helios_Udp.PacketSize = 0
	end
end

function Helios_Udp.ResetChangeValues()
	Helios_Udp.LastData = {}
	Helios_Udp.TickCount = 10
end
