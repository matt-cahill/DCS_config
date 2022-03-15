local PrevExportScript                    = {}
PrevExportScript.LuaExportStart           = LuaExportStart
PrevExportScript.LuaExportStop            = LuaExportStop
PrevExportScript.LuaExportBeforeNextFrame = LuaExportBeforeNextFrame
PrevExportScript.LuaExportAfterNextFrame  = LuaExportAfterNextFrame
PrevExportScript.LuaExportActivityNextEvent = LuaExportActivityNextEvent

local oldPath = package.path
local socketHost = "127.0.0.1"
local socketPort = 4123

package.path = package.path .. ";" .. lfs.currentdir() .. "/Scripts/JSON.lua"
json = require("json")
planeFile = nil
planeDefinitions = nil
package.path = oldPath
package.path = package.path .. ";" .. lfs.currentdir() .. "/LuaSocket/?.lua"
package.cpath = package.cpath .. ";" .. lfs.currentdir() .. "/LuaSocket/?.dll"
socket = require("socket")
c = socket.udp()
c:setpeername(socketHost, socketPort)

function fileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function ternary(condition, T, F)
    if condition then
        return T
    else
        return F
    end
end
function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end


function LuaExportStart()
    log.write('VPC.EXPORT', log.INFO, 'VPC Export start initiated'); 

    if PrevExportScript.LuaExportStart then
		PrevExportScript.LuaExportStart()
	end
end

function LuaExportBeforeNextFrame()
	if PrevExportScript.LuaExportBeforeNextFrame then
		return PrevExportScript.LuaExportBeforeNextFrame()
	end
	
	return NextTime
end

function LuaExportAfterNextFrame()
	if PrevExportScript.LuaExportAfterNextFrame then
		return PrevExportScript.LuaExportAfterNextFrame()
	end
	
	return NextTime
end


function LuaExportActivityNextEvent(t)
    local NextTime = t + 0.5
    -- log.write('VPC.EXPORT', log.INFO, 'Next frame triggered');
    data = {}
    vpcPanel = GetDevice(0)
    log.write('VPC.EXPORT', log.WARNING, vpcPanel);

    if vpcPanel ~= 0 then
        vpcPanel:update_arguments();
    end

    -- Executing common telemetry Export
    loadstring(readAll(lfs.writedir() .. '\\Scripts\\Hooks\\vpc\\common.lua'))()
    if vpcPanel ~= 0 then
        planeFile = lfs.writedir() .. '\\Scripts\\Hooks\\vpc\\planes\\' .. LoGetSelfData().Name .. ".lua"
        if fileExists(planeFile) then
            -- Executing plane specific telemetry Export
            if planeDefinitions == nil then
                planeDefinitions = readAll(planeFile)
            end
        else
            local planeTelemetryFile = assert(io.open(planeFile, 'w'))
            planeTelemetryFile:write("data['plane_Name'] = '" .. LoGetSelfData().Name .."'")    
            planeTelemetryFile:close() 
            planeDefinitions = readAll(planeFile)
        end
        loadstring(planeDefinitions)()
    end

    socket.try(c:send(json:encode(data)))
    
	if PrevExportScript.LuaExportActivityNextEvent then
		local t2 = PrevExportScript.LuaExportActivityNextEvent(t)
        if t2 < NextTime then
            NextTime = t2
        end
	end

    return NextTime
end

function LuaExportStop()
    -- socket.try(c:send("quit")) -- to close the listener socket
    c:close()
    if PrevExportScript.LuaExportStop then
		PrevExportScript.LuaExportStop()
	end
end
