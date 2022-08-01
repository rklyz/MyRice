local awful = require "awful"
local naughty = require "naughty"

-- Some more notif function
local notify = {}

-- Notify after screenshot
notify.screenshot = function(location)
        local open = naughty.action {
                name = "Open"
        }

        open:connect_signal("invoked", function(n)
                awful.spawn("feh "..location, false)
        end)

        local show = naughty.action {
                name = "Show"
        }

        show:connect_signal("invoked", function(n)
                awful.spawn("thunar "..location, false)
        end)

        naughty.notification {
                title = "Screenshot",
                message = "Smile!",
                actions = { open, show },
        }
end

return notify
