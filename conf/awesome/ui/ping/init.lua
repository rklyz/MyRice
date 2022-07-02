local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local ruled = require "ruled"
local menubar = require "menubar"
local beautiful = require "beautiful"
local naughty = require "naughty"

local dpi = beautiful.xresources.apply_dpi

naughty.connect_signal("request::icon", function(n, context, hints)
    if context ~= "app_icon" then return end

    local path = menubar.utils.lookup_icon(hints.app_icon) or
        menubar.utils.lookup_icon(hints.app_icon:lower())

    if path then
        n.icon = path
    end
end)

naughty.config.defaults.ontop = true
naughty.config.defaults.position = "top_right"
naughty.config.defaults.title = "System"
naughty.config.defaults.timeout = 3

naughty.config.presets.low.timeout      = 3
naughty.config.presets.critical.timeout = 0

-- naughty normal preset
naughty.config.presets.normal = {
    font    = beautiful.font,
    fg      = beautiful.fg_normal,
    bg      = beautiful.bar
}

-- naughty low preset
naughty.config.presets.low = {
    font = beautiful.font_name .. "10",
    fg = beautiful.fg_normal,
    bg = beautiful.bar
}

-- naughty critical preset
naughty.config.presets.critical = {
    font = beautiful.font_name .. "12",
    fg = beautiful.red,
    bg = beautiful.red,
    timeout = 0
}


-- apply preset
naughty.config.presets.ok   =   naughty.config.presets.normal
naughty.config.presets.info =   naughty.config.presets.normal
naughty.config.presets.warn =   naughty.config.presets.critical


-- ruled notification
ruled.notification.connect_signal("request::rules", function()
    ruled.notification.append_rule {
        rule = {},
        properties = {screen = awful.screen.preferred, implicit_timeout = 6}
    }
end)

naughty.connect_signal("request::display", function(n)
	local icon = n.icon
	if not icon then icon = beautiful.notif end
	local time = os.date("%H:%M")

	local action_widget = {
		{
			{
				id = "text_role",
				align = "center",
				valign = "center",
				font = beautiful.font_name .. "8",
				widget = wibox.widget.textbox
			},
			margins = { left = dpi(6), right = dpi(6) },
			widget = wibox.container.margin,
		},
		forced_width = dpi(25),
		forced_height = dpi(10),
		bg = beautiful.bar,
		shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h,dpi(5)) end,
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
			underline_selected = true,
		},
		widget = naughty.list.actions,
	}

	naughty.layout.box {
		notification = n,
		type = "notification",
		bg = "#00000000",
		border_width = dpi(0),
		widget_template = {
			{
				{
					--{
					--	{
					--		{
					--			{
					--				{
					--					markup = n.app_name,
					--					font = beautiful.font_name .. " 12",
					--					align = "center",
					--					widget = wibox.widget.textbox,
					--				},
					--				margins = {top = dpi(12), bottom = dpi(12), left = dpi(18), right = dpi(18)},
					--				widget = wibox.container.margin,
					--			},
					--			bg = beautiful.bar_alt,
					--			widget = wibox.container.background,
					--		},
					--		strategy = "min",
					--		height = dpi(30),
					--		widget = wibox.container.constraint,
					--	},
					--	strategy = "max",
					--	height = dpi(60),
					--	width = dpi(270),
					--	widget = wibox.container.constraint,
					--},
					{
						{
							{
								{
									image = icon,
									resize = true,
									halign = "center",
									valign = "center",
									widget = wibox.widget.imagebox,
								},
								strategy = "max",
								height = dpi(40),
								widget = wibox.container.constraint,
							},
							{
								{
									{
										markup = n.title,
										align = "center",
										valign = "center",
										widget = wibox.widget.textbox,
									},
									strategy = "max",
									height = dpi(20),
									widget = wibox.container.constraint,
								},
								{
									markup = n.message,
									font = beautiful.font_name .. " 12",
									align = "left",
									widget = wibox.widget.textbox,
								},
								spacing = dpi(6),
								layout = wibox.layout.fixed.vertical,
							},
							spacing = dpi(15),
							layout = wibox.layout.fixed.horizontal,
						},
						margins = dpi(20),
						widget = wibox.container.margin,
					},
					layout = wibox.layout.fixed.vertical,
				},
				strategy = "max",
				width = dpi(320),
				--height = dpi(120),
				widget = wibox.container.constraint,
			},
			shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, dpi(5)) end,
			border_width = dpi(0),
			bg = beautiful.bar,
			widget = wibox.container.background,
		}
	}
end)

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
