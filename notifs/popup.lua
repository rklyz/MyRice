local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi


----- Var -----

local width = dpi(175)
local height = dpi(150)

----- Set up awful.popup -----

--- The skeleton of the popup ---

local volumePop = awful.popup {
	widget = wibox.container.margin,
	border_color = beautiful.bar_alt,
    	border_width = 5,
	placement = function(c)
		awful.placement.centered(c, {margins ={top = 400}})
	end,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,20) end,
	visible = false,
	ontop = true,
}

--- Icon ---

local icon = wibox.widget {
	{
		markup = "",
		font = "JetBrainsMono NF 60",
		widget = wibox.widget.textbox,
	},
	halign = "center",
	widget = wibox.container.place,
}

--- ProgressBar/Volume's Bar ---

local volbar = wibox.widget {
	value = 0,
	max_value = 100,
	color = beautiful.blue,
	background_color = beautiful.bar_alt,
	bar_shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,20) end,
	shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,20) end,
	forced_width = dpi(120),
	forced_height = dpi(10),
	widget = wibox.widget.progressbar,
}

--- Put all widget into the popup ---

volumePop.widget = wibox.widget {
	{
		{
			{
				icon,
				volbar,
				spacing = 5,
				layout = wibox.layout.fixed.vertical,
			},
			valign = 'center',
			widget = wibox.container.place,
		},
		margins = 0,
		widget = wibox.container.margin,
	},
	forced_width = width,
	forced_height = height,
	bg = beautiful.bar,
	widget = wibox.container.background,
}

--- Popup's timeout ---

local pop_timeout = gears.timer({
	timeout = 2,
	autostart = true,
	callback = function()
		volumePop.visible = false
	end,
})

----- When receive signal, -----
----- do ...		   -----

local first_time = true
awesome.connect_signal("signal::volume", function(vol, muted)

  if first_time then
	first_time = false
  else
	volbar.value = vol
	volbar.color = beautiful.blue
	if muted or vol == 0 then
		icon.widget.markup = "<span foreground='" .. beautiful.blue .. "'><b></b></span>"
		volbar.color = beautiful.bar
		volbar.background_color = beautiful.bar
	else
		icon.widget.markup = "<span foreground='" .. beautiful.blue .. "'><b></b></span>"
	end


	if volumePop.visible then   --- If receive signal when it's visible...
		pop_timeout:again()
	else			    --- If receive signal when it's not visible...
		volumePop.visible = true
		pop_timeout:start()
	end
  end
end)

----- For brightness -----

awesome.connect_signal("signal::brightness", function(value)
		volbar.max_value = 40
		volbar.value = value
		volbar.color = beautiful.yellow
		icon.widget.markup = "<span foreground='" .. beautiful.yellow .. "'><b></b></span>"

		if volumePop.visible then
			pop_timeout:again()
		else
			volumePop.visible = true
			pop_timeout:start()
		end
end)
