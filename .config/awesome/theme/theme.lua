local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")

local theme = {}

-- themes

theme.font          = "MADE Outer Sans Medium 15"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

theme.wallpaper     = gfs.get_configuration_dir() .. "wallpapers/bg3.jpg"

theme.bg = "#ebebeb"
theme.bg_widget = "#f5f5f5"

theme.fg_normal = "#000000"
theme.fg_focus = "#000000"

theme.useless_gap   = 20
theme.border_radius = 10
theme.client_radius = 13
theme.sidebar_radius = 40

theme.border_color = "#000000"

-- dock

theme.dock_bg = gfs.get_configuration_dir() .. "icons/dock.png"

-- widget

theme.tasklist_bg_focus = "#f5f5f5"

theme.taglist_fg = "#000000"
theme.taglist_fg_empty = "#4f4f4f"
theme.taglist_fg_occupied = "#8c8c8c"

-- notif

theme.notification_icon = gfs.get_configuration_dir() .. "icons/notifications/notif.png"

theme.icon_theme = nil

return theme
