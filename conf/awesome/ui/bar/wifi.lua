local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local supporter = require "supporter"

-- wifi
local wifi = wibox.widget.textbox()
wifi.font = "Roboto Medium 16"

local get_wifi = function()
	local get_status = [[
	nmcli g | tail -1 | awk '{printf $1}'
	]]
	awful.spawn.easy_async_with_shell(get_status, function(stdout)
		local status = tostring(stdout)
		if not status:match("disconnected") then
			local get_strength = [[
			awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
			]]

			awful.spawn.easy_async_with_shell(get_strength, function(stdout)
				if not tonumber(stdout) then
					return
				else
					local strength = tonumber(stdout)
					if strength < 20 then
						wifi.markup = "󰤯"
					elseif strength < 40 then
						wifi.markup = "󰤟"
					elseif strength < 60 then
						wifi.markup = "󰤢"
					elseif strength < 80 then
						wifi.markup = "󰤥"
					else
						wifi.markup = "󰤨"
					end
				end
			end)
		else
			wifi.markup = "󰤭"
		end
	end)
end

gears.timer {
	timeout = 5,
	call_now = true,
	autostart = true,
	callback = function() get_wifi() end,
}

return wifi
