local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Set colors
local active_color = beautiful.icon_selected .. "80"
local muted_color = "#666666"
local active_background_color = "#ffffff"
local muted_background_color = "#222222"

local volume_bar = wibox.widget {
    max_value = 100,
    value = 50,
    shape = helpers.rrect(dpi(15)),
    bar_shape =  helpers.rrect(dpi(15)),
    color = active_color,
    background_color = active_background_color,
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