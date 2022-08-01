local awful = require "awful"
local beautiful = require "beautiful"

local create_popup = require "misc.popup.popup"

local popup = create_popup(beautiful.black)

awesome.connect_signal("signal::brightness", function(bright)
	bright = tonumber(bright)
	popup.update("󰃟")
	popup.updateValue(bright)
	popup.toggle()
end)
