local awful = require "awful"
local gears = require "gears"

local old_net_ssid = "Reconnect"
local old_net_stat = false

local check_wifi = function()
	local script = [[
        nmcli -t connection show --active
        ]]

	awful.spawn.easy_async_with_shell(
		script,
		function(stdout)
			local net_ssid = stdout
			local net_stat = true
			
			if net_ssid == "" then
                                net_stat = false
                                net_ssid = "Not Connected"
                        end

			if net_ssid ~= old_net_ssid then -- Emit signal if there was a change 
				awesome.emit_signal("signal::wifi", net_stat, net_ssid)
				old_net_ssid = net_ssid
				old_net_stat = net_stat
			end
		end
	)
end

check_wifi()

gears.timer {
	timeout = 3,
	autostart = true,
	call_now = true,
	callback = function()
		check_wifi()
	end,
}
