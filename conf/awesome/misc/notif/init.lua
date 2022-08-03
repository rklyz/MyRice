local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears" 
local beautiful = require "beautiful"
local ruled = require "ruled"
local naughty = require "naughty"
local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.ontop = true
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 5
naughty.config.defaults.title = "Notification"
naughty.config.defaults.position = "top_right"

local function create_notif(n) 
	local time = os.date "%H:%M"

	local action_widget = {
		{
			{
				id = "text_role",
				align = "center",
				font = "Roboto bold 10",
				widget = wibox.widget.textbox,
			},
			margins = {left = dpi(6), right = dpi(6)},
			widget = wibox.container.margin,
		},
		bg = beautiful.bg_alt,
		widget = wibox.container.background,
	}

	local actions = wibox.widget {
		notification = n,
		base_layout = wibox.widget {
			spacing = dpi(8),
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = action_widget,
		style = {
			underline_normal = false,
			underline_selected = false
		},
		widget = naughty.list.actions,
	}

	local head = wibox.widget {
		{
			{
				{
					markup = n.app_name,
					widget = wibox.widget.textbox,
				},
				{
					markup = time,
					align = 'right',
					widget = wibox.widget.textbox,
				},
				fill_space = true,
				spacing = dpi(20),
				layout = wibox.layout.fixed.horizontal,
			},
			margins = {left = dpi(10), right = dpi(10)},
			widget = wibox.container.margin,
		},
		forced_height = dpi(30),
		bg = beautiful.bg_alt,
		widget = wibox.container.background,
	}

	local body = wibox.widget {
		{
			{
				nil,
				{
					{
						image = n.icon,
						widget = wibox.widget.imagebox,
					},
					strategy = "max",
					width = dpi(60),
					height = dpi(60),
					widget = wibox.container.constraint,
				},
				expand = 'none',
				layout = wibox.layout.align.vertical,
			},
			{
				{
					{
						markup = n.title,
						align = 'center',
						widget = wibox.widget.textbox,
					},
					{
						markup = n.message,
						widget = wibox.widget.textbox,
					},
					spacing = dpi(4),
					layout = wibox.layout.fixed.vertical,
				},
				strategy = "max",
				width = dpi(220),
				widget = wibox.container.constraint,
			},
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal,
		},
		margins = dpi(10),
		widget = wibox.container.margin,
	}

	naughty.layout.box {
		notification = n,
		type = "notification",
		bg = beautiful.bg,
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
		widget_template = {
			{
				{
					head,
					body,
					{
						actions,
						margins = { left = dpi(10), right = dpi(10), bottom = dpi(10)},
						widget = wibox.container.margin,
					},
					spacing = dpi(0),
					layout = wibox.layout.fixed.vertical,
				},
				strategy = "min",
				width = dpi(160),
				height = dpi(80),
				widget = wibox.container.constraint,
			},
			bg = beautiful.bg,
			shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,5) end,
			widget = wibox.container.background,	
		}
	}
end

naughty.connect_signal("request::display", function(n) 
	create_notif(n)
end)

ruled.notification.connect_signal("request::rules", function() 
	ruled.notification.append_rule {
		rule = {},
		properties = {
			screen = awful.screen.focused(),
			implicit_timeout = 5,
		}
	}
end)

