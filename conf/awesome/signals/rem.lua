local awful = require "awful"
local gears = require "gears"

-- Rem function
-- I like rem more than ram

local check_rem = function()
	
	local script = [[
	free -m | grep Mem | awk '{print ($3/$2)*100}'
	]]

	awful.spawn.easy_async_with_shell(script, 
		function(stdout)
			local rem = stdout:match("(.+)[.]")
			rem = tonumber(rem)
			awesome.emit_signal("signal::rem", rem)
		end
	)
end

gears.timer {
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function()
		check_rem()
	end
}
