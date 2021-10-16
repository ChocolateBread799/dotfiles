pcall(require, "luarocks.loader")
                                              
--[[             
  Special thanks to JavaCafe01                   
  __ ___      _____  ___  ___  _ __ ___   ___ 
 / _` \ \ /\ / / _ \/ __|/ _ \| '_ ` _ \ / _ \
| (_| |\ V  V /  __/\__ \ (_) | | | | | |  __/
\__,_| \_/\_/ \___||___/\___/|_| |_| |_|\___|                                             
]]

-- 📚 Library

local gears = require("gears")
local gfs = require("gears.filesystem")
local awful = require("awful")
local beautiful = require("beautiful")

-- 🎨 Theme

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

-- ✨ Bling

local bling = require("bling")

-- 🐣 Require

require("awful.autofocus")
require("awful.hotkeys_popup.keys")
require("config")
require("ui")

-- 🚀 Launch Script

awful.spawn.with_shell("~/.config/awesome/autostart.sh")

-- 🛑 Signals And Rules

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

client.connect_signal("manage", function (c)
end)

client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

root.keys(globalkeys)

require("signals")
