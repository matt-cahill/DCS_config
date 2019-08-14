-- Helios integration - based on model used by TacView

do
	if isHeliosInitialized~=true then

		-- Protection against multiple references (typically wrong script installation)

		isHeliosInitialized=true;

		-- Load Helios core modules
		local localLfs=require('lfs');
		dofile(localLfs.writedir()..'Scripts\\Helios\\HeliosCore.lua')

		local HELIOS_CB = {}
		
		-- Register Callbacks in DCS World Export environment

		-- (Hook) Called once right before mission start.
		do
			HELIOS_CB.PrevLuaExportStart=LuaExportStart;

			LuaExportStart=function()
				HeliosExportStart()
				if HELIOS_CB.PrevLuaExportStart then
					HELIOS_CB.PrevLuaExportStart();
				end
			end
		end

		-- (Hook) Called right after every simulation frame.
		do
			HELIOS_CB.PrevLuaExportBeforeNextFrame=LuaExportBeforeNextFrame;

			LuaExportBeforeNextFrame=function()
				HeliosExportBeforeNextFrame()
				if HELIOS_CB.PrevLuaExportAfterNextFrame then
					HELIOS_CB.PrevLuaExportAfterNextFrame();
				end
			end
		end

		-- (Hook) Called right after every simulation event.
		do
			HELIOS_CB.PrevLuaExportActivityNextEvent=LuaExportActivityNextEvent;

			LuaExportActivityNextEvent=function(t)
				t = HeliosExportActivityNextEvent(t)
				if HELIOS_CB.PrevLuaExportActivityNextEvent then
					t = HELIOS_CB.PrevLuaExportActivityNextEvent(t);
				end
				return t;
			end
		end

		-- (Hook) Called right after mission end.
		do
			HELIOS_CB.PrevLuaExportStop=LuaExportStop;

			LuaExportStop=function()
				HeliosExportStop()
				if HELIOS_CB.PrevLuaExportStop then
					HELIOS_CB.PrevLuaExportStop();
				end
			end
		end

		log.write('HELIOS.EXPORT',log.INFO,'Helios Export Hooks Installed')

	end
end
