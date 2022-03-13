local beautiful = require("beautiful")
local wibox = require('wibox')

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local empty_notifbox = wibox.widget {
    {
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(5),
        {
            expand = 'none',
            layout = wibox.layout.align.horizontal,
            nil,
            {
                image = beautiful.notification_icon,
                resize = true,
                forced_height = dpi(35),
                forced_width = dpi(35),
                widget = wibox.widget.imagebox
            },
            nil
        },
        {
            markup = 'You have no notifs!',
            font = beautiful.font,
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        }
    },
    margins = dpi(20),
    widget = wibox.container.margin

}

local centered_empty_notifbox = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    expand = 'none',
    empty_notifbox
}

return centered_empty_notifbox