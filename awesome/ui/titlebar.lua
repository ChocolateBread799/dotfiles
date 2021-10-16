pcall(require, "luarocks.loader")

local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
require("awful.hotkeys_popup.keys")

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    local close = awful.titlebar.widget.closebutton(c)
    local float = awful.titlebar.widget.floatingbutton(c)

    awful.titlebar(c, {position = 'top', size = '55'}):setup{
        {
            {
                wibox.layout.margin(close, 15, 10, 12, 12),
                wibox.layout.margin(float, 0, 0, 12, 12),
                layout = wibox.layout.fixed.horizontal,
                widget
            },
            {
                {
                    align  = 'center',
                    widget = awful.titlebar.widget.titlewidget(c)
                },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
            },
            {
                layout = wibox.layout.fixed.horizontal,
                widget, 
            },
            layout = wibox.layout.align.horizontal
        },
        bottom = 5,
        color = "#272727",
        widget = wibox.container.margin,
    }

    local right = awful.titlebar(c, {
        size            = 20,
        enable_tooltip  = false,
        position        = 'right',
        bg              = "#272727",
    })
    right:setup {
        {
            {
                bg     = "#272727",
                widget = wibox.container.background
            },
            widget = wibox.container.margin
        },
        bg     = "#272727",
        widget = wibox.container.background
    }

    local bottom = awful.titlebar(c, {
        size            = 20,
        enable_tooltip  = false,
        position        = 'bottom',
        bg              = "#272727",
    })
    bottom:setup {
        {
            {
                bg     = "#272727",
                widget = wibox.container.background
            },
            widget = wibox.container.margin
        },
        bg     = "#272727",
        widget = wibox.container.background
    }
end)

