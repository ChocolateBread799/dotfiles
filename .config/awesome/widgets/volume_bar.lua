local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require('helpers')

-- Set colors
local active_color = {
    color = "#000000"
}

local muted_color = active_color
local active_background_color = "#ffffff"
local muted_background_color = "#ffffff"

local volume_bar = wibox.widget {
    max_value = 100,
    value = 50,
    shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 16) end,
    bar_shape = function(cr,w,h) gears.shape.rounded_rect(cr,w,h, 14) end,
    color = active_color,
    background_color = active_background_color,
    border_width = 2,
    border_color = "#000000",
    widget = wibox.widget.progressbar,
}

awesome.connect_signal("signals::volume", function(volume, muted)
    local bg_color
    if muted then
        fill_color = muted_color
        bg_color = muted_background_color
    else
        fill_color = active_color
        bg_color = active_background_color
    end
    volume_bar.value = volume
    volume_bar.color = fill_color
    volume_bar.background_color = bg_color
end)

return volume_bar