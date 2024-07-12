--[[pod_format="raw",created="2024-06-11 16:05:06",modified="2024-06-11 16:05:06",revision=0]]


-- load settings
local sdat = fetch"/appdata/system/settings.pod"
--if not sdat then
--	-- install defaults
--	sdat = fetch"/system/misc/default_settings.pod"
--	store("/appdata/system/settings.pod", sdat)
--end

-- newer settings that should default to a non-nil value
if (sdat.anywhen == nil) then
	sdat.anywhen = true
	store("/appdata/system/settings.pod", sdat)
end
mount("/system/util/dir.lua","/system/util/ls.lua")   
mount("/system/util/edit.lua","/system/util/open.lua") 

create_process("/system/terminal.lua", 
	{
		window_attribs = {
			fullscreen = true,
			pwc_output = true,        -- run present working cartridge in this window
			immortal   = true         -- no close pulldown
		},
		immortal   = true -- exit() is a NOP
	}
)