local gfs = require("gears.filesystem")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

local wibox = require("wibox")
local icons = require('config.icons')

local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local hotkeys_popup = require("awful.hotkeys_popup")
local bling = require("bling")

local dashboard = require("ui.dashboard")

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

bling.widget.tag_preview.enable {
    show_client_content = false,  -- Whether or not to show the client content
    scale = 0.15,                 -- The scale of the previews compared to the screen
    honor_padding = false,        -- Honor padding when creating widget size
    honor_workarea = false,       -- Honor work area when creating widget size
    placement_fn = function(c)    -- Place the widget using awful.placement (this overrides x & y)
        awful.placement.top_left(c, {
            margins = {
                top = 90,
                left = 70
            }
        }) 
    end           
}   

awful.screen.connect_for_each_screen(function(s)

    -- Set tags and default layout
    awful.tag({"Play", "Edit", "Video", "Window", "Enjoy"}, s,   awful.layout.suit.tile)
    
    local taglist_buttons = gears.table.join(
        awful.button({ }, 1, function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
                                  if client.focus then
                                      client.focus:move_to_tag(t)
                                  end
                              end),
        awful.button({ }, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
                                  if client.focus then
                                      client.focus:toggle_tag(t)
                                  end
                              end),
        awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
        awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
    )
    
    taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.rounded_bar,
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = 'text_role',
                                widget = wibox.widget.textbox,
                            },
                            margins = 0,
                            widget = wibox.container.margin,
                        },
                        widget = wibox.container.background,
                    },
                    {
                        id     = 'index_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 7,
                right = 7,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:connect_signal('mouse::enter', function()
                    if #c3:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", c3)
                        awesome.emit_signal("bling::tag_preview::visibility", s, true)
                    end
    
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s, false)
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function(self, c3, index, objects)
            end,
        },
        buttons = taglist_buttons
    }

    -- Clock

    local clock = wibox.widget.textclock(
        '<span> %a %b %d  %I:%M %p </span>', 5
    )

    -- Awesome Icon

    local awesome_icon = wibox.widget {
        {widget = wibox.widget.imagebox, image = icons.png.awesome},
        layout = wibox.container.margin(awesome_icon, 0, 0, 0),
    }

    awesome_icon:buttons(gears.table.join(awful.button({ }, 1, function(c) sidebar_toggle()
    end)))

    -- Tasklist

    tasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing = 10,
            spacing_widget = {
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout  = wibox.layout.flex.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 12,
                right = 12,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    tasklist:buttons(gears.table.join(
        awful.button({}, 1, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", {raise = true})
            end
        end), awful.button({}, 3, function()
            awful.menu.client_list({theme = {width = 150}})
        end), awful.button({}, 2, function() awful.client.focus.byidx(1) end)
    ))

    -- Bar
    
    s.wibar = awful.wibar({
        position = "top",
        x = 0,
        y = 0,
        screen = s,
        height = 50,
        width = 1850,
        bg = "#F1EBDD",
        border_width = 5,
        border_color = "#272727",
        widget = wibox.container.background()
    })

    s.wibar.y = 20
    
    -- Add widgets
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(awesome_icon, 12, 12, 12, 12), 
            wibox.layout.margin(taglist, 7, 7, 6, 6),     
        },
        {
            wibox.layout.margin(tasklist, 7, 7, 6, 6),  
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.layout.margin(control, 0, 0, 8, 8), 
            clock,
        },
    }
end)