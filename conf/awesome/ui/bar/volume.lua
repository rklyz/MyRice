local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

local supporter = require "supporter"

-- Volume
local volume = wibox.widget.textbox()
volume.font = "Roboto Medium 20"

awesome.connect_signal("signal::volume", function(vol, muted)
	vol = tonumber(vol)
	if not muted or not vol == 0 then
		if vol < 20 then
			volume.markup = "󰕿"
		elseif vol < 60 then
			volume.markup = "󰖀"
		else
			volume.markup = "󰕾"
		end
	else
		volume.markup = "󰸈"
	end
end)

return volume
