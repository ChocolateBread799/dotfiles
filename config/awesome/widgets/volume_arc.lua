local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local mute_color = beautiful.vol_bg

local active_color = beautiful.arc_color

local volume_arc = wibox.widget {
    max_value = 100,
    thickness = dpi(8),
    start_angle = 4.3,
    rounded_edge = true,
    bg = beautiful.arc_bg,
    paddings = dpi(10),
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("signals::volume", function(volume, muted)
    if muted then
        volume_arc.colors = {mute_color}
    else
        volume_arc.colors = {active_color}
    end

    volume_arc.value = volume
end)

return volume_arc