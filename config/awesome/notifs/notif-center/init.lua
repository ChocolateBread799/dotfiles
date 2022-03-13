-- Thanks For Javacafe01

local wibox = require('wibox')
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local notif_header = wibox.widget {
    markup = helpers.colorize_text('Notification Center', beautiful.fg_sidebar),
    font = beautiful.font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

return wibox.widget {
    {
        notif_header,
        nil,
        require("notifs.notif-center.clear-all"),
        expand = "none",
        spacing = dpi(10),
        layout = wibox.layout.align.horizontal
    },
    require('notifs.notif-center.build-notifbox'),
    spacing = dpi(10),
    layout = wibox.layout.fixed.vertical,
}
