local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

----- Dashboard Setup -----

local description = "That quite random guy"

local box_gap = dpi(10)


local dashboard = wibox {
	visible = false,
	ontop = true,
	bg = beautiful.bar .. "AA",
	type = 'dock'
}

awful.placement.maximize(dashboard)

local keylock = awful.keygrabber {
	autostart = false,
	stop_event = 'release',
	keypressed_callback = function(self, mod, key, command)
		if key == "Escape" then
			awesome.emit_signal("dashboard::toggle")
		end
	end
}

local toggle = function()
	if dashboard.visible then
		keylock:stop()
	else
		keylock:start()
	end
	dashboard.visible = not dashboard.visible
end

dashboard:buttons(gears.table.join(
	awful.button({ }, 3, function()
		toggle()
	end)
))

awesome.connect_signal("dashboard::toggle", function()
	toggle()
end)

----- Function ------

-- Rounded Rectangle
local rr = function(cr,w,h)
	gears.shape.rounded_rect(cr,w,h,10)
end

-- Vertical padding
local v_pad = function(pad)
	local v_padding = wibox.layout.fixed.horizontal()
	v_padding.forced_height = dpi(pad)

	return v_padding
end

-- Coloring
local coloring_text = function(text, color)
	color = color or beautiful.fg_normal
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

-- Create box function
local crt_box = function(widget, width, height, bg)
	local container = wibox.container.background()
	container.bg = bg
	container.forced_width = width
	container.forced_height = height
	container.border_width = dpi(4)
	container.border_color = beautiful.bar_alt
	container.shape = rr

	local box_widget = wibox.widget {
		{
			{
				nil,
				{
					nil,
					widget,
					expand = 'none',
					layout = wibox.layout.align.horizontal,
				},
				expand = 'none',
				layout = wibox.layout.align.vertical,
			},
			widget = container,
		},
		margins = box_gap,
		widget = wibox.container.margin,
	}

	return box_widget
end

----- Var -----

-- Profile Widget
local pfp = wibox.widget {
	{
		image = beautiful.pfp,
		halign = 'center',
		widget = wibox.widget.imagebox,
	},
	forced_width = dpi(200),
	forced_height = dpi(200),
	shape = gears.shape.circle,
	widget = wibox.container.background,
}

local user_widget = wibox.widget.textbox()
local desc_widget = wibox.widget.textbox()

user_widget.font = beautiful.font_name .. " bold 38"
user_widget.align = 'center'
user_widget.markup = coloring_text(os.getenv('USER'), beautiful.red)

desc_widget.font = beautiful.font_name .. " 16"
desc_widget.align = 'center'
desc_widget.markup = description

local profile_widget = wibox.widget {
	{
		nil,
		{
			pfp,
			v_pad(20),
			user_widget,
			desc_widget,
			spacing = dpi(20),
			layout = wibox.layout.fixed.vertical,
		},
		expand = 'none',
		layout = wibox.layout.align.horizontal,
	},
	margins = dpi(12),
	widget = wibox.container.margin,
}

local profile = crt_box(profile_widget, 360, 460, beautiful.bar)

-- Clock Widget
local time = wibox.widget.textbox()
time.font = beautiful.font_name .. " bold 42"
time.align = 'center'

local date = wibox.widget.textbox()
date.font = beautiful.font_name .. " 16"
date.align = 'center'

local am = wibox.widget.textbox()
local pm = wibox.widget.textbox()
am.font = beautiful.font_name .. " bold 36"
pm.font = beautiful.font_name .. " bold 36"
am.align = 'center'
pm.align = 'center'
am.valign = 'center'
pm.valign = 'center'

local updt_ampm = function()
	tmp = os.date("%p")
	if tmp == "AM" then
		am.markup = coloring_text("AM", beautiful.yellow)
		pm.markup = coloring_text("PM", beautiful.empty)
	else
		am.markup = coloring_text("AM", beautiful.empty)
		pm.markup = coloring_text("PM", beautiful.blue)
	end
end

local ampm_widget = wibox.widget {
	nil,
	{
		am,
		pm,
		spacing = dpi(5),
		layout = wibox.layout.fixed.vertical,
	},
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		time.markup = coloring_text(os.date("%R"), beautiful.green)
		date.markup = coloring_text(os.date("%d %B, %Y"))
		updt_ampm()
	end
}

