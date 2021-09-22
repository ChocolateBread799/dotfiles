local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local naughty = require("naughty")
local dpi = xresources.apply_dpi
local xrdb = xresources.get_current_theme()
local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()
local beautiful = require("beautiful")

local theme = {}

-- themes

theme.font          = "Sarasa Mono K 13"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

theme.bg_normal     = "#1b1f27"
theme.bg_focus      = "#1b1f27"
theme.bg_urgent     = "#1b1f27"
theme.bg_minimize   = "#1b1f27"
theme.bg_systray    = theme.bg_normal

theme.useless_gap   = 20
theme.border_width  = 2
theme.border_radius = 20
theme.border_normal = "#3f4859"
theme.border_focus  = "#3f4859"
theme.border_marked = "#3f4859"

-- widgets

theme.taglist_fg = "#80d1ff"
theme.taglist_fg_empty = "#3f4859"
theme.taglist_fg_occupied = "#949eb3"
theme.taglist_font = "Sarasa Mono K Bold 13"

-- menu

theme.menu_submenu_icon = gfs.get_configuration_dir() .. "theme/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width = dpi(120)
theme.menu_bg = "#1b1f27"
theme.menu_font = "Sarasa Mono K Bold 13"

-- awesome icon

theme.awesome_icon = gfs.get_configuration_dir() .. "theme/awesome.png"

-- tag preview

theme.tag_preview_widget_border_radius = 10          
theme.tag_preview_client_border_radius = 10  
theme.tag_preview_client_opacity = 0.1   
theme.tag_preview_client_bg = "#1b1f27"         
theme.tag_preview_client_border_color = "#3f4859"  
theme.tag_preview_client_border_width = 2           
theme.tag_preview_widget_bg = "#1b1f27"           
theme.tag_preview_widget_border_color = "#3f4859"   
theme.tag_preview_widget_border_width = 2          
theme.tag_preview_widget_margin = 0              

-- titlebar

theme.titlebar_close_button_normal = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
theme.titlebar_close_button_focus  = gfs.get_configuration_dir() .. "theme/titlebar/close.png"
theme.titlebar_close_button_focus_hover = gfs.get_configuration_dir() .. "theme/titlebar/close_hover.png"

theme.titlebar_minimize_button_normal = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
theme.titlebar_minimize_button_focus  = gfs.get_configuration_dir() .. "theme/titlebar/minimize.png"
theme.titlebar_minimize_button_focus_hover  = gfs.get_configuration_dir() .. "theme/titlebar/minimize_hover.png"

theme.titlebar_floating_button_normal_inactive = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
theme.titlebar_floating_button_focus_inactive  = gfs.get_configuration_dir() .. "theme/titlebar/floating.png"
theme.titlebar_floating_button_normal_active = gfs.get_configuration_dir() .. "theme/titlebar/inactive.png"
theme.titlebar_floating_button_focus_active  = gfs.get_configuration_dir() .. "theme/titlebar/floating.png"
theme.titlebar_floating_button_focus_active_hover  = gfs.get_configuration_dir() .. "theme/titlebar/floating_hover.png"
theme.titlebar_floating_button_focus_inactive_hover  = gfs.get_configuration_dir() .. "theme/titlebar/floating_hover.png"

theme.icon_theme = nil

return theme
