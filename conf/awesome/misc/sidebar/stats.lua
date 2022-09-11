local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Helper
-----------

local function round_widget(radius)
      	return function(cr,w,h)
       	 	gears.shape.rounded_rect(cr,w,h,radius)
       end
end

local function grouping_widget(w1,w2)
	local container = wibox.widget {
		w1,
		{
			nil,
			w2,
			expand = 'none',
			layout = wibox.layout.align.vertical,
		},
		spacing = dpi(18),
		layout = wibox.layout.fixed.horizontal,
	}

	return container
end

local function center_widget(widget)
	return wibox.widget {
		nil,
		{
			nil,
			widget,
			expand = 'none',
			layout = wibox.layout.align.horizontal,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	}
end

-- Create_widgets 
-------------------

-- Disk
local d_icon = wibox.widget.textbox()
d_icon.font = "Roboto Medium 20"
d_icon.align = "left"
d_icon.markup = "󱂵"

local d_slider = wibox.widget {
	forced_width = dpi(220),
	forced_height = dpi(10),
	color = beautiful.red,
	background_color = "#663D3D",
	shape = round_widget(12),
	bar_shape = round_widget(12),
	max_value = 100,
	value = 20,
	widget = wibox.widget.progressbar,
}

local disk = grouping_widget(d_icon, d_slider)

-- Vol
local v_icon = wibox.widget.textbox()
v_icon.font = "Roboto Medium 20"
v_icon.align = "left"
v_icon.markup = "󰕾"

local v_slider = wibox.widget {
        forced_width = dpi(220),
        forced_height = dpi(10),
	color = beautiful.blue,
        background_color = "#3D4B66",
        shape = round_widget(12),
        bar_shape = round_widget(12),
	max_value = 100,
        widget = wibox.widget.progressbar,
}

local volume = grouping_widget(v_icon, v_slider)

-- Brightness
local b_icon = wibox.widget.textbox()
b_icon.font = "Roboto Medium 20"
b_icon.align = "left"
b_icon.markup = "󰃟"

local b_slider = wibox.widget {
        forced_width = dpi(220),
        forced_height = dpi(10),
        color = beautiful.yellow,
        background_color = "#66523D",
        shape = round_widget(12),
        bar_shape = round_widget(12),
	max_value = 100,
        widget = wibox.widget.progressbar,
}

local brightness = grouping_widget(b_icon, b_slider)

-- Getting Value for These Widgets
------------------------------------

local function get_val()
	awesome.connect_signal("signal::volume", function(vol, muted)
		if muted then v_slider.value = 0 else
			v_slider.color = beautiful.blue
			v_slider.value = tonumber(vol)
		end
	end)

	awesome.connect_signal("signal::brightness", function(bri)
		b_slider.value = tonumber(bri)
	end)

	awesome.connect_signal("signal::disk", function(disk_perc)
		d_slider.value = tonumber(disk_perc)
	end)
end

get_val()

return center_widget(wibox.widget {
	disk,
	volume,
	brightness,
	spacing = dpi(18),
	layout = wibox.layout.fixed.vertical,
})
