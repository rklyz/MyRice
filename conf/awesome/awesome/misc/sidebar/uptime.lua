local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Icon
local icon = wibox.widget.textbox()
icon.font = "Roboto Medium 24"
icon.align = 'center'
icon.markup = "<span foreground='"..beautiful.yellow.."'>󰍹</span>"

-- Uptime
local uptime = wibox.widget.textbox()
uptime.font = "Roboto Medium 16"
uptime.align = 'center'

local function get_uptime() 
	local script = [[
	uptime -p
	]]

	awful.spawn.easy_async_with_shell(script, function(stdout) 
		stdout = string.gsub(stdout, "\n", "")
		uptime.markup = stdout
	end)
end

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		get_uptime()
	end
}

return wibox.widget {
	icon,
	uptime,
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}