local clock_widget = wibox.widget {
	time,
	ampm_widget,
	spacing = dpi(24),
	layout = wibox.layout.fixed.horizontal,
}

local clock = crt_box(clock_widget, 360, 200, beautiful.bar)

-- Calendar
local styles = {}

styles.month = { 
	padding = dpi(20),
	bg_color = beautiful.transparent,
	fg_color = beautiful.blue,
	border_width = dpi(0)
}
styles.normal = { shape = rr }
styles.focus = { 
	fg_color = beautiful.yellow,
	bg_color = beautiful.transparent,
	markup = function(t) return '<b>' .. t .. '</b>' end 
}
styles.header = {
	fg_color = beautiful.red,
	markup = function(t) return '<span font_desc="' .. beautiful.font_name .. ' bold 20">' ..  t .. '</span>' end
}
styles.weekday = {
	bg_color = beautiful.transparent,
	fg_color = beautiful.blue,
	padding = dpi(3),
	markup   = function(t) return '<b>' .. t .. '</b>' end
}

local function decorate_cell(widget, flag, date)
    if flag=="monthheader" and not styles.monthheader then
        flag = "header"
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
    local weekday = tonumber(os.date("%w", os.time(d)))
    local default_bg = beautiful.transparent
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape        = props.shape,
        border_color = props.border_color or beautiful.bar_alt,
        border_width = props.border_width or 0,
        fg           = props.fg_color or "#999999",
        bg           = props.bg_color or default_bg,
        widget       = wibox.container.background
    }

    return ret
end

local calendar_widget = wibox.widget {
	date = os.date('*t'),
	font = beautiful.font_name .. " 16",
	spacing = dpi(10),
	fn_embed = decorate_cell,
	widget = wibox.widget.calendar.month
}

local calendar = crt_box(calendar_widget, 300, 400, beautiful.bar)

-- Uptime
local uptime_text = wibox.widget.textbox()
local uptime_icon = wibox.widget.textbox()
uptime_text.font = beautiful.font_name .. " 16"
uptime_text.align = 'center'
uptime_icon.font = beautiful.font_name .. " 42"
uptime_icon.align = 'center'
uptime_icon.markup = coloring_text("󰌢", beautiful.blue)

gears.timer {
	timeout = 60,
	autostart = true,
	call_now = true,
	callback = function()
		script = io.popen('uptime -p')
		upfor = tostring(script:read('*a'))
		upfor = string.gsub(upfor, '\n', '')
		uptime_text.markup = coloring_text(upfor)
	end
}

local uptime_widget = wibox.widget {
	uptime_icon,
	uptime_text,
	spacing = dpi(10),
	layout = wibox.layout.fixed.vertical,
}

local uptime = crt_box(uptime_widget, 400, 140, beautiful.bar)

-- Stats
local volume_icon = wibox.widget.textbox()
local bright_icon = wibox.widget.textbox()

volume_icon.font = beautiful.font_name .. " 42"
bright_icon.font = beautiful.font_name .. " 42"

volume_icon.markup = coloring_text("󰋋", beautiful.blue)
bright_icon.markup = coloring_text("󰃟", beautiful.yellow)

local volume_slider = wibox.widget {
	{
		id = 'slider',
		max_value = 100,
		color = beautiful.blue,
		background_color = beautiful.bar_alt,
		shape = gears.shape.rounded_bar,
		bar_shape = gears.shape.rounded_bar,
		widget = wibox.widget.progressbar,
	},
	forced_width = dpi(5),
	forced_height = dpi(150),
	direction = "east",
	widget = wibox.container.rotate,
}

local bright_slider = wibox.widget {
	{
		id = 'slider',
		max_value = 80,
		color = beautiful.yellow,
		background_color = beautiful.bar_alt,
		shape = gears.shape.rounded_bar,
		bar_shape = gears.shape.rounded_bar,
		widget = wibox.widget.progressbar,
	},
	forced_width = dpi(5),
	forced_height = dpi(150),
	direction = "east",
	widget = wibox.container.rotate,
}

local insert_value = function(widget, signal)
	awesome.connect_signal("signal::" .. signal, function(value,_)
		widget:get_children_by_id('slider')[1].value = value
	end)
end

insert_value(volume_slider, "volume")
insert_value(bright_slider, "brightness")

volume_slider:buttons(gears.table.join(
	awful.button({ }, 4, function()
		awful.spawn.with_shell("pamixer -i 2")
	end),
	awful.button({ }, 5, function()
		awful.spawn.with_shell("pamixer -d 2")
	end)
))

