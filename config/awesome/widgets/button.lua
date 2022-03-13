local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local gears = require("gears")

local button = {}

button.create = function(image, size, radius, margin, bg, bg_hover, bg_press,
                         command)
    local button_image = wibox.widget {
        image = image,
        forced_height = size,
        forced_width = size,
        widget = wibox.widget.imagebox
    }

    local button = wibox.widget {
        {button_image, margins = dpi(margin), widget = wibox.container.margin},
        bg = bg,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, dpi(radius))
        end,
        widget = wibox.container.background
    }

    button:connect_signal("button::press", function()
        button.bg = bg_press
        command()
    end)

    button:connect_signal("button::leave", function() button.bg = bg end)
    button:connect_signal("mouse::enter", function() button.bg = bg_hover end)
    button:connect_signal("mouse::leave", function() button.bg = bg end)

    button.update_image = function(image) button_image.image = image end

    return button
end

button.create_widget = function(widget, command)
    local button = wibox.widget {
        {widget, margins = dpi(10), widget = wibox.container.margin},
        bg = beautiful.bg_normal,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, dpi(10))
        end,
        widget = wibox.container.background
    }

    button:connect_signal("button::press", function()
        button.bg = beautiful.bg_very_light
        command()
    end)

    button:connect_signal("button::leave",
                          function() button.bg = beautiful.bg_normal end)
    button:connect_signal("mouse::enter",
                          function() button.bg = beautiful.bg_light end)
    button:connect_signal("mouse::leave",
                          function() button.bg = beautiful.bg_normal end)

    return button
end

button.create_image = function(image, image_hover)
    local image_widget = wibox.widget {
        image = image,
        widget = wibox.widget.imagebox
    }

    image_widget:connect_signal("mouse::enter",
                                function() image_widget.image = image_hover end)
    image_widget:connect_signal("mouse::leave",
                                function() image_widget.image = image end)

    return image_widget
end

button.create_image_onclick = function(image, image_hover, onclick)
    local image = button.create_image(image, image_hover)

    local container = wibox.widget {image, widget = wibox.container.background}

    container:connect_signal("button::press", onclick)

    return container
end

button.create_text = function(color, color_hover, text, font)
    local textWidget = wibox.widget {
        font = font,
        markup = "<span foreground='" .. color .. "'>" .. text .. "</span>",
        widget = wibox.widget.textbox
    }

    textWidget:connect_signal("mouse::enter", function()
        textWidget.markup =
            "<span foreground='" .. color_hover .. "'>" .. text .. "</span>"
    end)
    textWidget:connect_signal("mouse::leave", function()
        textWidget.markup = "<span foreground='" .. color .. "'>" .. text ..
                                "</span>"
    end)

    return textWidget
end

return button