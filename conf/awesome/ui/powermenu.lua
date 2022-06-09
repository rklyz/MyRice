local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

----- Var -----

local width = dpi(200)
local height = dpi(600)

----- Widgets -----

-- Buttons function (I'm too lazy to write it many times)

local createButtons = function(icon, text, command)

	local widget = wibox.widget {
		{
			{
				{
					{
						markup = icon,
						align = 'center',
						font = "icomoon 30",
						widget = wibox.widget.textbox,
					},
					{
						markup = text,
						align = 'center',
						font = beautiful.font_name .. " 14",
						widget = wibox.widget.textbox,
					},
					spacing = dpi(10),
					layout = wibox.layout.fixed.vertical,
				},
				halign = 'center',
				valign = 'center',
				widget = wibox.container.place,
			},
			margins = dpi(20),
			widget = wibox.container.margin,
		},
		shape = function(cr,w,h) gears.shape.squircle(cr,w,h,5) end,
		bg = beautiful.bar,
		widget = wibox.container.background,
	}

	-- Hover

	widget:connect_signal("mouse::enter", function()
		if widget.bg ~= beautiful.bar_alt then
			widget.backup = widget.bg
			widget.has_backup = true
		end
		widget.bg = beautiful.bar_alt
	end)

	widget:connect_signal("mouse::leave", function()
		if widget.has_backup then
			widget.bg = widget.backup
		end
	end)

	-- Keybindings

	widget:buttons(gears.table.join(
		awful.button( { }, 1, function()
			awful.spawn(command)
		end)))

	return widget
end

local p = function(s)

	s.powermenu = wibox {
		ontop = true,
		visible = false,
		type = 'splash',
		bg = "#05091199",
		height = s.geometry.height,
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y,
		widget = wibox.container.margin,
	}

	awful.placement.centered(s.powermenu)
	
	s.powermenu:buttons(gears.table.join(
			awful.button(
				{}, 2, function()
					awesome.emit_signal('ui::powermenu:hide')
				end),
	
			awful.button(
				{}, 3, function()
					awesome.emit_signal('ui::powermenu:hide')
				end
			),
	
			awful.button(
				{}, 1, function()
					awesome.emit_signal('ui::powermenu:hide')
				end
			)
		)
	)
	
	
	s.powermenu:setup {
		nil,
		nil,
		{
			nil,
			{
					{
					{
						createButtons("", "PowerOff", "poweroff"),
						createButtons("", "Reboot", "reboot"),
						createButtons("", "Sleep", "systemctl suspend"),
						createButtons("", "Lock", "i3lock"),
						spacing = dpi(20),
						layout = wibox.layout.flex.vertical,
					},
					margins = dpi(35),
					widget = wibox.container.margin,
				},
				forced_width = width,
				forced_height = height,
				shape = function(cr,w,h) gears.shape.partially_rounded_rect(cr,w,h,true,false,false,true,15) end,
				bg = beautiful.bar,
				widget = wibox.container.background,
			},
			nil,
			layout = wibox.layout.align.vertical,
			expand = "none",
		},
		layout = wibox.layout.align.horizontal,
		expand = "none",
	}
end

-- Grabber/ kinda like lock or something

local p_grabber = awful.keygrabber {
	auto_start = true,
	stop_event = 'release',
	keypressed_callback = function (self, mod, key, command)
		if key == "Escape" then
			awesome.emit_signal("ui::powermenu:hide")
		end
	end
}

screen.connect_signal('request::desktop_decoration',
	function(s)
		p(s)
	end
)

screen.connect_signal('removed',
	function(s)
		p(s)
	end
)

-- Connect to signal
-- From "awesome/conf/keybind"

awesome.connect_signal("ui::powermenu:open", function()
	for s in screen do
		s.powermenu.visible = false
	end
	awful.screen.focused().powermenu.visible = true
	p_grabber:start()
end)

awesome.connect_signal("ui::powermenu:hide", function()
	p_grabber:stop()
	for s in screen do
		s.powermenu.visible = false
	end
end)
