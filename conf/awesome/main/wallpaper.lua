local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"

local use_feh = true -- True/False

local function set_wall(s)
	awful.wallpaper {
		screen = s,
		widget = {
			{
				image = beautiful.wallpaper,
				upscale = true,
				downscale = true,
				widget = wibox.widget.imagebox,
			},
			valign = "center",
			halign = "center",
			tiled = false,
			widget = wibox.container.tile,
		}
	}
end

screen.connect_signal("request::wallpaper", function(s)
	if not use_feh then
		set_wall(s)
	else
		awful.spawn("feh --bg-fill "..beautiful.wallpaper, false)
	end
end)
