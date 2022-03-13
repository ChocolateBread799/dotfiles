local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

    local hourclock = wibox.widget.textclock("%H")
    hourclock.align = "center"
    hourclock.valign = "center"
    hourclock.font = "SF Pro Display Bold 12"

    local minuteclock = wibox.widget.textclock("%M")
    minuteclock.align = "center"
    minuteclock.valign = "center"
    minuteclock.font = "SF Pro Display Bold 12"

    local detailclock = wibox.widget.textclock("%Y %b %d %I:%M %p")
    detailclock.align = "center"
    detailclock.valign = "center"
    detailclock.font = "SF Pro Display 14"

    local date = colorize_icon(beautiful.date_icon, beautiful.icon_normal)

    local date_icon = wibox.widget {
        {
            {
                image = date,
                widget = wibox.widget.imagebox,
                resize = true,
            },
            margins = dpi(12),
            widget = wibox.container.margin
        },
        shape = helpers.rrect(dpi(20)),
        bg = beautiful.icon_bg,
        widget = wibox.container.background
    }

    s.myclock = wibox.widget {
        {
            layout = wibox.layout.align.vertical,
            expand = "none",
            { -- top
                layout = wibox.layout.fixed.vertical,
            },
            { -- middle
                {
                    hourclock, 
                    {
                        minuteclock, 
                        top = 5,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.vertical
                },
                layout = wibox.layout.fixed.vertical, 
            },
        },
        bg = beautiful.icon_bg,
        shape = helpers.rrect(25),
        forced_height = 70,
        widget = wibox.container.background,
    }

    s.myclock:connect_signal("mouse::enter", function()
        clock_toggle()
        s.myclock.bg = beautiful.hover
    end)

    s.myclock:connect_signal("mouse::leave", function()
        clock_toggle()
        s.myclock.bg = beautiful.icon_bg
    end)

    local detailclock = awful.popup {
        widget = {
            {
                {
                    {
                        {
                            {
                                {
                                    date_icon,
                                    margins = 15,
                                    widget = wibox.container.margin
                                },
                                {
                                    detailclock,
                                    left = 10,
                                    widget = wibox.container.margin
                                },
                                layout = wibox.layout.fixed.horizontal
                            },
                            bg = beautiful.bg,
                            shape = helpers.rrect(25),
                            forced_height = 80,
                            forced_width = 300,
                            widget = wibox.widget.background,
                        },
                        margins = 1,
                        widget = wibox.container.margin
                    },
                    bg = beautiful.border_color,
                    shape = helpers.rrect(25),
                    widget = wibox.widget.background,
                },
                margins = 1,
                widget = wibox.container.margin
            },
            bg = beautiful.bg,
            shape = helpers.rrect(26),
            widget = wibox.widget.background,
        },
        bg = "#0000000",
        visible = false,
        ontop = true,
        x = beautiful.popup_left,
        y =  beautiful.wibar_height - 145,
    }
    
    clock_toggle = function()
        detailclock.visible = not detailclock.visible
    end
return clock