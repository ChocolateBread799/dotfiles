local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local bling = require("modules.bling")
local helpers = require("helpers")

local function create_title_button(c, color_focus, color_unfocus, shp)
    local tb = wibox.widget {
        forced_width = dpi(20),
        forced_height = dpi(20),
        bg = color_focus .. 90,
        shape = shp,
        border_color = beautiful.border_color,
        widget = wibox.container.background
    }

    local function update()
        if client.focus == c then
            tb.bg = color_focus
        else
            tb.bg = color_unfocus
        end
    end
    update()

    c:connect_signal("focus", update)
    c:connect_signal("unfocus", update)

    tb:connect_signal("mouse::enter", function() tb.bg = color_focus .. 55 end)
    tb:connect_signal("mouse::leave", function() tb.bg = color_focus end)

    tb.visible = true
    return tb
end

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar

    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        if c.maximized == true then c.maximized = false end
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))
    local borderbuttons = gears.table.join( awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end), awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end))
        
    -- Shapes

        local ci = function(width, height)
            return function(cr) gears.shape.circle(cr, width, height) end
        end

        local co = function(width, height)
            return function(cr) gears.shape.cross(cr, width, height) end
        end

        local bo = function(width, height, radius)
            return function(cr) gears.shape.rounded_rect(cr, width, height, radius) end
        end

        local pl = function(width, height)
            return function(cr) gears.shape.powerline(cr, width, height) end
        end

    -- Buttons

        local close = create_title_button(c, "#FF6057", beautiful.titlebar_unfocused, ci(11, 11))
        close:connect_signal("button::press", function() c:kill() end)

        local float = create_title_button(c, "#FDBD2E", beautiful.titlebar_unfocused, ci(11, 11))
        float:connect_signal("button::press", function() awful.client.floating.toggle(c) end)

        local max = create_title_button(c, "#27C840", beautiful.titlebar_unfocused, ci(11, 11))
        max:connect_signal("button::press", function() c.maximized = not c.maximized end)

    -- 

    local wrap_widget = function(w)
        return {
            w,
            top = 20,
            widget = wibox.container.margin
        }
    end
    
    -- Titlebar

    awful.titlebar(c, {
        position = "top",
        size = 45,
        bg = "#00000000",
    }):setup{
        {
            {
                {
                    {
                        {
                            wrap_widget({
                                close,
                                left = dpi(25),
                                widget = wibox.container.margin
                            }),
                            wrap_widget(float),
                            wrap_widget(max),
                            buttons = buttons,
                            layout = wibox.layout.fixed.horizontal,
                        },
                        bg = beautiful.bg,
                        shape = helpers.prrect(beautiful.border_radius, true, true, false, false),
                        widget = wibox.container.background
                    },
                    left = dpi(1),
                    right = dpi(1),
                    top = dpi(1),
                    widget = wibox.container.margin
                },
                bg = beautiful.border_color,
                shape = helpers.prrect(beautiful.border_radius, true, true, false, false),
                widget = wibox.container.background
            },
            left = dpi(1),
            right = dpi(1),
            top = dpi(1),
            widget = wibox.container.margin
        },
        bg = beautiful.bg,
        shape = helpers.prrect(beautiful.border_radius, true, true, false, false),
        widget = wibox.container.background
    }   
end)


