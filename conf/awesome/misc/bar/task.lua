local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

local apps = require "main.apps"

-- Create tasklist
return function(s)

	local update_task = function(self, c)
		if c.active then
			self:get_children_by_id("bg")[1].bg = beautiful.bg_alt
			return
		elseif c.minimized then
			self:get_children_by_id("bg")[1].bg = beautiful.bg_alt .. "4d"
			return
		else
			self:get_children_by_id("bg")[1].bg = beautiful.bg
		end
	end

	local task = awful.widget.tasklist {
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = {
			awful.button({ }, 1, function(c) c:activate {context = "tasklist", action = "toggle_minimization"} end)
		},
		layout = {
			spacing = dpi(0),
			layout = wibox.layout.fixed.horizontal,
		},
		widget_template = {
			{
				{
					id = "client",
					widget = awful.widget.clienticon,
				},
				margins = dpi(12),
				widget = wibox.container.margin,
			},
			id = "bg",
			bg = beautiful.bg_alt,
			widget = wibox.container.background,

			create_callback = function(self, c, _, __) 
				self:get_children_by_id("client")[1].client = c
				update_task(self, c)
			end,

			update_callback = function(self, c, _, __)
				self:get_children_by_id("client")[1].client = c
				update_task(self, c)
			end
		},
	}

	return task
end
