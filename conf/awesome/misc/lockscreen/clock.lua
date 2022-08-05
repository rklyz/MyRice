local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Create clock
local clock = wibox.widget.textbox()
clock.font = "Roboto Mono bold 26"
clock.align = 'center'

local date = wibox.widget.textbox()
date.font = "Roboto Mono 18"
date.align = 'center'

local icon = wibox.widget.textbox()
icon.font = "Roboto Medium 52"
icon.align = 'center'
icon.markup = "<span foreground='"..beautiful.white.."'>󰥔</span>"

local function update_time()
	clock.markup = "<span foreground='"..beautiful.white.."'>"..os.date("%H:%M").."</span>"
	date.markup = "<span foreground='"..beautiful.white.."'>"..os.date("%d %b %Y").."</span>"
end

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function() update_time() end
}

return wibox.widget {
	nil,
	{
		icon,
		{
			clock,
			date,
			layout = wibox.layout.fixed.vertical,
		},
		spacing = 12,
		layout = wibox.layout.fixed.horizontal,
	},
	expand = "none",
	layout = wibox.layout.align.vertical,
}
