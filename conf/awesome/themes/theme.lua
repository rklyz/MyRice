---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local dpi = xresources.apply_dpi
local gears = require "gears"
local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "themes/"
local walls_path = "~/.local/pictures/Walls/"

local theme = {}

----- User -----

theme.pfp = themes_path .. "pfp.jpg"
theme.user = "Neko"
theme.hostname = "@Neptune"

----- Font -----

theme.font = "iosevka bold 14"
theme.font_name = "iosevka"
theme.font_size = "bold 14"

----- General/default Settings -----

theme.bg_normal     = "#151515"
theme.bg_focus      = "#151515"
theme.bg_urgent     = "#151515"
theme.bg_minimize   = "#151515"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#C5C8C6"
theme.fg_focus      = theme.fg_normal
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.useless_gap         = dpi(20)
theme.border_width        = dpi(0)

----- Colors -----

theme.blue = "#84a0c6"
theme.yellow = "#e2a478"
theme.green = "#b4be82"
theme.red = "#e27878"
theme.magenta = "#B8AED5"
theme.transparent = "#00000000"

theme.gradient = {
    [1] = "#0f2e55",
    [2] = "#005982",
    [3] = "#008798",
}

theme.empty = "#404B66"


----- Bar -----

theme.bar = "#0B151D"
theme.bar2 = "#0E1922"
theme.bar_alt = "#212331"

theme.taglist_fg_focus = theme.yellow
theme.taglist_fg_occupied = theme.fg_normal
theme.taglist_fg_empty = "#404B66"
theme.taglist_bg_focus = theme.blue

theme.tasklist_plain_task_name = true

theme.titlebar_bg_normal = theme.bar
theme.titlebar_bg_focus = theme.bar2

theme.notif = themes_path .. "notif.png"
theme.screenshot = themes_path .. "screenshot.png"

----- Menu -----

theme.menu_height = dpi(35)
theme.menu_width  = dpi(200)
theme.menu_fg_focus = theme.fg_normal
theme.menu_fg_normal = theme.taglist_fg_empty
theme.menu_bg_focus = theme.bar_alt
theme.menu_bg_normal = theme.bar
theme.submenu = ""
theme.menu_font = theme.font_name .. " 12"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = gears.color.recolor_image(themes_path .. "titlebar/close.svg", theme.fg_normal)
theme.titlebar_close_button_focus  = gears.color.recolor_image(themes_path .. "titlebar/close.svg", theme.fg_normal)

theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

theme.wallpaper =  themes_path .. "wallpaper.png"

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."layouts/fairhw.png"
theme.layout_fairv = themes_path.."layouts/fairvw.png"
theme.layout_floating  = themes_path.."layouts/floatingw.png"
theme.layout_magnifier = themes_path.."layouts/magnifierw.png"
theme.layout_max = themes_path.."layouts/maxw.png"
theme.layout_fullscreen = themes_path.."layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."layouts/tileleftw.png"
theme.layout_tile = themes_path.."layouts/tilew.png"
theme.layout_tiletop = themes_path.."layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
