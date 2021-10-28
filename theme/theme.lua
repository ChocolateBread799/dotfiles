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

theme.font          = "Consolas 10"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

theme.wallpaper     = gfs.get_configuration_dir() .. "wallpapers/bright.png"

theme.bg_normal     = "#ffffff"
theme.bg_focus      = "#ffffff"
theme.bg_widget     = "#f5f5f5"

theme.fg_normal     = "#000000"
theme.fg_focus     = "#000000"

theme.useless_gap   = 20
theme.border_radius = 10
theme.sidebar_radius = 40

-- icon

theme.icon_font_name = "FiraCode Nerd Font Mono "

-- widget

theme.tasklist_bg_focus = "#f5f5f5"

-- notif

theme.notification_icon = gfs.get_configuration_dir() .. "icons/notifications/notification.png"

-- titlebar

theme.titlebar_close_button_normal = gfs.get_configuration_dir() .. "icons/titlebar/close_inactive.png"
theme.titlebar_close_button_focus  = gfs.get_configuration_dir() .. "icons/titlebar/close.png"
theme.titlebar_close_button_focus_hover = gfs.get_configuration_dir() .. "icons/titlebar/close_hover.png"

theme.titlebar_minimize_button_normal = gfs.get_configuration_dir() .. "icons/titlebar/minimize_inactive.png"
theme.titlebar_minimize_button_focus  = gfs.get_configuration_dir() .. "icons/titlebar/minimize.png"
theme.titlebar_minimize_button_focus_hover  = gfs.get_configuration_dir() .. "icons/titlebar/minimize_hover.png"

theme.titlebar_floating_button_normal_inactive = gfs.get_configuration_dir() .. "icons/titlebar/float_inactive.png"
theme.titlebar_floating_button_focus_inactive  = gfs.get_configuration_dir() .. "icons/titlebar/float.png"
theme.titlebar_floating_button_normal_active = gfs.get_configuration_dir() .. "icons/titlebar/float_inactive.png"
theme.titlebar_floating_button_focus_active  = gfs.get_configuration_dir() .. "icons/titlebar/float.png"
theme.titlebar_floating_button_focus_active_hover  = gfs.get_configuration_dir() .. "icons/titlebar/float_hover.png"
theme.titlebar_floating_button_focus_inactive_hover  = gfs.get_configuration_dir() .. "icons/titlebar/float_hover.png"

theme.icon_theme = nil

return theme
