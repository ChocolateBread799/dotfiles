local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local rubato = require("modules.rubato")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

require("awful.autofocus")

local bling = require("modules.bling")

local function format_progress_bar(bar)
    local w = wibox.widget {
        nil,
        {
            bar, 
            layout = wibox.layout.fixed.horizontal
        },
        expand = "none",
        layout = wibox.layout.align.horizontal
    }
    return w
end

awful.screen.connect_for_each_screen(function(s)

    -- Taglist

         -- buttons

        local taglist_buttons = gears.table.join(
        awful.button({}, 1,
            function(t) t:view_only() end),
        awful.button({modkey}, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end), awful.button({}, 3, awful.tag.viewtoggle),
                                awful.button({modkey}, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end), awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end), awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

    -- Tags
    
    local tag_home = awful.tag.add("Home", {
        icon               = colorize_icon(beautiful.home_selected, beautiful.icon_selected),
        screen             = s,
        layout             = awful.layout.suit.tile,
        selected           = true
    })

    local tag_dashboard = awful.tag.add("Dashboard", {
        icon               = colorize_icon(beautiful.dashboard, beautiful.icon_normal),
        screen             = s,
        layout             = awful.layout.suit.tile,
        selected           = true
    })
        
    local tag_folder = awful.tag.add("Files", {
        icon               = colorize_icon(beautiful.folder, beautiful.icon_normal),
        screen             = s,
        layout             = awful.layout.suit.tile,
    })

    local tag_report = awful.tag.add("Report", {
        icon               = colorize_icon(beautiful.report, beautiful.icon_normal),
        screen             = s,
        layout             = awful.layout.suit.tile,
    })

    local tag_cal = awful.tag.add("Calendar", {
        icon               = colorize_icon(beautiful.cal, beautiful.icon_normal),
        screen             = s,
        layout             = awful.layout.suit.tile,
    })      

    local tag_document = awful.tag.add("Documents", {
        icon               = colorize_icon(beautiful.document, beautiful.icon_normal),
        screen             = s,
        layout             = awful.layout.suit.tile,
    })


    local tag_setting = awful.tag.add("Settings", {
        icon               = colorize_icon(beautiful.settings, beautiful.icon_normal),
        screen             = s,
        layout             = awful.layout.suit.tile,
    })
    
    -- Update tags(suck)

    local update_tags = function(self, c3)

        local update_home = function(self, c3)
            if c3.selected then
                tag_home.icon = colorize_icon(beautiful.home_selected, beautiful.icon_selected)
            else 
                tag_home.icon = colorize_icon(beautiful.home, beautiful.icon_normal)
            end
        end  

        local update_dashboard = function(self, c3)
            if c3.selected then
                tag_dashboard.icon = colorize_icon(beautiful.dashboard_selected, beautiful.icon_selected)
            else 
                tag_dashboard.icon = colorize_icon(beautiful.dashboard, beautiful.icon_normal)
            end
        end  

        local update_folder = function(self, c3)
            if c3.selected then
                tag_folder.icon = colorize_icon(beautiful.folder_selected, beautiful.icon_selected)
            else 
                tag_folder.icon = colorize_icon(beautiful.folder, beautiful.icon_normal)
            end
        end  

        local update_report = function(self, c3)
            if c3.selected then
                tag_report.icon = colorize_icon(beautiful.report_selected, beautiful.icon_selected)
            else 
                tag_report.icon = colorize_icon(beautiful.report, beautiful.icon_normal)
            end
        end        

        local update_cal = function(self, c3)
            if c3.selected then
                tag_cal.icon = colorize_icon(beautiful.cal_selected, beautiful.icon_selected)
            else 
                tag_cal.icon = colorize_icon(beautiful.cal, beautiful.icon_normal)
            end
        end    
                
        local update_document = function(self, c3)
            if c3.selected then
                tag_document.icon = colorize_icon(beautiful.document_selected, beautiful.icon_selected)
            else 
                tag_document.icon = colorize_icon(beautiful.document, beautiful.icon_normal)
            end
        end    

        local update_setting = function(self, c3)
            if c3.selected then
                tag_setting.icon = colorize_icon(beautiful.settings_selected, beautiful.icon_selected)
            else 
                tag_setting.icon = colorize_icon(beautiful.settings, beautiful.icon_normal)
            end
        end     
        update_home(self, c3)
        update_dashboard(self, c3)
        update_folder(self, c3)
        update_report(self, c3)
        update_cal(self, c3)
        update_document(self, c3)
        update_setting(self, c3)
    end

    -- Make Widget

    local active_timed = rubato.timed {
        intro = 0.075,
        duration = 0.2
    }

    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style   = {
            shape = helpers.rrect(dpi(20)),
        },
        layout = {spacing = dpi(10), layout = wibox.layout.fixed.vertical},
        widget_template = {
            {
                {
                    {
                        {
                            id  = 'icon_role',
                            resize = true,
                            valign = "center",
                            halign = "center",
                            widget = wibox.widget.imagebox,
                        },
                        width = dpi(26),
                        widget = wibox.container.constraint
                    },
                    {
                        {
                            id     = 'text_role',
                            widget = wibox.widget.textbox,
                        },
                        widget = wibox.container.margin
                    },
                    spacing = dpi(25),
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = dpi(18),
                right = dpi(17),
                top = dpi(16),
                bottom = dpi(16),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            update_callback = function(self, c3, index, objects)
                update_tags(self,c3)
            end
        },
        buttons = taglist_buttons
    }

    -- Volume

    local headphone = colorize_icon(beautiful.headphone, beautiful.icon_normal)
    local vol_high = colorize_icon(beautiful.vol_high, beautiful.icon_normal)
    local vol_mid = colorize_icon(beautiful.vol_mid, beautiful.icon_normal)
    local vol_low = colorize_icon(beautiful.vol_low, beautiful.icon_normal)
    local vol_muted = colorize_icon(beautiful.vol_muted, beautiful.icon_normal)
    
    local vol = wibox.widget {
        widget = wibox.widget.imagebox
    }

    local volume_icon = wibox.widget {
        {
            vol,
            margins = dpi(16),
            widget = wibox.container.margin
        },
        bg = beautiful.bg,
        shape = helpers.rrect(25),
        widget = wibox.widget.background,
    }

    local headphone_icon = wibox.widget {
        {
            {
                image = headphone,
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

    awesome.connect_signal("signals::volume", function(volume_int, muted)
      if muted then
        vol.image = vol_muted
      elseif volume_int <= 0 then
        vol.image = vol_muted
      elseif volume_int < 35 then
        vol.image = vol_low
      elseif volume_int < 70 then
        vol.image = vol_mid
      else
        vol.image = vol_high
      end
    end)

    local volume_bar = require("widgets.volume_bar")
    local volume = format_progress_bar(volume_bar)
    
    apps_volume = function()
        helpers.run_or_raise({class = "Pavucontrol"}, true, "pavucontrol")
    end
    
    volume_icon:buttons(gears.table.join( -- Left click - Mute / Unmute
    awful.button({}, 1, function() helpers.volume_control(0) end),
    -- Scroll - Increase / Decrease volume
    awful.button({}, 4, function() helpers.volume_control(2) end),
    awful.button({}, 5, function() helpers.volume_control(-2) end)))

    local vol_popup = awful.popup {
        widget = {
            {
            {
                {
                    {
                        {
                            {
                                headphone_icon,
                                margins = dpi(15),
                                widget = wibox.container.margin
                            },
                            {
                                volume,
                                left = dpi(5),
                                right = dpi(20),
                                top = dpi(35),
                                bottom = dpi(35),
                                widget = wibox.container.margin
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                            bg = beautiful.bg,
                            shape = helpers.rrect(dpi(25)),
                            forced_height = dpi(80),
                            forced_width = dpi(300),
                            widget = wibox.widget.background,
                        },
                        margins = dpi(1),
                        widget = wibox.container.margin
                    },
                    bg = beautiful.border_color,
                    shape = helpers.rrect(dpi(25)),
                    widget = wibox.widget.background,
                },
                margins = dpi(1),
                widget = wibox.container.margin
            },
            bg = beautiful.bg,
            shape = helpers.rrect(dpi(26)),
            widget = wibox.widget.background,
        },
        bg = "#0000000",
        visible = false,
        ontop = true,
        x = beautiful.popup_left,
        y =  screen_height - dpi(232),
    }
    
    vol_toggle = function()
        vol_popup.visible = not vol_popup.visible
    end

    volume_icon:connect_signal("mouse::enter", function()
        volume_icon.bg = beautiful.icon_bg
        vol_toggle()
    end)

    volume_icon:connect_signal("mouse::leave", function()
        volume_icon.bg = beautiful.bg
        vol_toggle()
    end)


    -- Power

    local function create_power_box(image, markup, width, height, radius, command, bg_color)
        local image = wibox.widget {
            image = image,
            widget = wibox.widget.imagebox
        }
        image.forced_width = dpi(18)
        image.align = 'center'
        image.halign = 'center'

        local box = wibox.container.background()
        box.bg = bg_color
        box.shape = helpers.rrect(radius)
        box.forced_height = height
        box.forced_width = width

        local text = wibox.widget {
            markup = markup,
            align = 'center',
            valign = 'center',
            font = beautiful.font,
            widget = wibox.widget.textbox
        }

        local boxed_widget = wibox.widget {
            {
                {
                    {
                        nil,
                        {
                            image,
                            left = dpi(10),
                            widget = wibox.container.margin
                        },
                        expand = "none",
                        layout = wibox.layout.align.vertical
                    },
                    {
                        nil,
                        text,
                        layout = wibox.layout.align.vertical,
                        expand = "none"
                    },
                    layout = wibox.layout.align.horizontal
                },
                widget = box
            },
            margins = box_gap,
            color = "#FF000000",
            widget = wibox.container.margin
        }

        box:connect_signal("mouse::enter", function() box.bg = beautiful.bg_selected end)
        box:connect_signal("mouse::leave", function() box.bg = bg_color end)

        box:buttons(gears.table.join(awful.button({}, 1, function() command() end)))

        return boxed_widget
    end

    local shutdown_command  = function() awful.spawn.easy_async_with_shell("shutdown now") end
    local restart_command  = function() awful.spawn.easy_async_with_shell("reboot") end
    local logoff_command  = function() awesome.quit() end

    local shutdown = create_power_box(colorize_icon(beautiful.shutdown, beautiful.icon_normal), "Shutdown", 100, 40, dpi(10), shutdown_command, beautiful.bg)
    local restart = create_power_box(colorize_icon(beautiful.restart, beautiful.icon_normal), "Restart", 100, 40, dpi(10), restart_command, beautiful.bg)
    local logoff = create_power_box(colorize_icon(beautiful.logout, beautiful.icon_normal), "Logoff", 100, 40, dpi(10), logoff_command, beautiful.bg)

    local power_popup = awful.popup {
        widget = {
                {
                    expand = "none",
                    nil,
                    {
                        {
                            shutdown,
                            left = dpi(10),
                            right = dpi(10),
                            widget = wibox.container.margin
                        },
                        {
                            restart,
                            left = dpi(10),
                            right = dpi(10),
                            widget = wibox.container.margin
                        },
                        {
                            logoff,
                            left = dpi(10),
                            right = dpi(10),
                            widget = wibox.container.margin
                        },
                        spacing = dpi(5),
                        layout = wibox.layout.fixed.vertical
                    },
                    layout = wibox.layout.align.vertical
                },
                bg = beautiful.bg,
                shape = helpers.rrect(dpi(20)),
                forced_height = dpi(160),
                forced_width = dpi(150),
                widget = wibox.widget.background,
            },
        bg = "#0000000",
        visible = false,
        ontop = true,
        x = dpi(370),
        y = dpi(820),
    }

    local power_icon = wibox.widget {
        image = colorize_icon(beautiful.dots, beautiful.icon_normal),
        widget = wibox.widget.imagebox,
    }

    local power = wibox.widget {
        {
            power_icon,
            widget = wibox.container.margin
        },
        forced_height = dpi(28),
        widget = wibox.container.background
    }

    power:connect_signal("mouse::enter", function()
        power_icon.image = colorize_icon(beautiful.dots, beautiful.icon_selected)
    end)

    power:connect_signal("mouse::leave", function()
        power_icon.image = colorize_icon(beautiful.dots, beautiful.icon_normal)
    end)

    power:buttons(gears.table.join(awful.button({}, 1, function() 
        power_popup.visible = not power_popup.visible
    end)))

    power_popup:connect_signal("mouse::leave", function()
        power_popup.visible = false
    end)

    -- logo

    local logo_icon = wibox.widget {
        image = beautiful.logo_normal,
        widget = wibox.widget.imagebox,
    }

    local logo = wibox.widget {
        {
            logo_icon,
            widget = wibox.container.margin
        },
        forced_height = dpi(30),
        widget = wibox.container.background
    }

    logo:connect_signal("mouse::enter", function()
        logo_icon.image = beautiful.logo_selected
    end)

    logo:connect_signal("mouse::leave", function()
        logo_icon.image = beautiful.logo_normal
    end)

    local logo_wide = wibox.widget {
        {
            logo_icon,
            widget = wibox.container.margin
        },
        forced_height = dpi(30),
        widget = wibox.container.background
    }

    logo_wide:connect_signal("mouse::enter", function()
        logo_icon.image = beautiful.logo_selected
    end)

    logo_wide:connect_signal("mouse::leave", function()
        logo_icon.image = beautiful.logo_normal
    end)

    -- Awesome_icon

    sidebar_toggle = function()
        if s.mywibox.visible == true then
            sidebar_normal()
        else
            sidebar_wide()
        end
    end

    local awesome_icon = wibox.widget {
    {
        {
            {
                {
                    image = beautiful.profile,
                    widget = wibox.widget.imagebox,
                    resize = true,
                },
                forced_height = dpi(50),
                widget = wibox.container.constraint
            },
            margins = dpi(20),
            widget = wibox.container.margin
        },
        {
            helpers.vertical_pad(10),
                {
                    markup = helpers.colorize_text("ChocolateBread", beautiful.fg_contrast),
                    font = "SF Pro Display Medium 13",
                    widget = wibox.widget.textbox,
                },
                {
                    markup = helpers.colorize_text("User", beautiful.fg_contrast .. "70"),
                    font = "SF Pro Display 9",
                    widget = wibox.widget.textbox,
                },
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.horizontal
        },
        margins = dpi(10),
        widget = wibox.container.margin
    }

    awesome_icon:buttons(gears.table.join(awful.button({ }, 1, function() sidebar_toggle() end)))

    -- sidebar

    local sidebar_icon = wibox.widget {
        {
            {
                image = beautiful.profile,
                widget = wibox.widget.imagebox,
                resize = true,
            },
            forced_height = dpi(60),
            widget = wibox.container.constraint
        },
        margins = dpi(21),
        widget = wibox.container.margin
    }
    sidebar_icon:buttons(gears.table.join(awful.button({ }, 1, function() sidebar_toggle() end)))

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

    -- Wrap

    local wrap_widget = function(w)
        return {
            w,
            left = dpi(20),
            right = dpi(20),
            widget = wibox.container.margin
        }
    end

    -- Darkmode

    local dark_toggle = require("widgets.dark_toggle")
    dark_toggle.forced_width = dpi(50)
    
    local dark_toggle_wide = wibox.widget {
        {
            image = colorize_icon(beautiful.moon, beautiful.fg_normal),
            resize = true,
            forced_height = dpi(28),
            forced_width = dpi(28),
            widget = wibox.widget.imagebox  
        },
        helpers.horizontal_pad(12),
        {
            markup = helpers.colorize_text("Dark Mode", beautiful.fg_normal),
            font = "SF Pro Display Medium 12",
            widget = wibox.widget.textbox,
        },
        {
            dark_toggle,
            left = dpi(20),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal
    }

    -- Bar
    
    s.mywidebox = awful.wibox({
        position = "left",
        screen = s,
        type = "dock",
        width = dpi(300),
        height = screen_height - dpi(100),
        bg = "#0000000",
        visible = false
    })

    s.mywibox = awful.wibar({
        position = "left",
        screen = s,
        type = "dock",
        width = dpi(100),
        height = awful.screen.focused().geometry.height - dpi(100),
        bg = "#0000000",
        visible = true
    })

    -- Add widgets

    s.mywidebox.widget = wibox.widget {
        layout = wibox.layout.stack,
        expand = "none",
        {       -- top
            helpers.vertical_pad(dpi(15)),
            wrap_widget({
                logo_wide,
                left = dpi(15),
                widget = wibox.container.margin
            }),
            helpers.vertical_pad(dpi(150)),
            wrap_widget(s.mytaglist),
            helpers.vertical_pad(dpi(120)),
            {
                layout = wibox.layout.align.horizontal,
                expand = "none",
                nil,
                dark_toggle_wide,
            },
            {
                {
                    awesome_icon,
                    top = dpi(10),
                    widget = wibox.container.margin
                },
                {
                    nil,
                    expand = "none",
                    {
                        power,
                        left = dpi(5),
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.align.vertical
                },
                layout = wibox.layout.fixed.horizontal
            },
            spacing = dpi(10),
            layout = wibox.layout.fixed.vertical,
        },
    }

    s.mywibox.widget = wibox.widget {
        layout = wibox.layout.align.vertical,
        expand = "none",
            { -- top
                wrap_widget({
                    logo,
                    top = dpi(25),
                    left = dpi(15),
                    widget = wibox.container.margin
                }),
                layout = wibox.layout.fixed.vertical, 
            },
            { -- middle
                wrap_widget(s.mytaglist),
                layout = wibox.layout.fixed.vertical, 
            },
            { -- bottom
                wrap_widget({
                    dark_toggle,
                    margins = dpi(5),
                    widget = wibox.container.margin
                }),
                sidebar_icon,
                spacing = dpi(10),
                layout = wibox.layout.fixed.vertical,
            },
        }

    s.mywidebox:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            { -- middle
                s.mywidebox.widget, 
                layout = wibox.layout.fixed.horizontal, 
            },
            nil,
        },
        bg = beautiful.bg,
        shape = helpers.rrect(beautiful.bar_radius),
        widget = wibox.container.background
    }

    s.mywibox:setup {
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            { -- middle
                s.mywibox.widget, 
                layout = wibox.layout.fixed.horizontal, 
            },
            nil,
        },
        bg = beautiful.bg,
        shape = helpers.rrect(beautiful.bar_radius - dpi(2)),
        widget = wibox.container.background
    }

    -- rubato timed

    local wibox_timed = rubato.timed {
        intro = 0.1,
        duration = 0.3,
        easing = rubato.bouncy,
        subscribed = function(pos)
            if s.mywidebox.x == 0 then
                s.mywidebox.x = dpi(30)
            end
            s.mywidebox.x = pos - dpi(300)
        end
    }

    logo:connect_signal("button::press", function()
        s.mywibox.visible = false
        s.mywidebox.visible = true
        wibox_timed.target = 330
        s.mywidebox.x = dpi(30)
        s.mywibox.x = dpi(30)
    end)

    local widebox_timed = rubato.timed {
        intro = 0.1,
        duration = 0.3,
        easing = rubato.bouncy,
        subscribed = function(pos)
            s.mywibox.x = pos - dpi(95)
        end
    }

    logo_wide:connect_signal("button::press", function()
        s.mywidebox.visible = false
        s.mywibox.visible = true
        widebox_timed.target = 125
        s.mywidebox.x = dpi(330)
        s.mywibox.x = dpi(30)
    end)

    -- screen padding
    s.padding = {
        left = dpi(40),
        right = dpi(10), 
        top = dpi(10), 
        bottom = dpi(10)
    }

    s.mywibox.x = dpi(30)
    s.mywidebox.x = dpi(30)
end)
