local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Get some widgets
local profile = require "misc.lockscreen.profile"
local clock = require "misc.lockscreen.clock"
local powerbutton = require "misc.lockscreen.powerbutton"

-- Creating lockscreen
local lockscreen = wibox {
	ontop = true,
	visible = false,
	bg = beautiful.black .. "99",
}

awful.placement.maximize(lockscreen)

local keygrabber = function()
	return awful.keygrabber {
		autostart = false,
		stop_event = 'release',
		keypressed_callback = function(self, mod, key, command) 
			if key == "Escape" then 
				lockscreen.toggle()
			end
		end
	}
end

lockscreen.keygrabber = keygrabber()

lockscreen.toggle = function()
	lockscreen.visible = not lockscreen.visible
	if lockscreen.visible then 
		lockscreen.keygrabber:start()
	else
		lockscreen.keygrabber:stop()
	end
end

lockscreen:buttons(gears.table.join(
	awful.button({ }, 1, function() lockscreen.toggle() end)
))

awesome.connect_signal("lockscreen::toggle", function() lockscreen.toggle() end)

local left = wibox.widget {
	{
		clock,
		margins = {top = 20, left = 20},
		widget = wibox.container.margin,
	},
	nil,
	nil,
	expand = 'none',
	layout = wibox.layout.align.vertical,
}

lockscreen : setup {
	left,
	{
		nil,
		{
			profile,
			powerbutton,
			spacing = 50,
			layout = wibox.layout.fixed.vertical,
		},
		expand = "none",
		layout = wibox.layout.align.vertical,
	},
	nil,
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}
