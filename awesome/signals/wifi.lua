local awful = require "awful"
local gears = require "gears"

local emit_wifi = function()

	local script = [[
	nmcli -t connection show --active
	]]

	awful.spawn.easy_async_with_shell(
		script,
		function(stdout)
			local net_ssid = stdout--:match(".[^:]+")
			local net_stat = true

			if net_ssid == "" then 
				net_stat = false
				net_ssid = "Not Connected"
			end
			awesome.emit_signal("signal::wifi", net_stat, net_ssid)
		end
	)
end

emit_wifi()

gears.timer {
	timeout = 3,
	autostart = true,
	call_now = true,
	callback = function()
		emit_wifi()
	end,
}
