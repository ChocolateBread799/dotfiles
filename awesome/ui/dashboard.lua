local wibox = require('wibox')
local dpi = require("beautiful.xresources").apply_dpi
local color = require("beautiful.xresources").get_current_theme()
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local gfs = require('gears.filesystem')
local icons = require('config.icons')


local function format_progress_bar(bar, markup)
    local text = wibox.widget {
        markup = markup,
        align = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
    text.forced_height = 30
    text.forced_width = 60
    text.resize = true
    text.font = "Roboto Mono Medium 15"
    bar.forced_width = 250

    local w = wibox.widget {
        nil,
        {text, bar, spacing = dpi(10), layout = wibox.layout.fixed.horizontal},
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

local profile = wibox.widget.imagebox(icons.png.me)
profile.resize = true
profile.forced_height = 100
profile.forced_width = 100

local me = wibox.widget {
    profile,
    left = 125,
    top = 30,
    widget = wibox.container.margin
}

local time = wibox.widget.textclock("%H:%M %p")
time.align = "center"
time.valign = "center"
time.font = "Roboto Mono Medium 30"

local volume_bar = require("widgets.volumebar")

local volume = format_progress_bar(volume_bar, "<span>vol</span>")

local cpu_bar = require("widgets.cpubar")

local cpu = format_progress_bar(cpu_bar, "<span>cpu</span>")

local ram_bar = require("widgets.rambar")

local ram = format_progress_bar(ram_bar, "<span>ram</span>")

local music = require("widgets.spot")

sidebar = wibox({visible = false, ontop = true, type = "dock", screen = screen.primary})
sidebar.bg = "#F1EBDD"
sidebar.fg = "#272727"
sidebar.border_width = 5
sidebar.border_color = "#272727"
sidebar.height = 520
sidebar.width = 350
sidebar.y = 100
sidebar.x = 30

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
    layout = wibox.layout.fixed.vertical,
    {       -- top
        me,
        time,
        spacing = 20,
            layout = wibox.layout.fixed.vertical
    },
    {    -- center
    {
        volume,
        top = 40,
        widget = wibox.container.margin
    },
        cpu,
        ram,
        spacing = 15,
        layout = wibox.layout.fixed.vertical
    },
    {    -- bottom
        {
            music,
            top = 35,
            left = 20,
            right = 20,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    },
}