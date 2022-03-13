local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local bling = require("modules.bling")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local create_button = function(symbol, color, command, playpause)

    local icon = wibox.widget {
        markup = helpers.colorize_text(symbol, color),
        font = "Font Awesome 5 Free 16",
        align = 'center',
        valign = 'center',
        halign = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        icon,
        forced_height = dpi(50),
        forced_width = dpi(50),
        widget = wibox.container.background
    }

    awesome.connect_signal("bling::playerctl::status", function(playing)
        if playpause then
            if playing then
                icon.markup = helpers.colorize_text("", color)
            else
                icon.markup = helpers.colorize_text("", color)
            end
        end
    end)

    button:buttons(gears.table.join(
                       awful.button({}, 1, function() command() end)))

    button:connect_signal("mouse::enter", function()
        icon.markup = helpers.colorize_text(icon.text, beautiful.fg_sidebar)
    end)

    button:connect_signal("mouse::leave", function()
        icon.markup = helpers.colorize_text(icon.text, color)
    end)

    return button
end

local spot = colorize_icon(beautiful.music_icon, beautiful.fg_sidebar)

local art = wibox.widget {
    image = spot,
    resize = true,
    clip_shape = helpers.squircle(w, h, 3),
    halign = "center",
    widget = wibox.widget.imagebox
}

local title_widget = wibox.widget {
    markup = helpers.colorize_text('No Light?', beautiful.fg_sidebar),
    align = 'center',
    valign = 'center',
    forced_height = dpi(30),
    font = "Sofia Pro SemiBold 20",
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = helpers.colorize_text('No Music?', beautiful.fg_sidebar),
    align = 'center',
    valign = 'center',
    font = "Sofia Pro 10",
    widget = wibox.widget.textbox
}

-- Get Song Info 

Playerctl:connect_signal("metadata",
                       function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(album_path))

    title_widget:set_markup_silently('<span foreground="' .. beautiful.fg_sidebar .. '">' .. title .. '</span>')
    artist_widget:set_markup_silently('<span foreground="' .. beautiful.fg_sidebar.. "90" .. '">' .. artist .. '</span>')
end)

local play_command = function() Playerctl:play_pause() end
local prev_command = function() Playerctl:previous() end
local next_command = function() Playerctl:next() end

local playerctl_play_symbol = create_button("", beautiful.fg_sidebar, play_command, true)
local playerctl_prev_symbol = create_button("", beautiful.fg_sidebar, prev_command, false)
local playerctl_next_symbol = create_button("", beautiful.fg_sidebar, next_command, false)


local info = wibox.widget {
    helpers.vertical_pad(10),
    {
        title_widget,
        left = dpi(30),
        right = dpi(30),
        widget = wibox.container.margin
    },
    {
        artist_widget,
        top = dpi(10),
        widget = wibox.container.margin
    },
    layout = wibox.layout.fixed.vertical
}

local control = wibox.widget {
    playerctl_prev_symbol,
    playerctl_play_symbol,
    playerctl_next_symbol,
    layout = wibox.layout.fixed.horizontal
}

local playerctl = wibox.widget {
    {
        art,
        margins = dpi(30),
        right = dpi(0),
        widget = wibox.container.margin
    },
    {
        layout = wibox.layout.fixed.vertical,
        expand = "none",
        helpers.vertical_pad(dpi(25)),
        info,
        helpers.vertical_pad(dpi(5)),
        {
            nil,
            control,
            nil,
            expand = "none",
            layout = wibox.layout.align.horizontal
        },
    },
    layout = wibox.layout.align.horizontal
}

return playerctl