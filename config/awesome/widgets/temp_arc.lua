local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local active_color = beautiful.arc_color

local temp_arc = wibox.widget {
    max_value = 100,
    thickness = dpi(8),
    value = 32,
    start_angle = 4.3,
    rounded_edge = true,
    bg = beautiful.arc_bg,
    paddings = dpi(10),
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("signals::temp", function(temp) temp_arc.value = temp end)
return temp_arc