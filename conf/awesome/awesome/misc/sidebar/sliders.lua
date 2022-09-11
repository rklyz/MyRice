local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Create volume slider
local volume_icon = wibox.widget.textbox()
volume_icon.font = "Roboto Medium 16"
volume_icon.align = 'center'
volume_icon.markup = "󰕾"

local volume_slider = wibox.widget {
	forced_width = dpi(220),
	forced_height = dpi(30),
	bar_shape = gears.shape.rounded_bar,
	bar_height = dpi(14),
	bar_color = beautiful.bg_alt,
	bar_active_color = beautiful.blue,
	handle_shape = gears.shape.circle,
	handle_color = beautiful.blue,
	handle_width = dpi(20),
	widget = wibox.widget.slider
}

local volume = wibox.widget {
	nil,
	{
		volume_icon,
		volume_slider,
		spacing = dpi(20),
		layout = wibox.layout.fixed.horizontal,
	},
	expand = "none",
	layout = wibox.layout.align.vertical,
}

local update_volume = function() 
	awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout) 
		volume_slider.value = tonumber(stdout:match("%d+"))
	end)
end

volume_slider:connect_signal("property::value", function(_, vol) 
	awful.spawn("pamixer --set-volume ".. vol, false)
end)

-- Create brightness slider
local bright_icon = wibox.widget.textbox()
bright_icon.font = "Roboto Medium 16"
bright_icon.align = 'center'
bright_icon.markup = "󰃟"

local bright_slider = wibox.widget {
        forced_width = dpi(220),
        forced_height = dpi(30),
        bar_shape = gears.shape.rounded_bar,
        bar_height = dpi(14),
        bar_color = beautiful.bg_alt,
        bar_active_color = beautiful.yellow,
        handle_shape = gears.shape.circle,
        handle_color = beautiful.yellow,
        handle_width = dpi(20),
        widget = wibox.widget.slider
}

bright_slider:connect_signal("property::value", function(_, bri) 
	awful.spawn("brightnessctl set "..bri.."%", false)
end)

local update_brightness = function()
        awful.spawn.easy_async_with_shell("brightnessctl g", function(stdout)
		val = tonumber(stdout)
		awful.spawn.easy_async_with_shell("brightnessctl max", function(stdout)
			bri = val/tonumber(stdout) * 100
			bright_slider.value = bri
		end)
        end)
end

local brightness = wibox.widget {
        nil,
        {
                bright_icon,
                bright_slider,
                spacing = dpi(20),
                layout = wibox.layout.fixed.horizontal,
        },
        expand = "none",
        layout = wibox.layout.align.vertical,
}

gears.timer {
	timeout = 10,
	autostart = true,
	call_now = true,
	callback = function() 
		update_volume()
		update_brightness()
	end
}

local all_slider = wibox.widget {
	volume,
	brightness,
	spacing = dpi(20),
	layout = wibox.layout.fixed.vertical,
}

return all_slider
