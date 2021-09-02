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
end


function LuaExportActivityNextEvent(t)
    log.write('VPC.EXPORT', log.INFO, 'Next frame triggered');
    data = {}
    vpcPanel = GetDevice(0)

    if vpcPanel ~= 0 then
        vpcPanel:update_arguments()
    end

    -- Executing common telemetry Export
    loadstring(readAll(lfs.writedir() .. '\\Scripts\\Hooks\\vpc\\common.lua'))()
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

    -- log.write('VPC.EXPORT', log.INFO, json:encode(LoGetEngineInfo()));
    socket.try(c:send(json:encode(data)))
    return t + 0.5
end

function LuaExportStop()
    -- socket.try(c:send("quit")) -- to close the listener socket
    c:close()
end
