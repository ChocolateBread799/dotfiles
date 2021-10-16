local awful = require("awful")

require("ui.desktop")
require("ui.bar")
require("ui.dashboard")
require("ui.titlebar")

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}