local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")
local helpers = require("helpers")

local theme = {}

-- themes 

theme.font = "SF Pro Display Medium 11"
theme.icon_font = "SFMono Nerd Font 12"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

-- theme.wallpaper = gfs.get_configuration_dir() .. "wallpapers/118.png"

gears.wallpaper.set({
  type = "linear",
  from = { 0, 0, 0 },
  to = { screen_height, screen_width, 1 },
  stops = { { 0, "#D36CB0" }, { 1, "#7145DE" } }
}) --"#404958"

theme.useless_gap = 20

-- colors

theme.bg = "#161719"
theme.bg_sidebar = "#161719"
theme.bg_selected = "#1D1F22"
theme.bg_widget = "#1D1F22"

theme.border_color = "#252628"

theme.fg_normal = "#8A8E97"
theme.fg_focus      = "#FFFFFF"
theme.fg_urgent     = "#8A8E97"
theme.fg_minimize   = "#8A8E97"
theme.fg_sidebar = "#FFFFFF"

theme.taglist_bg_focus = {
  type = "linear",
  from = { 00, 00, 10 },
  to = { 100, 100, 30 },
  stops = { { 0, "#3F8CFF" }, { 1, "#5197FF" } }
} 

theme.active = "#6A6E78"

theme.icon_bg = "#FFFFFF"
theme.icon_normal = "#8A8E97"
theme.icon_selected = "#FFFFFF"

theme.red = "#db7272"

theme.grey = "#8B8B8B"

theme.titlebar_unfocused = "#252628"

theme.fg_contrast = "#FFFFFF"

theme.search_bar = "#1D1F22"

theme.dark_slider_bg = "#3F8CFF"

theme.arc_bg = "#161719"
theme.arc_color = "#6192FB"

-- radius

theme.bar_radius = dpi(25)
theme.border_radius = dpi(10)
theme.client_radius = dpi(12)
theme.sidebar_radius = dpi(40)
theme.dock_radius = dpi(25)

theme.snap_bg = theme.border_color
theme.snap_border_width = dpi(2)

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

-- dock icons

theme.spotify = gfs.get_configuration_dir() .. "icons/dock/Spotify.icns"
theme.chrome = gfs.get_configuration_dir() .. "icons/dock/Safari.icns"
theme.mail = gfs.get_configuration_dir() .. "icons/dock/Mail.icns"
theme.file = gfs.get_configuration_dir() .. "icons/dock/Finder.icns"
theme.netflix = gfs.get_configuration_dir() .. "icons/dock/Netflix.icns"
theme.vscode = gfs.get_configuration_dir() .. "icons/dock/Vscode.icns"

-- notif

theme.notification_icon = colorize_icon(theme.notif_icon, theme.icon_normal) 
theme.delete = colorize_icon(theme.delete_icon, theme.red)
theme.delete_hover = colorize_icon(theme.delete_icon, theme.red .. "80")
theme.clear = colorize_icon(theme.clear_icon, theme.grey)
theme.clear_hover = colorize_icon(theme.clear_filled, theme.grey)

theme.icon_theme = nil

return theme