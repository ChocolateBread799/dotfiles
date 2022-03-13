local wibox = require('wibox')
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local helpers = require("helpers")
local rubato = require("modules.rubato")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

    local function format_progress_bar(bar, image)
        local image = wibox.widget {
            image = image,
            widget = wibox.widget.imagebox,
            resize = true
        }
        image.forced_height = dpi(8)
        image.forced_width = dpi(8)

        local w = wibox.widget {
            {
                image,
                margins = dpi(32),
                widget = wibox.container.margin
            }, 
            bar, 
            layout = wibox.layout.stack
        }
        return w
    end

    local function create_boxed_widget(widget_to_be_boxed, width, height, radius, bg_color)
        local box_container = wibox.container.background()
        box_container.bg = bg_color
        box_container.forced_height = height
        box_container.forced_width = width
        box_container.shape = helpers.rrect(radius)
        box_container.border_width = beautiful.widget_border_width
        box_container.border_color = beautiful.widget_border_color

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
            color = "#FF000000",
            widget = wibox.container.margin
        }
        return boxed_widget
    end

    -- Info

    local img = wibox.widget.imagebox(beautiful.me)
    img.resize = true
    img.forced_width = dpi(60)
    img.forced_height = dpi(60)

    local text = wibox.widget {
        markup = helpers.colorize_text("Welcome, Chocolatebread!", beautiful.fg_sidebar),
        widget = wibox.widget.textbox,
        font = "Sofia Pro Bold 20"
    }

    local user = wibox.widget {
        markup =  "<span foreground='" .. beautiful.fg_sidebar .."50" .."'> Hello 👋 </span>",
        widget = wibox.widget.textbox,
        font = beautiful.font
    }

    local clock = wibox.widget.textclock(
        "<span foreground='" .. beautiful.fg_sidebar .."50" .."'> 🕑 %I:%M %p </span>", 5
    )
    clock.align = "right"
    clock.valign = "right"
    clock.font = beautiful.font

    local profile = wibox.widget {
        {    
            helpers.vertical_pad(dpi(20)),
            {
                {
                    text,
                    top = dpi(10),
                    left = dpi(30),
                    widget = wibox.container.margin
                },
                {
                    user,
                    top = dpi(10),
                    left = dpi(30),
                    widget = wibox.container.margin
                },
                {
                    clock,
                    top = dpi(10),
                    left = dpi(220),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.fixed.horizontal
    }

    local user_box = create_boxed_widget(profile, dpi(350), dpi(160), dpi(20), beautiful.bg_widget)

    -- Volume

    local volume_bar = require("widgets.volume_arc")
    local volume = format_progress_bar(volume_bar, colorize_icon(beautiful.vol, beautiful.fg_sidebar))

    local volume_details = wibox.widget {
        {
            {
                markup = helpers.colorize_text("Vol", beautiful.fg_sidebar),
                font = "Sofia Pro 15",
                widget = wibox.widget.textbox
            },
            left = dpi(20),
            top = dpi(20),
            widget = wibox.container.margin
        },
        {
            volume,
            left = dpi(50),
            bottom = dpi(15),
            right = dpi(20),
            top = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    }

    local vol_box = create_boxed_widget(volume_details, dpi(160), dpi(160), dpi(20), beautiful.bg_widget)

    apps_volume = function()
        helpers.run_or_raise({class = "Pavucontrol"}, true, "pavucontrol")
    end

    volume:buttons(gears.table.join( -- Left click - Mute / Unmute
    awful.button({}, 1, function() helpers.volume_control(0) end),
    -- Scroll - Increase / Decrease volume
    awful.button({}, 4, function() helpers.volume_control(5) end),
    awful.button({}, 5, function() helpers.volume_control(-5) end)))
    
    -- Cpu

    local cpu_bar = require("widgets.cpu_arc")
    local cpu = format_progress_bar(cpu_bar, colorize_icon(beautiful.cpu, beautiful.fg_sidebar))
    local cpu_details = wibox.widget {
        {
            {
                markup = helpers.colorize_text("Cpu", beautiful.fg_sidebar),
                font = "Sofia Pro 15",
                widget = wibox.widget.textbox
            },
            left = dpi(20),
            top = dpi(20),
            widget = wibox.container.margin
        },
        {
            cpu,
            left = dpi(50),
            bottom = dpi(15),
            right = dpi(20),
            top = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    }

    local cpu_box = create_boxed_widget(cpu_details, dpi(160), dpi(160), dpi(20),  beautiful.bg_widget)

    -- Ram

    local ram_bar = require("widgets.ram_arc")
    local ram = format_progress_bar(ram_bar, colorize_icon(beautiful.ram, beautiful.fg_sidebar))

    local ram_details = wibox.widget {
        {
            {
                markup = helpers.colorize_text("Ram", beautiful.fg_sidebar),
                font = "Sofia Pro 15",
                widget = wibox.widget.textbox
            },
            left = dpi(20),
            top = dpi(20),
            widget = wibox.container.margin
        },
        {
            ram,
            left = dpi(50),
            bottom = dpi(15),
            right = dpi(20),
            top = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    }

    local ram_box = create_boxed_widget(ram_details, dpi(160), dpi(160), dpi(20), beautiful.bg_widget)

    -- Tmp 

    local temp_bar = require("widgets.temp_arc")
    local temp = format_progress_bar(temp_bar, colorize_icon(beautiful.temp, beautiful.fg_sidebar))
    local temp_details = wibox.widget {
        {
            {
                markup = helpers.colorize_text("Temp", beautiful.fg_sidebar),
                font = "Sofia Pro 15",
                widget = wibox.widget.textbox
            },
            left = dpi(20),
            top = dpi(20),
            widget = wibox.container.margin
        },
        {
            temp,
            left = dpi(50),
            bottom = dpi(15),
            right = dpi(20),
            top = dpi(10),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.vertical
    }

    local temp_box = create_boxed_widget(temp_details, dpi(160), dpi(160), dpi(20), beautiful.bg_widget)

    -- sys

    local sys = wibox.widget {
        {
            cpu_box,
            ram_box,
            spacing = dpi(30),
            layout = wibox.layout.fixed.horizontal
        },
        helpers.vertical_pad(dpi(30)),
        {
            temp_box,
            vol_box,
            spacing = dpi(30),
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.vertical
    }

    -- notif

    local notif = require("notifs.notif-center")
    local notif_center = wibox.widget {
        {
            {
                notif,
                margins = dpi(20),
                widget = wibox.container.margin
            },
            bg = beautiful.bg_widget,
            shape = helpers.rrect(dpi(20)),
            forced_height = dpi(500),
            widget = wibox.widget.background
        },
        bottom = dpi(30),
        widget = wibox.container.margin
    }

    local playerctl = require("widgets.playerctl")
    local playerctl_box = create_boxed_widget(playerctl, dpi(540), dpi(160), dpi(20), beautiful.bg_widget)

    -- Search

    local search_text = wibox.widget {
        font = beautiful.font,
        markup = helpers.colorize_text("", beautiful.fg_focus),
        align = "center",
        valign = "center",
        visible = true,
        widget = wibox.widget.textbox()
    }
    
    local search = wibox.widget{
        -- search_bar,
        {
            {
                {
                    {
                        image = beautiful.search_bar_icon,
                        widget = wibox.widget.imagebox
                    },
                    margins = dpi(15),
                    left = dpi(0),
                    widget = wibox.container.margin
                },
                {
                    search_text,
                    bottom = dpi(2),
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal
            },
            left = dpi(15),
            widget = wibox.container.margin
        },
        forced_height = dpi(50),
        forced_width = dpi(520),
        shape = helpers.rrect(dpi(15)),
        bg = beautiful.search_bar,
        widget = wibox.container.background()
        -- layout = wibox.layout.stack
    }

    function sidebar_activate_prompt(action)
        helpers.prompt(action, search_text, prompt, function()
        end)
    end

    search:buttons(gears.table.join(
        awful.button({ }, 1, function ()
            sidebar_activate_prompt("web_search")
        end)
    ))
    
    -- Sidebar

    local sidebar = wibox({
        ontop = true, 
        height = screen_height - dpi(100),
        width = dpi(610),
        screen = screen.primary
    })
    sidebar.bg = "#00000000"
    sidebar.fg = beautiful.fg_normal
    sidebar.y = dpi(50)

    local sidebar_timed = rubato.timed {
        intro = 0.2,
        duration = 0.4,
        easing = rubato.bouncy,
        subscribed = function(pos)
            sidebar.x = pos
        end
    }

    sidebar_normal = function()
        if sidebar.visible == false then
            sidebar.visible = not sidebar.visible
            sidebar_timed.target = dpi(170)
        else
            sidebar_timed.target = -dpi(450)
            sidebar.visible = false
        end
    end

    sidebar_wide = function()
        if sidebar.visible == false then
            sidebar.visible = not sidebar.visible
            sidebar_timed.target = dpi(370)
        else
            sidebar_timed.target = -dpi(450)
            sidebar.visible = false
        end
    end

    sidebar : setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            {
                {
                    {
                        helpers.vertical_pad(dpi(30)),
                        search,
                        helpers.vertical_pad(dpi(30)),
                        {
                            user_box,
                            cpu_box,
                            spacing = dpi(30),
                            layout = wibox.layout.fixed.horizontal
                        },
                        layout  = wibox.layout.fixed.vertical
                    },
                    {
                        helpers.vertical_pad(dpi(30)),
                        {
                            ram_box,
                            temp_box,
                            vol_box,
                            spacing = dpi(30),
                            layout = wibox.layout.fixed.horizontal
                        },
                        layout  = wibox.layout.fixed.vertical
                    },
                    {
                        helpers.vertical_pad(dpi(30)),
                        {
                            playerctl_box,
                            spacing = dpi(30),
                            layout = wibox.layout.fixed.horizontal
                        },
                        layout  = wibox.layout.fixed.vertical
                    },
                    helpers.vertical_pad(dpi(30)),
                    notif_center,
                    helpers.vertical_pad(dpi(30)),
                    layout = wibox.layout.fixed.vertical, 
                },
                layout = wibox.layout.fixed.vertical, 
            },
            nil,
        },
        bg = beautiful.bg_sidebar,
        shape = helpers.rrect(beautiful.dock_radius),
        widget = wibox.container.background
    }