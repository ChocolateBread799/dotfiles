local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local gfs = require("gears.filesystem")

naughty.config.defaults.ontop = true
naughty.config.defaults.icon_size = 0
naughty.config.defaults.screen = awful.screen.focused()
naughty.config.defaults.timeout = 16
naughty.config.defaults.title = "System Notification"
naughty.config.defaults.margin = 20
naughty.config.defaults.position = "bottom_left"
naughty.config.defaults.border_width = 5
naughty.config.defaults.border_color = "#272727"
naughty.config.defaults.font = "Roboto Mono Medium 11"
naughty.config.defaults.width = 300