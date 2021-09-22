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

    awful.titlebar(c, {position = 'top', size = '35'}):setup{
        {
            {
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.floatingbutton(c),
                layout = wibox.layout.fixed.horizontal,
                widget
            },
            {
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            {
                layout = wibox.layout.fixed.horizontal,
                widget
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        left = 12,
        right = 12,
        top = 8,
        bottom = 8
    }
end)