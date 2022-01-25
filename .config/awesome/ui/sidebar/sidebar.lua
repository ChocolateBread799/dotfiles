local wibox = require('wibox')
local dpi = require("beautiful.xresources").apply_dpi
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local icons = require('icons')
local helpers = require("helpers")

local function format_progress_bar(bar, markup)
    local text = wibox.widget {
        markup = markup,
        align = 'center',
        valign = 'center',
        font = "MADE Outer Sans 10",
        widget = wibox.widget.textbox
    }
    text.forced_height = dpi(36)
    text.forced_width = dpi(36)
    text.resize = true

    bar.forced_height = dpi(50)
    bar.forced_width = dpi(280)
    bar.resize = true

    local w = wibox.widget {
        nil,
        {text, bar, spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = "#ffffff"
    box_container.border_width = 2
    box_container.border_color = beautiful.border_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape = helpers.rrect(30)

    local boxed_widget = wibox.widget {
        {
            {
                nil,
                {
                    nil,
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal
            },
            widget = box_container
        },
        margins = box_gap,
        color = "#00000000",
        widget = wibox.container.margin
    }
    return boxed_widget
end

-- Info

local img = wibox.widget.imagebox(icons.png.me)
img.resize = true
img.forced_width = 60
img.forced_height = 60

local text = wibox.widget {
    markup = "<span><b> Welcome </b></span>",
    widget = wibox.widget.textbox,
    font = "MADE Outer Sans 30"
}

local user = wibox.widget {
    markup =  "<span foreground='" .. "#d5d5d5" .."'> ChocolateBread799 </span>",
    widget = wibox.widget.textbox,
    font = "MADE Outer Sans 15"
}

local profile = wibox.widget {
    {    
        {
            text,
            left = 30,
            widget = wibox.container.margin
        },
        {
            user,
            top = 10,
            left = 30,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    },
    layout = wibox.layout.fixed.horizontal
}

local info = create_boxed_widget(profile, 100, 150, beautiful.bg_widget)

-- Clock

local clock = wibox.widget.textclock(
    "<span foreground='" .. "#000000" .."'> %I:%M %p </span>", 5
)
clock.align = "center"
clock.valign = "center"
clock.font = "MADE Outer Sans 35"

local clock_box = create_boxed_widget(clock, 390 , 100, beautiful.bg_widget)

-- Music

local playerctl = require("widgets.playerctl")

local playerctl_box = create_boxed_widget(playerctl, 390,320, beautiful.bg_widget)

-- Volume

local volume_bar = require("widgets.volume_bar")
local volume = format_progress_bar(volume_bar, "<span foreground='" .. "#d5d5d5" .."'><b>Volume</b></span>")

apps_volume = function()
    helpers.run_or_raise({class = "Pavucontrol"}, true, "pavucontrol")
end

volume:buttons(gears.table.join( -- Left click - Mute / Unmute
awful.button({}, 1, function() helpers.volume_control(0) end),
-- Scroll - Increase / Decrease volume
awful.button({}, 4, function() helpers.volume_control(5) end),
awful.button({}, 5, function() helpers.volume_control(-5) end)))

-- Cpu

local cpu_bar = require("widgets.cpu_bar")

local cpu = format_progress_bar(cpu_bar, "<span foreground='" .. "#d5d5d5" .."'><b>Cpu</b></span>")

-- Ram

local ram_bar = require("widgets.ram_bar")

local ram = format_progress_bar(ram_bar, "<span foreground='" .. "#d5d5d5" .."'><b>Ram</b></span>")

-- Conatiner

local sys = wibox.widget {
    {
        volume,
        top = 10,
        left = 10,
        right = 10,
        widget = wibox.container.margin,
    },
    {
        cpu,
        top = 10,
        left = 10,
        right = 10,
        widget = wibox.container.margin,
    },
    {
        ram,
        top = 10,
        left = 10,
        right = 10,
        widget = wibox.container.margin,
    },
    layout = wibox.layout.flex.vertical,
}

local sys_box = create_boxed_widget(sys, 390, 300, beautiful.bg_widget)

-- Cal

local cal = wibox.widget {
    date = os.date('*t'),
    font = "MADE Outer Sans 15",
    widget = wibox.widget.calendar.month
}

local cal_margin = wibox.widget {
    cal,
    left = dpi(50),
    widget = wibox.container.margin,
}

local cal_box = create_boxed_widget(cal_margin, 390, 300, beautiful.bg_widget)

-- Sidebar

sidebar = wibox({visible = false, ontop = true, screen = screen.primary})
sidebar.bg = "#00000000"
sidebar.fg = "#000000"
sidebar.height = 1020
sidebar.width = 450
sidebar.y = 60

sidebar_show = function()
    sidebar.visible = true
end

sidebar_hide = function()
    sidebar.visible = false
end

sidebar_toggle = function()
    sidebar.visible = not sidebar.visible
end

sidebar : setup {
    {
        {
            {
                layout = wibox.layout.fixed.vertical,
                {       -- top
                    {
                        info,
                        top = 30,
                        left = 30,
                        right = 30,
                        widget = wibox.container.margin,
                    },
                    {
                        clock_box,
                        top = 30,
                        left = 30,
                        right = 30,
                        widget = wibox.container.margin,
                    },
                    layout = wibox.layout.fixed.vertical
                },
                {    -- center
                    {
                        top = 30,
                        widget = wibox.container.margin,
                    },
                    {
                        nil,
                        {
                            playerctl_box,
                            spacing = dpi(5),
                            layout = wibox.layout.fixed.vertical
                        },
                        expand = "none",
                        layout = wibox.layout.align.horizontal
                    },
                    layout = wibox.layout.fixed.vertical
                },
                {    -- bottom
                    nil,
                    {
                        cal_box,
                        top = 30,
                        bottom = 30,
                        widget = wibox.container.margin,
                    },
                    nil,
                    layout = wibox.layout.align.horizontal,
                    expand = "none",
                },
            },
            bg = beautiful.bg,
            widget = wibox.container.background
        },
        bottom = 2,
        right = 2,
        widget = wibox.container.margin
    },
    bg = "#000000",
    widget = wibox.container.background
}