--  _   _                         
-- | |_| |__   ___ _ __ ___   ___ 
-- | __| '_ \ / _ \ '_ ` _ \ / _ \
-- | |_| | | |  __/ | | | | |  __/
--  \__|_| |_|\___|_| |_| |_|\___|
----------------------------------
  ----------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local rnotification = require("ruled.notification")
local bling = require "bling"
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "theme/"
local walls_path = "~/.local/pictures/Walls/"

local theme = {}

----- Wallpaper -----

theme.wallpaper = walls_path.."pattern.jpg"

----- Font -----

theme.font  = "JetBrainsMono NF 16"
theme.font_name = "JetBrainsMono NF"
theme.font_size = "20"

----- General Settings -----

theme.fg = "#d4d4d5"
theme.fg_alt = "#535358"

theme.bg_normal     = "#151515"
theme.bg_focus      = "#151515"
theme.bg_urgent     = "#151515"
theme.bg_minimize   = "#151515"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#abb2bf"
theme.fg_focus      = "#abb2bf"
theme.fg_urgent     = "#abb2bf"
theme.fg_minimize   = "#abb2bf"

theme.useless_gap         = dpi(20)
theme.border_width        = dpi(0)

-- Colors

theme.blue = "#67b0e8"
theme.yellow = "#e5c76b"
theme.red = "#f87070"
theme.green = "#79dcaa"
theme.magenta = "#c397d8"
theme.cyan = "#70c0ba"

----- Bar -----

theme.bar = "#101317"
theme.bar_alt = "#181f21"

-- Taglist/Workspaces

theme.taglist_font = 'JetBrainsMono NF 18'

theme.taglist_fg_focus = theme.fg
theme.taglist_fg_empty = "#23242A"
theme.taglist_fg_occupied = theme.fg_alt

theme.taglist_bg_focus = "#7ab0df"

theme.tasklist_bg_normal = "#101317"
theme.tasklist_bg_focus = theme.wibar_bg_alt

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

----- Menu -----

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width  = dpi(200)
theme.menu_bg_normal = '#101418'
theme.menu_fg_normal = '#A8BFC4'


----- MsTab -----

theme.mstab_bar_disable = false
theme.mstab_bar_padding = "default"
theme.mstab_tabbar_style = "modern"

----- Icon -----

theme.titlebar_close_button_normal = themes_path.."titlebar/close_normal.svg"
theme.titlebar_close_button_focus  = themes_path.."titlebar/close.svg"

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
theme.layout_spiral  = themes_path.."layouts/spiralw.png"
theme.layout_dwindle = themes_path.."layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."layouts/cornernww.png"
theme.layout_cornerne = themes_path.."layouts/cornernew.png"
theme.layout_cornersw = themes_path.."layouts/cornersww.png"
theme.layout_cornerse = themes_path.."layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = themes_path.."awesome.png"

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
