local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"
local dpi = beautiful.xresources.apply_dpi

-- Volume
local volume = wibox.widget.textbox()
volume.font = "Roboto Medium 18"

local percentage = wibox.widget.textbox()
percentage.font = "Roboto Medium 14"

awesome.connect_signal("signal::volume", function(vol, mute)
	vol = tonumber(vol)
	if mute or vol == 0 then
		volume.markup = "<span foreground='"..beautiful.red.."'>󰸈</span>"
		percentage.markup = "Muted"
	else
		if vol < 20 then
			volume.markup = "<span foreground='"..beautiful.red.."'>󰕿</span>"
			percentage.markup = vol .. "%"
		elseif vol < 60 then
			volume.markup = "<span foreground='"..beautiful.red.."'>󰖀</span>"
			percentage.markup = vol .. "%"
		else
			volume.markup = "<span foreground='"..beautiful.red.."'>󰕾</span>"
			percentage.markup = vol .. "%"
		end
	end
end)

return {
	volume,
	--percentage,
	spacing = dpi(4),
	layout = wibox.layout.fixed.horizontal,
}
