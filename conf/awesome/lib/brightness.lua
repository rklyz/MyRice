local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local brightness = {}

-- Popup
----------

brightness.popup = wibox {
	visible = false,
	ontop = true,
	width = dpi(300),
	height = dpi(70),
	bg = beautiful.transparent
}

awful.placement.bottom(brightness.popup, { margins = {bottom = dpi(100)}})

-- Popup Widget
-----------------

local indicator = wibox.widget {
	background_color = beautiful.bg,
	color = beautiful.yellow,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,8) end,
	max_value = 100,
	widget = wibox.widget.progressbar,
}

brightness.popup : setup {
	indicator,
	{
		{
			font = "Roboto 24",
			align = "left",
			markup = "<span foreground='"..beautiful.fg.."'>🌣</span>",
			widget = wibox.widget.textbox,
		},
		margins = {left = dpi(20), top = dpi(8)},
    widget = wibox.container.margin,
	},
	layout = wibox.layout.stack,
}

brightness.lifespan = gears.timer {
	timeout = 1,
	call_now = false,
	autostart = false,
	single_shot = true,
	callback = function() 
		brightness.popup.visible = false
	end
}

-- Get Brightness
function brightness.get_brightness()
       	script = "brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}'"
       	awful.spawn.easy_async_with_shell(script, function(brightness)
        indicator.color = beautiful.yellow
          if brightness ~= nil then
            brightness = tonumber(brightness)
            indicator.value = tonumber(brightness)
          end
       end)
end

function brightness.changed()
	brightness.popup.visible = true
	if not brightness.popup.visible then brightness.lifespan:start() else
		brightness.lifespan:again()
	end
end

-- Control Room
-----------------

brightness.increase = function()
	local script = [[
	brightnessctl set 3%+
	]]

	awful.spawn.with_shell(script)
  brightness.get_brightness()
  brightness.changed()
end

brightness.decrease = function()
	local script = [[
	brightnessctl set 3%-
	]]

	awful.spawn.with_shell(script)
  brightness.get_brightness()
  brightness.changed()
end

return brightness
