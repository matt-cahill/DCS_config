local dcsHl=require('lfs');dofile(dcsHl.writedir()..'Scripts\\Helios\\HeliosExport.lua')
local dcsRg=require('lfs');dofile(dcsRg.writedir()..[[Scripts\DCS-raygun.lua]])
-- local dcsBs=require('lfs');dofile(dcsBs.writedir()..[[Scripts\DCS-BIOS\BIOS.lua]])
BIOS = {}; BIOS.LuaScriptDir = [[C:\Program Files\DCS-BIOS\dcs-lua\]]; BIOS.PluginDir = [[C:\Users\cahil\AppData\Roaming/DCS-BIOS/Plugins\]]; if lfs.attributes(BIOS.LuaScriptDir..[[BIOS.lua]]) ~= nil then dofile(BIOS.LuaScriptDir..[[BIOS.lua]]) end --[[DCS-BIOS Automatic Setup]]
local Tacviewlfs=require('lfs');dofile(Tacviewlfs.writedir()..'Scripts/TacviewGameExport.lua')
