local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local icons = require('icons')

local update_interval = 1

local art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "icons/music.png",
    resize = true,
    forced_height = dpi(150),
    forced_width = dpi(150),
    clip_shape = helpers.rrect(15),
    halign = "center",
    widget = wibox.widget.imagebox
}


local title_widget = wibox.widget {
    markup = 'This <i>is</i> a <b>textbox</b>!!!',
    font = "MADE Outer Sans Bold 18",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local art_script = [[
bash -c '
tmp_dir="/tmp/awesomewm/spotify/"
tmp_cover_path=${tmp_dir}"cover.png"
if [ ! -d $tmp_dir  ]; then
    mkdir -p $tmp_dir
fi
link="$(playerctl metadata mpris:artUrl | sed -e 's/open.spotify.com/i.scdn.co/g')"
curl -s "$link" --output $tmp_cover_path
echo $tmp_cover_path
']]

local song_title_cmd = "playerctl metadata title"
local song_title = "rice is cringe"

awful.widget.watch(song_title_cmd, update_interval, function(widget, stdout)
    if not (song_title == stdout) then
        awful.spawn.easy_async_with_shell(art_script, function(out)
            local album_path = out:gsub('%\n', '')
            widget:set_image(gears.surface.load_uncached(album_path))
        end)
        song_title = stdout
    end

    title_widget:set_markup_silently(
        '<span foreground="' .. "#000000" .. '">' .. stdout .. '</span>')

end, art)

    -- icons

    local function create_img_widget(image, command, playpause)
        local widget = wibox.widget {
           image = image,
           forced_height = 40,
           widget = wibox.widget.imagebox()
        }
        widget:buttons(gears.table.join(awful.button({}, 1, function()
           awful.spawn(command)
       end)))
        return widget
     end

     play_command = "playerctl play-pause"
     prev_command = "playerctl previous"
     next_command = "playerctl next"

     local prev = create_img_widget(icons.png.prev, prev_command, false)
     local play = create_img_widget(icons.png.play, play_command, true)
     local next = create_img_widget(icons.png.next, next_command, false)

    -- Hover Effect

    helpers.add_hover_cursor(prev, "hand1")
    helpers.add_hover_cursor(play, "hand1")
    helpers.add_hover_cursor(next, "hand1")
                                       
local spot = wibox.widget {
    {art, layout = wibox.layout.fixed.vertical},
    {
        {
            {
                {
                    nil,
                    {
                        step_function = wibox.container.scroll.step_functions
                            .waiting_nonlinear_back_and_forth,
                        speed = 75,
                        {
                            title_widget,
                            top = 20,
                            bottom = 0,
                            left = 10,
                            right = 10,
                            widget = wibox.container.margin
                        },
                        widget = wibox.container.scroll.horizontal
                    },
                    nil,
                    expand = "outside",
                    layout = wibox.layout.align.horizontal
                },
                left = 5,
                right = 5,
                widget = wibox.container.margin
            },
            {
                nil,
                {
                    prev,
                    play,
                    next,
                    spacing = dpi(40),
                    layout = wibox.layout.fixed.horizontal
                },
                nil,
                expand = "none",
                layout = wibox.layout.align.horizontal
            },
            layout = wibox.layout.align.vertical
        },
        top = dpi(5),
        bottom = dpi(5),
        widget = wibox.container.margin
    },
    layout = wibox.layout.align.vertical
}

return spot
