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
	local icon_visibility

	if n.icon == nil then 
		icon_visibility = false
	else
		icon_visibility = true
	end

	-- Action widget
	local action_widget = {
		{
			{
				id = "text_role",
				align = "center",
				font = "Roboto Mono 10",
				widget = wibox.widget.textbox,
			},
			margins = {left = dpi(6), right = dpi(6)},
			widget = wibox.container.margin,
		},
		widget = wibox.container.background,
	}

	-- Apply action widget ^
	local actions = wibox.widget {
		notification = n,
		base_layout = wibox.widget {
			spacing = dpi(8),
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = action_widget,
		widget = naughty.list.actions,
	}

	local function space_h(length)
		return wibox.widget {
			forced_width = length,
			layout = wibox.layout.fixed.horizontal,
		}
	end

	-- Make other widgets
	local title = wibox.widget.textbox()
	title.font = "Roboto bold 14"
	title.align = 'center'
	title.markup = n.title

	local message = wibox.widget.textbox()
	message.font = "Roboto Mono 12"
	message.align = 'center'
	message.markup = n.message

	local icon = wibox.widget {
		nil,
		{
			{
				image = n.icon,
				visible = icon_visibility,
				widget = wibox.widget.imagebox,
			},
			strategy = "max",
			width = dpi(60),
			height = dpi(60),
			widget = wibox.container.constraint,
		},
		expand = 'none',
		layout = wibox.layout.align.vertical,
	}

	local container = wibox.widget {
		{
			title,
			{
				icon,
				space_h(dpi(10)),
				message,
				layout = wibox.layout.fixed.horizontal,
			},
			actions,
			spacing = dpi(10),
			layout = wibox.layout.fixed.vertical,
		},
		margins = dpi(20),
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
					{
						widget = container,
					},
					strategy = "max",
					width = dpi(620),
					widget = wibox.container.constraint,
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

