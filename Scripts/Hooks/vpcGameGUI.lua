vpc = {}

function vpc.onSimulationStart()
    net.log("vpcGameGUI: loading VPC Export ");
    net.dostring_in("export", "dofile(lfs.writedir()..[[Scripts\\Hooks\\vpc\\VPCExport.lua]])");
    net.log('VPC Export loaded');
end

-- Reloading callbacks 
function vpc.onMissionLoadBegin()
    net.log('Mission starts loading');
    DCS.reloadUserScripts();
    net.log('Scripts successfully reloaded.');
end

-- Set callbacks
DCS.setUserCallbacks(vpc);

-- Success
net.log("VPC script loaded!");