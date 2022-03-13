local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local bling = require("modules.bling")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local spot = gears.color.recolor_image(beautiful.music_icon, beautiful.icon_normal)

local art = wibox.widget {
    image = spot,
    resize = true,
    clip_shape = helpers.rrect(dpi(20)),
    halign = "center",
    widget = wibox.widget.imagebox
}

local title_widget = wibox.widget {
    markup = 'No Music',
    align = 'center',
    valign = 'center',
    font = "Sofia Pro Medium 12",
    widget = wibox.widget.textbox
}

local artist_widget = wibox.widget {
    markup = 'No Artist',
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

    title_widget:set_markup_silently(title)
    artist_widget:set_markup_silently(artist)
end)

local play_command = function() Playerctl:play_pause() end
local prev_command = function() Playerctl:previous() end
local next_command = function() Playerctl:next() end

local playerctl = wibox.widget {
    {
        art,
        top = dpi(12),
        bottom = dpi(12),
        left = dpi(12),
        widget = wibox.container.margin
    },
    {
        layout = wibox.layout.align.vertical,
        expand = "none",
        {
            widget = wibox.container.margin
        },
        {
            {
                title_widget,
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            {
                artist_widget,
                top = dpi(5),
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.align.vertical
    },
    layout = wibox.layout.align.horizontal
}

return playerctl