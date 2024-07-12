--[[pod_format="raw",created="2024-06-11 16:02:59",modified="2024-06-11 16:05:09",revision=1]]
--[[
	Pico-DOS Kernel
]]


-- need to fetch early to determine fullscreen or windowed
local sdat = fetch"/appdata/system/settings.pod" or  {}
_apply_system_settings(sdat)
local head_func, err = load(fetch("/system/lib/head.lua"))
if (not head_func) io.write ("** could not load head ** "..err)
head_func()


-- user can extend this with /appdata/system/startup.lua (is daisy-chained)

local startup_src  = fetch("/system/startup.lua")

if (type(startup_src) ~= "string") then
	printh("** could not read startup.lua")
else
	local startup_func = load(startup_src)
	if (type(startup_func) ~= "function") then
		printh("** could not load startup.lua")
	else
		startup_func()
	end
end
