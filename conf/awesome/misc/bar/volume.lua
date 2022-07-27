local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Volume
local volume = wibox.widget.textbox()
volume.font = "Roboto Medium 20"

awesome.connect_signal("signal::volume", function(vol, mute)
	vol = tonumber(vol)
	if mute or vol == 0 then
		volume.markup = "󰸈"
	else
		if vol < 20 then
			volume.markup = "󰕿"
		elseif vol < 60 then
			volume.markup = "󰖀"
		else
			volume.markup = "󰕾"
		end
	end
end)

return volume
