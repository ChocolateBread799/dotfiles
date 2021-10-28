local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local active_color = {
    type = 'linear',
    from = {0, 0},
    to = {150, 50}, -- replace with w,h later
    stops = {{0, "#A0A1F1"}, {0.75, "#F499D8"}}
}

local cpu_arc = wibox.widget {
    max_value = 100,
    thickness = 10,
    start_angle = 4.71238898, -- 2pi*3/4
    rounded_edge = true,
    bg = "#d5d5d5",
    paddings = 10,
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("signals::cpu", function(value) cpu_arc.value = value end)

return cpu_arc