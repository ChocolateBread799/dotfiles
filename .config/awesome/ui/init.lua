local awful = require("awful")

local bling = require("modules.bling")

require("ui.decoration")
require("ui.bar")
require("ui.sidebar")
require("ui.dock")

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}