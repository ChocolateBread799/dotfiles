local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local active_color = beautiful.fg_sidebar

local brightness_arc = wibox.widget {
    max_value = 100,
    thickness = 6,
    start_angle = 4.3,
    rounded_edge = true,
    bg = "#00000000",
    paddings = dpi(10),
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("signals::brightness", function(value)
    if value >= 0 then brightness_arc.value = value end
end)

return brightness_arc