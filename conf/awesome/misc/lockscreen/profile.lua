local awful = require "awful"
local gears = require "gears"
local wibox = require "wibox"
local beautiful = require "beautiful"

-- Pfp
local pfp = wibox.widget.imagebox()
pfp.image = beautiful.pfp
pfp.halign = 'center'
pfp.valign = 'center'

-- User
local user = wibox.widget.textbox()
user.font = "Roboto bold 24"

local function get_user()
	awful.spawn.easy_async_with_shell("hostname", function(stdout) 
		stdout = string.lower(stdout)
		stdout = string.gsub(stdout, "\n", "")
		user.markup = "<span foreground='"..beautiful.white.."'>"..os.getenv('USER').."@"..stdout.."</span>"
	end)
end

get_user()

return wibox.widget {
	nil,
	{
		{
			{
				widget = pfp,
			},
			bg = beautiful.white, -- You might wanna remove this
			border_width = 2,
			border_color = beautiful.black,
			forced_width = 200,
			forced_height = 200,
			shape = gears.shape.circle,
			widget = wibox.container.background,
		},
		user,
		spacing = 4,
		layout = wibox.layout.fixed.vertical,
	},
	expand = 'none',
	layout = wibox.layout.align.horizontal,
}
