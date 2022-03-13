local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")
local helpers = require("helpers")

local theme = {}

-- themes 

theme.font = "SF Pro Display Medium 12"
theme.icon_font = "SFMono Nerd Font 12"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

-- theme.wallpaper = gfs.get_configuration_dir() .. "wallpapers/118.png"

gears.wallpaper.set("#E5E8ED")

theme.useless_gap = 20

-- colors

theme.bg = "#FFFFFF"
theme.bg_sidebar = "#FFFFFF"
theme.bg_selected = "#EFF1FA"
theme.bg_widget = "#F7F8FA"

theme.border_color = "#ECECEC"

theme.fg_normal = "#b0b2bf"
theme.fg_focus      = "#573BFF"
theme.fg_urgent     = "#b0b2bf"
theme.fg_minimize   = "#b0b2bf"
theme.fg_sidebar    = "#2A3256"

theme.taglist_bg_focus = "#EDEFFD"

theme.active = "#6A6E78"

theme.icon_bg = "#b0b2bf"
theme.icon_normal = "#b0b2bf"
theme.icon_selected = "#573BFF"

theme.red = "#db7272"

theme.grey = "#383D44"

theme.titlebar_unfocused = "#EFEFEF"

theme.fg_contrast = "#555B6E"

theme.search_bar = "#F7F8FA"

theme.dark_slider_bg = "#E6E9EB"

theme.arc_bg = "#e6e9f0"
theme.arc_color = "#6192FB"

-- radius

theme.bar_radius = dpi(25)
theme.border_radius = dpi(10)
theme.client_radius = dpi(12)
theme.sidebar_radius = dpi(40)
theme.dock_radius = dpi(25)

theme.snap_bg = theme.border_color
theme.snap_border_width = dpi(2)

-- wibar

theme.wibar_height = 1080 
theme.popup_left = 150

-- icons

theme.dark_toggle = gfs.get_configuration_dir() .. "icons/bar/light.png"
theme.darkmode = gfs.get_configuration_dir() .. "icons/bar/darkmode.png"

theme.clear_icon = gfs.get_configuration_dir() .. "icons/notif-center/clear.png"
theme.clear_filled = gfs.get_configuration_dir() .. "icons/notif-center/clear_filled.png"
theme.delete_icon = gfs.get_configuration_dir() .. "icons/notif-center/delete.png"

theme.profile = gfs.get_configuration_dir() .. "icons/bar/uiface2.png"

theme.home = gfs.get_configuration_dir() .. "icons/tag/home.png"
theme.home_selected = gfs.get_configuration_dir() .. "icons/tag/home_selected.png"

theme.dashboard = gfs.get_configuration_dir() .. "icons/tag/dashboard.png"
theme.dashboard_selected = gfs.get_configuration_dir() .. "icons/tag/dashboard_selected.png"

theme.folder = gfs.get_configuration_dir() .. "icons/tag/folder.png"
theme.folder_selected = gfs.get_configuration_dir() .. "icons/tag/folder_selected.png"

theme.report = gfs.get_configuration_dir() .. "icons/tag/report.png"
theme.report_selected = gfs.get_configuration_dir() .. "icons/tag/report_selected.png"

theme.cal = gfs.get_configuration_dir() .. "icons/tag/cal.png"
theme.cal_selected = gfs.get_configuration_dir() .. "icons/tag/cal_selected.png"

theme.document = gfs.get_configuration_dir() .. "icons/tag/document.png"
theme.document_selected = gfs.get_configuration_dir() .. "icons/tag/document_selected.png"

theme.settings = gfs.get_configuration_dir() .. "icons/tag/settings.png"
theme.settings_selected = gfs.get_configuration_dir() .. "icons/tag/settings_selected.png"

theme.wide_icon = gfs.get_configuration_dir() .. "icons/bar/wide.png"

theme.music_icon = gfs.get_configuration_dir() .. "icons/bar/music.png"

theme.vol = gfs.get_configuration_dir() .. "icons/bar/vol.png"

theme.temp = gfs.get_configuration_dir() .. "icons/bar/temp.png"
theme.cpu = gfs.get_configuration_dir() .. "icons/bar/cpu.png"
theme.ram = gfs.get_configuration_dir() .. "icons/bar/ram.png"

theme.notif_icon = gfs.get_configuration_dir() .. "icons/notif-center/notif.png"

theme.search_icon = gfs.get_configuration_dir() .. "icons/bar/search.png"
theme.search_bar_icon = colorize_icon(theme.search_icon, theme.icon_normal)

theme.logo = gfs.get_configuration_dir() .. "icons/bar/align.png"
theme.logo_normal = colorize_icon(theme.logo, theme.icon_normal) 
theme.logo_selected = colorize_icon(theme.logo, theme.icon_selected) 

theme.moon = gfs.get_configuration_dir() .. "icons/bar/moon.png"

theme.shutdown = gfs.get_configuration_dir() .. "icons/power/shutdown.png"
theme.restart = gfs.get_configuration_dir() .. "icons/power/restart.png"
theme.logout = gfs.get_configuration_dir() .. "icons/power/logout.png"

theme.dots = gfs.get_configuration_dir() .. "icons/bar/dots.png"

-- notif

theme.notification_icon = colorize_icon(theme.notif_icon, theme.icon_normal) 
theme.delete = colorize_icon(theme.delete_icon, theme.red)
theme.delete_hover = colorize_icon(theme.delete_icon, theme.red .."80")
theme.clear = colorize_icon(theme.clear_icon, theme.grey)
theme.clear_hover = colorize_icon(theme.clear_filled, theme.grey)

theme.icon_theme = nil

return theme
