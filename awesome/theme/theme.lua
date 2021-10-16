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

theme.font          = "Roboto Mono Bold 14"

theme.dir = string.format('%s/.config/awesome/theme', os.getenv('HOME'))

theme.wallpaper     = gfs.get_configuration_dir() .. "theme/bg.png"

theme.bg_normal     = "#F1EBDD"
theme.bg_focus      = "#F1EBDD"

theme.fg_normal     = "#272727"
theme.fg_focus     = "#272727"

theme.useless_gap   = 20
theme.border_width  = 5
theme.border_normal = "#272727"
theme.border_focus  = "#272727"
theme.border_marked = "#272727"

-- widgets

theme.taglist_fg = "#272727"


-- menu

theme.menu_submenu_icon = gfs.get_configuration_dir() .. "theme/submenu.png"
theme.menu_height = dpi(25)
theme.menu_width = dpi(120)
theme.menu_bg = "#F1EBDD"
theme.menu_font = "Roboto Mono Medium 12"

-- awesome icon

theme.awesome_icon = gfs.get_configuration_dir() .. "theme/awesome.png"

-- tag preview

theme.tag_preview_widget_border_radius = 20          
theme.tag_preview_client_border_radius = 20  
theme.tag_preview_client_opacity = 0.1   
theme.tag_preview_client_bg = "#F1EBDD"         
theme.tag_preview_client_border_color = "#272727"  
theme.tag_preview_client_border_width = 3       
theme.tag_preview_widget_bg = "#F1EBDD"           
theme.tag_preview_widget_border_color = "#272727"   
theme.tag_preview_widget_border_width = 4      
theme.tag_preview_widget_margin = 0              

-- titlebar

theme.titlebar_close_button_normal = gfs.get_configuration_dir() .. "theme/titlebar/circle.png"
theme.titlebar_close_button_focus  = gfs.get_configuration_dir() .. "theme/titlebar/circle.png"
theme.titlebar_close_button_focus_hover = gfs.get_configuration_dir() .. "theme/titlebar/close_hover.png"

theme.titlebar_floating_button_normal_inactive = gfs.get_configuration_dir() .. "theme/titlebar/circle.png"
theme.titlebar_floating_button_focus_inactive  = gfs.get_configuration_dir() .. "theme/titlebar/circle.png"
theme.titlebar_floating_button_normal_active = gfs.get_configuration_dir() .. "theme/titlebar/circle.png"
theme.titlebar_floating_button_focus_active  = gfs.get_configuration_dir() .. "theme/titlebar/circle.png"
theme.titlebar_floating_button_focus_active_hover  = gfs.get_configuration_dir() .. "theme/titlebar/floating_hover.png"
theme.titlebar_floating_button_focus_inactive_hover  = gfs.get_configuration_dir() .. "theme/titlebar/floating_hover.png"

theme.icon_theme = nil

return theme
