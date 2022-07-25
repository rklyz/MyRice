local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi

local support = {}

----- Supported things:

--- Text
-- Coloring_text
support.text_coloring = function(text, color)
	return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

-- hover text
support.create_button = function(text, font, color, color_hover, onclick)
	local button = wibox.widget.textbox()
	button.font = font
	button.markup = support.text_coloring(text, color)

	button:buttons(gears.table.join(
		awful.button({ }, 1, onclick)
	))

	button:connect_signal("mouse::enter", function()
		button.markup = support.text_coloring(text, color_hover)

		local wb = mouse.current_wibox

		if wb then
			old_cursor, old_wibox = wb.cursor, wb
			wb.cursor = "hand2"
		end
	end)

	button:connect_signal("mouse::leave", function()
		button.markup = support.text_coloring(text, color)

		if old_wibox then
			old_wibox.cursor = old_cursor
			old_wibox = nil
		end
	end)

	return button
end

--- Padding/Spacing
-- Horizontal
support.spacing_h = function(spacing)
	return wibox.widget {
		forced_width = spacing,
		widget = wibox.container.background,
	}
end

-- Vertical
support.spacing_v = function(spacing)
	return wibox.widget {
		forced_height = spacing,
		widget = wibox.container.background,
	}
end

--- Shaping widget/wibox
-- Rounded Rectangle
support.shape_rr = function(cr, w, h, radius)
	return gears.shape.rounded_rect(cr,w,h, radius)
end

--- Creating boxes/Wrapping whole widget
support.create_box = function(widget, top_margin, bottom_margin)
	local container = wibox.container.margin()
	container.margins = {top = top_margin, bottom = bottom_margin}

	return wibox.widget {
		{
			nil,
			{
				nil,
				widget,
				expand = 'none',
				layout = wibox.layout.align.vertical,
			},
			expand = 'none',
			layout = wibox.layout.align.vertical,
		},
		widget = container,
	}
end

return support