bright_slider:buttons(gears.table.join(
	awful.button({ }, 4, function()
		awful.spawn.with_shell("brightnessctl set +2%")
	end),
	awful.button({ }, 5, function()
		awful.spawn.with_shell("brightnessctl set 2%-")
	end)
))

local stats_widget = wibox.widget {
	{
		{
			volume_slider,
			margins = {left = dpi(20), right = dpi(20)},
			widget = wibox.container.margin,
		},
		volume_icon,
		spacing = dpi(10),
		layout = wibox.layout.fixed.vertical,
	},
	{
		{
			bright_slider,
			margins = {left = dpi(20), right = dpi(20)},
			widget = wibox.container.margin,
		},
		bright_icon,
		spacing = dpi(10),
		layout = wibox.layout.fixed.vertical,
	},
	spacing = dpi(20),
	layout = wibox.layout.fixed.horizontal,
}

local stats = crt_box(stats_widget, 200, 300, beautiful.bar)

-- Disk
local disk_text = wibox.widget.textbox()
disk_text.font = beautiful.font_name .. " 46"
disk_text.markup = coloring_text("󰋊", beautiful.bar_alt)
disk_text.align = 'center'
disk_text.valign = 'center'

local disk_bar = wibox.widget {
	{
		id = 'bar',
		color = beautiful.red,
		background_color = beautiful.bar,
		widget = wibox.widget.progressbar,
	},
	direction = 'east',
	widget = wibox.container.rotate,
}

local get_disk = function()
	script = [[
	df -kH -B 1MB /dev/sda2 | tail -1 | awk '{printf "%d|%d" ,$2, $3}'
	]]
	awful.spawn.easy_async_with_shell(script, function(stdout)
		local disk_total = stdout:match('(%d+)[|]')
		disk_total = disk_total / 1000
		local disk_available = stdout:match('%d+[|](%d+)')
		disk_available = disk_available / 1000

		awesome.emit_signal("signal::disk", disk_total, disk_available)
	end)
end

gears.timer {
	timeout = 60,
	call_now = true,
	autostart = true,
	callback = function()
		get_disk()
	end
}

awesome.connect_signal("signal::disk", function(disk_total, disk_available)
	disk_bar:get_children_by_id('bar')[1].value = disk_available
	disk_bar:get_children_by_id('bar')[1].max_value = disk_total
end)

local disk_widget = wibox.widget {
	disk_bar,
	{
		nil,
		disk_text,
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	layout = wibox.layout.stack,
}

local disk = crt_box(disk_widget, 100, 300, beautiful.bar)

-- Weather
local temperature = wibox.widget.textbox()
temperature.font = beautiful.font_name .. " bold 20"
temperature.align = 'center'

local how = wibox.widget.textbox() -- How's-the-weather widget
how.font = beautiful.font_name .. " 18"
how.align = 'center'

local weather_icon = wibox.widget.textbox()
weather_icon.font = beautiful.font_name .. " 72"
weather_icon.align = 'center'

awesome.connect_signal('signal::weather', function(temp, icon, what)
	temperature.markup = coloring_text(temp .. "󰔄", beautiful.yellow)
	how.markup = coloring_text(what, beautiful.fg_normal)
	weather_icon.markup = coloring_text(icon, beautiful.fg_normal)
end)

local weather_widget = wibox.widget {
	weather_icon,
	{
		temperature,
		{
			how,
			strategy = 'max',
			width = dpi(200),
			widget = wibox.container.constraint,
		},
		widget = wibox.layout.fixed.vertical,
	},
	spacing = dpi(10),
	layout = wibox.layout.fixed.horizontal,
}

local weather = crt_box(weather_widget, 300, 300, beautiful.bar)

dashboard : setup {
	nil,
	{
		nil,
		{
			{
				profile,
				uptime,
				layout = wibox.layout.fixed.vertical,
			},
			{
				clock,
				calendar,
				layout = wibox.layout.fixed.vertical,
			},
			{
				weather,
				{
					stats,
					disk,
					layout = wibox.layout.fixed.horizontal,
				},
				layout = wibox.layout.fixed.vertical,
			},
			spacing = dpi(10),
			layout = wibox.layout.fixed.horizontal,
		}, 
		expand = 'none',
		layout = wibox.layout.align.vertical,
	},
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}
