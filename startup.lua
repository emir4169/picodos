--[[pod_format="raw",created="2024-06-11 16:05:06",modified="2024-06-11 16:05:06",revision=0]]

-- load settings
local sdat = fetch"/appdata/system/settings.pod"
_apply_system_settings(sdat)

if not sdat then
	-- install defaults
	sdat = fetch"/system/misc/default_settings.pod"
	store("/appdata/system/settings.pod", sdat)
end

-- newer settings that should default to a non-nil value
if (sdat.anywhen == nil) then
	sdat.anywhen = true
	store("/appdata/system/settings.pod", sdat)
end
printh("here from after all the system settings things")

-- install default desktop items
local ff = ls("/desktop")
if (not ff or #ff == 0) then
	mkdir ("/desktop") -- just in case
	store("/desktop/drive.loc", fetch("/system/misc/drive.loc"))
	store("/desktop/readme.txt", fetch("/system/misc/readme.txt"))
--	cp("/system/misc/drive.loc", "/desktop/drive.loc")
--	cp("/system/misc/readme.txt", "/desktop/readme.txt")
end

-- mend drive shortcut (could save over it by accident in 0.1.0b)
local dd = fetch("/desktop/drive.loc")
if (dd and not dd.location) then
	store("/desktop/drive.loc", fetch("/system/misc/drive.loc"))
	notify("mended: /desktop/drive.loc")
end

-- present working cartridge
local num = 0
local num=0
while (fstat("/untitled"..num..".p64") and num < 64) num += 1
store("/ram/system/pwc.pod", "/untitled"..num..".p64")
mount("/system/util/dir.lua","/system/util/ls.lua")   
mount("/system/util/edit.lua","/system/util/open.lua") 
local runtime_version, system_version = stat(5)
local system_meta = fetch_metadata("/system") or {}
--if (system_meta.version ~= system_version) then
--	printh("** version mismatch // /system: "..system_meta.version.." expects binaries: "..system_version)
--	send_message(3, {event="report_error", content = "** system version mismatch **"})
--	send_message(3, {event="report_error", content = "/system version is: "..system_meta.version})
--	send_message(3, {event="report_error", content = "this build expects: "..system_version})
--end


-- starting userland programs (with blank untitled files)

-- open editors and create default cart layout
mkdir "/ram/cart/gfx"
mkdir "/ram/cart/map"
mkdir "/ram/cart/sfx"

-- default file name are used by the automatic resource loader
-- (in many cases only these 4 files are needed in a cartridge)
create_process("/system/terminal.lua", 
{
    window_attribs = {fullscreen = true, pwc_output = true, immortal = true},
    immortal   = true -- exit() is a NOP; separate from window attribute :/
}
)
printh("maybe here")