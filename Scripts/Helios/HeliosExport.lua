package.path = package.path..";.\\LuaSocket\\?.lua;"
package.cpath = package.cpath..";.\\LuaSocket\\?.dll;"

dofile(lfs.writedir()..[[Scripts\Helios\HeliosCore.lua]])

local PrevExport = {}
PrevExport.LuaExportStart = LuaExportStart
PrevExport.LuaExportStop = LuaExportStop
PrevExport.LuaExportActivityNextEvent = LuaExportActivityNextEvent
PrevExport.LuaExportBeforeNextFrame = LuaExportBeforeNextFrame

function LuaExportStart()
	local status, err = pcall(function()
		Helios.Start()
	end)
	
    if not status then
		log.write('ERROR Helios.Start', log.INFO, err)
    end
	
	if PrevExport.LuaExportStart then
		PrevExport.LuaExportStart()
	end
end

function LuaExportStop()
	local status, err = pcall(function()
		Helios.Stop()
	end)
	
    if not status then
		log.write('ERROR Helios.Stop', log.INFO, err)
    end
	
	if PrevExport.LuaExportStop then
		PrevExport.LuaExportStop()
	end
end

function LuaExportBeforeNextFrame()
	local status, err = pcall(function()
		Helios.BeforeNextFrame()
	end)
	
    if not status then
		log.write('ERROR Helios.BeforeNextFrame', log.INFO, err)
    end
	
	if PrevExport.LuaExportBeforeNextFrame then
		PrevExport.LuaExportBeforeNextFrame()
	end
	
	return NextTime
end

function LuaExportActivityNextEvent(currenttime)
    local NextTime = currenttime + Helios.Interval
	
	local status, err = pcall(function()
		Helios.ActivityNextEvent()
	end)
	
    if not status then
		log.write('ERROR Helios.ActivityNextEvent', log.INFO, err)
    end
	
	if PrevExport.LuaExportActivityNextEvent then
		PrevExport.LuaExportActivityNextEvent(currenttime)
	end
	
	return NextTime
end
