local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local active_color = beautiful.arc_color

local cpu_arc = wibox.widget {
    max_value = 100,
    thickness = dpi(8),
    start_angle = 4.3,
    rounded_edge = true,
    bg = beautiful.arc_bg,
    paddings = dpi(10),
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("signals::cpu", function(value) 
    cpu_arc.value = value
    value.markup = value
 end)

return cpu_arc