local awful = require('awful')
local wibox = require('wibox')
local gears = require('gears')
local beautiful = require('beautiful')
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local button = require("widgets.button")

local delete_button = button.create_image_onclick(beautiful.clear, beautiful.clear_hover, function()
    _G.reset_notifbox_layout()
end)

local delete_button_wrapped = wibox.widget {
    nil,
    {
        delete_button,
        widget = wibox.container.background,
        forced_height = dpi(24),
        forced_width = dpi(24)
    },
    nil,
    expand = 'none',
    layout = wibox.layout.align.vertical
}

return delete_button_wrapped
