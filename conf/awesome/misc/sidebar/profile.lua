local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

-- Pfp
local pfp = wibox.widget.imagebox()
pfp.image = beautiful.pfp
pfp.clip_shape = gears.shape.circle
pfp.forced_width = dpi(300)
pfp.forced_height = dpi(300)

-- User
local user = wibox.widget.textbox()
user.font = "Roboto bold 32"
user.align = 'center'
user.markup = "<span foreground='"..beautiful.red.."'>"..beautiful.user.."</span>"

-- Hostname
local hostname = wibox.widget.textbox()
hostname.font = "Roboto bold 14"
hostname.align = 'center'

awful.spawn.easy_async_with_shell("echo $HOST", function(stdout)
	hostname.markup = "@"..tostring(stdout)
end)

-- Spacing vertically
local space = wibox.widget {
	forced_height = dpi(6),
	layout = wibox.layout.align.horizontal
}

return wibox.widget {
	{
		nil,
		pfp,
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	space,
	user,
	hostname,
	layout = wibox.layout.fixed.vertical,
}
