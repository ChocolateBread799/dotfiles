local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

client.connect_signal("request::titlebars", function(c)

    awful.titlebar(c, {
        position = "right",
        size = dpi(2),
        bg = "#00000000"
    }):setup{
        {
            {
                bg = beautiful.border_color,
                widget = wibox.container.background
            },
            right = dpi(1),
            widget = wibox.container.margin
        },
        bg = beautiful.bg,
        widget = wibox.container.background
    }
end)