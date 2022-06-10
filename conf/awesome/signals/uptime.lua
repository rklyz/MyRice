local awful = require "awful"
local gears = require "gears"

local uptime = function()
	local script = [[
	uptime | awk '{print $3}' | cut -d "," -f 1
	]]
	
	awful.spawn.easy_async_with_shell(script,
		function(stdout)
			local h = stdout:match("(.+)[:]")
			local m = stdout:match(".+[:](.+).")
			local hour = h .. " Hours"
			local min = m .. " Minutes"
			
			awesome.emit_signal("signal::uptime", hour, min)
		end
	)
end

gears.timer {
	timeout = 10,
	autostart = true,
	call_now = true,
	callback = function()
		uptime()
	end
}
