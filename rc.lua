pcall(require, "luarocks.loader")
                                              
-- 📚 Library

local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")
local beautiful = require("beautiful")

-- 🎨 Theme

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

-- ✨ Modules

require("modules")

-- Require

require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("config")
require("ui")
require("notifications")

-- 🚀 Launch Script

local autostart = require("autostart")

-- Signals And Rules

awful.rules.rules = {

  { rule = { },
    properties = { border_width = beautiful.border_width,
                   border_color = beautiful.border_normal,
                   focus = awful.client.focus.filter,
                   raise = true,
                   keys = clientkeys,
                   buttons = clientbuttons,
                   screen = awful.screen.preferred,
                   placement = awful.placement.no_overlap+awful.placement.no_offscreen
   }
  },

  { rule_any = {
    }, properties = { floating = true }},

  { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
  },
}

if awesome.startup_errors then
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = "Error occured",
                   text = awesome.startup_errors })
end

client.connect_signal("manage", function(c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup and not c.size_hints.user_position and
      not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end

end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus",
                    function(c) c.border_color = beautiful.border_focus end)

client.connect_signal("unfocus",
                    function(c) c.border_color = beautiful.border_normal end)

root.keys(globalkeys)

require("signals")
