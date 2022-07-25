local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local naughty = require "naughty"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

----- Taglist

-- Skeleton
local tag_bar = wibox {
	visible = true,
	ontop = false,
	width = dpi(4),
	height = awful.screen.focused().geometry.height,
	type = 'dock'
}

awful.placement.right(tag_bar)

-- Var
local colors = {
	beautiful.pink,
	beautiful.red,
	beautiful.yellow,
	beautiful.green,
	beautiful.blue
}

local update_tag = function(item, tag, index)
	if tag.selected then
		item.bg = colors[index]
	elseif tag.urgent then
		item.bg = colors[index]
	elseif #tag:clients() > 0 then
		item.bg = colors[index] .. "dd"
	else
		item.bg = beautiful.bar
	end
end

local tag_button = awful.button({ }, 1, function(t) t:view_only() end)

local tag = awful.widget.taglist {
	screen = awful.screen.focused(),
	filter = awful.widget.taglist.filter.all,
	buttons = tag_button,
	layout = {
		spacing = dpi(0),
		layout = wibox.layout.flex.vertical,
	},
	widget_template = {
		widget = wibox.container.background,
		create_callback = function(self, tag, index, _)
			update_tag(self, tag, index)
		end,
		update_callback = function(self, tag, index, _)
			update_tag(self, tag, index)
		end
	}
}

tag_bar : setup {
	widget = tag
}
