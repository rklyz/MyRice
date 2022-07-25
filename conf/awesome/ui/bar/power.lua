local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local dpi = beautiful.xresources.apply_dpi
local supporter = require "supporter"

local width = dpi(40)
local height = dpi(160)

local powermenu = wibox {
        visible = false,
        ontop = true,
        screen = awful.screen.focused(),
        width = width,
        height = height,
        x = awful.screen.focused().geometry.width - width - dpi(4),
        y = dpi(50),
	bg = "#00000000",
        type = 'dock'
}

-- Power Button
local power = supporter.create_button("󰐥", "Roboto Medium 20", beautiful.fg_normal, beautiful.black, function()
	_G.toggle()
end)

toggle = function()
	powermenu.visible = not powermenu.visible
end

powermenu : setup {
	widget = require "ui.bar.powermenu"(width, height)
}

return power
