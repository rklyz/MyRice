local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Wifi
local wifi = wibox.widget.textbox()
wifi.font = "Roboto Medium 16"

local function get_wifi()
	local script = [[
	nmcli -g CONNECTIVITY g
	]]

	awful.spawn.easy_async_with_shell(script, function(stdout)
		local status = tostring(stdout)
		if not status:match("none") then
			local get_strength = [[
			awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
			]]

			awful.spawn.easy_async_with_shell(get_strength, function(stdout)
				local strength = tonumber(stdout)
				if strength < 20 then
					wifi.markup = "<span foreground='"..beautiful.green.."'>󰤯</span>"
				elseif strength < 40 then
					wifi.markup = "<span foreground='"..beautiful.green.."'>󰤟</span>"
				elseif strength < 60 then
					wifi.markup = "<span foreground='"..beautiful.green.."'>󰤢</span>"
				elseif strength < 80 then
					wifi.markup = "<span foreground='"..beautiful.green.."'>󰤥</span>"
				else
					wifi.markup = "<span foreground='"..beautiful.green.."'>󰤨</span>"
				end
			end)
		else
			wifi.markup = "<span foreground='"..beautiful.red.."'>󰤭</span>"
		end
	end)
end

gears.timer {
	timeout = 5,
	autostart = true,
	call_now = true,
	callback = function() get_wifi() end
}

return wifi
