local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Set colors
local active_color = beautiful.icon_selected

local background_color = "#ffffff"

local cpu_bar = wibox.widget {
    max_value = 100,
    value = 50,
    forced_height = dpi(30),
    forced_width = dpi(350),
    shape = helpers.rrect(dpi(15)),
    bar_shape =  helpers.rrect(dpi(15)),
    color = active_color,
    background_color = background_color,
    widget = wibox.widget.progressbar
}

awesome.connect_signal("signals::cpu", function(value)
    cpu_bar.value = value
end)

return cpu_bar