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
		item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.fg.."'>◆</span>"
	elseif #tag:clients() > 0 then
		item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.fg.."'>◇</span>"
	else
		item:get_children_by_id("tag")[1].markup = "<span foreground='"..beautiful.bg_alt.."'>◇</span>"
	end
end

local button = awful.button({ }, 1, function(t) t:view_only() end)

return function(s)
	local tag = awful.widget.taglist {
		screen = s,
		filter  = awful.widget.taglist.filter.all,
		buttons = button,
		layout   = {
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal,
		},
		style = {
			spacing = dpi(10), --[[
			fg_focus = beautiful.red,
			fg_empty = beautiful.bg_alt,
			fg_occupied = beautiful.fg --]]
		},
		widget_template = {
			id = "tag",
			font = "Roboto Medium 14",
			widget = wibox.widget.textbox,

			create_callback = function(self, c3, index, object)
				update_tag(self, c3, index)
			end,

			update_callback = function(self, c3, index, object) 
				update_tag(self, c3, index)
			end
		}
	}

	return tag
end
