--[[pod_format="raw",created="2024-06-11 16:02:59",modified="2024-06-11 16:05:09",revision=1]]
--[[
	Pico-DOS Kernel
]]


-- need to fetch early to determine fullscreen or windowed
local sdat = fetch"/appdata/system/settings.pod" or  {}
-- allowed to assume / and /ram is mounted before boot.lua is run
-- and that there is already /system

cp("/system/misc/ram_info.pod", "/ram/.info.pod")

mkdir("/ram/cart")
mkdir("/ram/system") -- system state (userland)
mkdir("/ram/shared") -- system state visible to sandboxed carts
mkdir("/ram/drop")   -- host files dropped into picotron -- can just leave them kicking around until reboot
mkdir("/ram/log")    -- logs for this session -- to do

mkdir("/desktop")
mkdir("/apps")       -- later; could be optional!

mkdir("/appdata")
mkdir("/appdata/system")
mkdir("/appdata/system/desktop2") -- for the tooltray

mkdir("/ram/dev") -- experimental; devices are an extraneous concept if have messages and ram file publishing

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
        printh("** startup func tiiime")
		startup_func()
	end
end
