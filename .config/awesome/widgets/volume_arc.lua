local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local active_color = {
    color = "#000000"
}

local mute_color = {
    color = "#000000"
}

local volume_arc = wibox.widget {
    max_value = 100,
    thickness = 10,
    start_angle = 4.71238898, -- 2pi*3/4
    rounded_edge = true,
    bg = "#d5d5d5",
    paddings = 10,
    colors = {active_color},
    widget = wibox.container.arcchart
}

awesome.connect_signal("signals::volume", function(volume, muted)
    if muted then
        volume_arc.bg = "#FFA1A5"
        volume_arc.colors = {mute_color}
    else
        volume_arc.bg = "#d5d5d5"
        volume_arc.colors = {active_color}
    end

    volume_arc.value = volume
end)

return volume_arc