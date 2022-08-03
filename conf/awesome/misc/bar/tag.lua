local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local naughty = require "naughty"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

-- Colors
local colors = {
	beautiful.magenta,
	beautiful.red,
	beautiful.yellow,
	beautiful.green,
	beautiful.blue
}

local function update_tag(item, tag, index)
	if tag.selected then
		item.bg = colors[index]
	elseif #tag:clients() > 0 then
		item.bg = colors[index].."80"
	else
		item.bg = beautiful.bg
	end
end

local button = awful.button({ }, 1, function(t) t:view_only() end)

return function(s)

	local tag = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.all,
		layout = {
			layout = wibox.layout.flex.vertical,
		},
		buttons = button,
		widget_template = {
			widget = wibox.container.background,

			create_callback = function(self, c3, index, objects)
				update_tag(self, c3, index)
			end,

			update_callback = function(self, c3, index, objects)
				update_tag(self, c3, index)
			end
		}
	}

	local tagbar = wibox {
		visible = true,
		ontop = false,
		width = dpi(4),
		height = s.geometry.height,
		type = 'dock'
	}

	awful.placement.right(tagbar)

	tagbar : setup {
		widget = tag
	}
end
