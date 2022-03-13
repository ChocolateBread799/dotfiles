local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local button = require("widgets.button") 

local notifbox = {}

notifbox.create = function(icon, n, width)
    local time = os.date("%H:%M")
    local box = {}

    local dismiss = button.create_image_onclick(beautiful.delete, beautiful.delete_hover, function()
        _G.remove_notifbox(box)
    end)
    dismiss.forced_height = dpi(14)
    dismiss.forced_width = dpi(14)

    box = wibox.widget {
        {
            {
                {
                    {
                        {
                            {
                                image = icon,
                                resize = true,
                                clip_shape = helpers.rrect(
                                    beautiful.border_radius - dpi(3)),
                                widget = wibox.widget.imagebox
                            },
                            -- bg = beautiful.xcolor1,
                            strategy = 'exact',
                            height = dpi(40),
                            width = dpi(40),
                            widget = wibox.container.constraint
                        },
                        layout = wibox.layout.align.vertical
                    },
                    top = dpi(13),
                    left = dpi(15),
                    right = dpi(15),
                    bottom = dpi(13),
                    widget = wibox.container.margin
                },
                {
                    {
                        nil,
                        {
                            {
                                {
                                    step_function = wibox.container.scroll
                                        .step_functions
                                        .waiting_nonlinear_back_and_forth,
                                    speed = 50,
                                    {
                                        markup = "<b>" .. n.title .. "</b>",
                                        font = beautiful.font,
                                        align = "left",
                                        widget = wibox.widget.textbox
                                    },
                                    forced_width = dpi(300),
                                    widget = wibox.container.scroll.horizontal
                                },
                                nil,
                                {
                                    {
                                        {
                                            markup = time,
                                            align = "right",
                                            font = beautiful.font,
                                            widget = wibox.widget.textbox
                                        },
                                        left = dpi(30),
                                        widget = wibox.container.margin
                                    },
                                    {
                                        {
                                            dismiss,
                                            halign = "right",
                                            widget = wibox.container.place
                                        },
                                        left = dpi(10),
                                        widget = wibox.container.margin
                                    },
                                    layout = wibox.layout.align.horizontal
                                },
                                layout = wibox.layout.align.horizontal
                            },
                            {
                                markup = n.message,
                                align = "left",
                                font = beautiful.font,
                                widget = wibox.widget.textbox
                            },
                            layout = wibox.layout.fixed.vertical
                        },
                        nil,
                        expand = "none",
                        layout = wibox.layout.align.vertical
                    },
                    margins = dpi(8),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.align.horizontal
            },
            top = dpi(2),
            bottom = dpi(2),
            widget = wibox.container.margin
        },
        bg = "#00000000",
        shape = helpers.rrect(beautiful.border_radius),
        widget = wibox.container.background
    }

    return box
end

return notifbox
