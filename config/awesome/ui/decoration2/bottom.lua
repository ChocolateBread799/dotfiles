local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local bling = require("modules.bling")
local helpers = require("helpers")

client.connect_signal("request::titlebars", function(c)

awful.titlebar(c, {
    position = "bottom",
    size = dpi(24),
    bg = "#00000000"
}):setup{
    {
        {
            {
                {
                    bg = beautiful.bg,
                    shape = helpers.prrect(beautiful.border_radius, false, false, true, true),
                    widget = wibox.container.background
                },
                left = dpi(1),
                right = dpi(1),
                bottom = dpi(1),
                widget = wibox.container.margin
            },
            bg = beautiful.border_color,
            shape = helpers.prrect(beautiful.border_radius, false, false, true, true),
            widget = wibox.container.background
        },
        left = dpi(1),
        right = dpi(1),
        bottom = dpi(1),
        widget = wibox.container.margin
    },
    bg = beautiful.bg,
    shape = helpers.prrect(beautiful.border_radius, false, false, true, true),
    widget = wibox.container.background
}   
end)
