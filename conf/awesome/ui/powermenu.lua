local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local coloring = function(text, color)
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end


----- Logoooout -----

local logout = wibox {
	visible = false,
	ontop = true,
	bg = beautiful.bar .. "AA",
	type = 'dock',
}

awful.placement.maximize(logout)

local keylock = awful.keygrabber {
	autostart = false,
	stop_event = 'release',
	keypressed_callback = function(self, mod, key, command)
		if key == "Escape" then
			awesome.emit_signal("logout::toggle")
		end
	end
}

local toggle = function()
	if logout.visible then
		keylock:stop()
	else
		keylock:start()
	end
	logout.visible = not logout.visible
end

logout:buttons(gears.table.join(
	awful.button({ }, 1, function()
		toggle()
	end)
))

awesome.connect_signal("logout::toggle", function()
	toggle()
end)

----- Var -----

-- Greeting
local greeting = wibox.widget.textbox()

greeting.font = "azukifontBI Italic 42"
greeting.align = 'center'
greeting.markup = "Rest well, " .. string.gsub(os.getenv('USER'), "^%l", string.upper)

-- Time
local time = wibox.widget.textbox()
local date = wibox.widget.textbox()

time.font = beautiful.font_name .. " Bold 142"
date.font = beautiful.font_name .. " 32"
time.align = "center"
date.align = "center"

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		time_var = os.date("%R")
		date_var = os.date("%d %B, %Y")
		time.markup = "<span>" .. time_var .. "</span>"
		date.markup = "<span>" .. date_var .. "</span>"
	end
}

local clock = wibox.widget {
	time,
	layout = wibox.layout.fixed.vertical,
}

local left = wibox.widget {
	{
		nil,
		{
			clock,
			spacing = dpi(40),
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	margins = {left = dpi(50)},
	widget = wibox.container.margin,
}

local middle = wibox.widget {
	nil,
	{
		nil,
		{
			clock,
			greeting,
			spacing = dpi(5),
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

-- Powermenu
local create_button = function(text, desc, color, command)
	local text_var = wibox.widget.textbox()
	local desc_var = wibox.widget.textbox()
	
	text_var.font = beautiful.font_name .. " 38"
	desc_var.font = beautiful.font_name .. " 12"

	text_var.align = "center"
	desc_var.align = "center"

	text_var.markup = coloring(text, color)
	desc_var.markup = desc

	local widget = wibox.widget {
		text_var,
		desc_var,
		spacing = dpi(10),
		layout = wibox.layout.fixed.vertical,
	}

	widget:buttons(gears.table.join(
		awful.button({ }, 1, function()
			awful.spawn.with_shell(command)
		end)
	))

	return widget
end

local poweroff = create_button("󰐥", "PowerOff", beautiful.red, "poweroff")
local reboot = create_button("󰜉", "Reboot", beautiful.yellow, "reboot")
local sleeping = create_button("󰤄", "Sleep", beautiful.blue, "systemctl suspend")
local logging_out = create_button("󰌾", "Logout", beautiful.green, "pkill awesome")

local right = wibox.widget {
	{
		nil,
		{
			poweroff,
			reboot,
			sleeping,
			logging_out,
			spacing = dpi(40),
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	margins = {right = dpi(40)},
	widget = wibox.container.margin,
}

logout:setup {
	nil,
	middle,
	right,
	layout = wibox.layout.align.horizontal,
}
