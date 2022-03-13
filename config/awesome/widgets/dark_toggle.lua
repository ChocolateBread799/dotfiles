local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local darkmode = wibox.widget {
    nil,
    {
        id = 'darkmode_slider',
        bar_shape = helpers.rrect(20),
        bar_height = dpi(24),
        bar_color = beautiful.dark_slider_bg,
        bar_active_color = beautiful.dark_slider_bg,
        handle_color  = "#FFFFFF",
        handle_shape = gears.shape.circle,
        handle_width = dpi(18),
        maximum = 100,
        value = 0,
        widget = wibox.widget.slider
    },
    nil,
    expand = 'none',
    forced_height = dpi(24),
    layout = wibox.layout.align.vertical
}

darkmode:connect_signal("button::press", function()
    if theme == themes[1] then
        awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/dark")
        awesome.restart()
    else
        awful.spawn.with_shell(gears.filesystem.get_configuration_dir() .. "scripts/light")
        awesome.restart()
    end
end)

local darkmode_slider = darkmode.darkmode_slider

local update_darkmode = function()
    if theme == themes[2] then
        darkmode_slider.value = 90
    else
        darkmode_slider.value = 10
    end
end

update_darkmode()

return darkmode