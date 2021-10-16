local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local gfs = require("gears.filesystem")
require("awful.autofocus")

beautiful.init(gfs.get_configuration_dir() .. "theme/theme.lua")

terminal = "wezterm"
browser = "google-chrome-stable"
fm = "thunar"
vscode = "code"
discord = "discord"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

myawesomemenu = {
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
 }
  
myapps = {
    { "File", fm },
    { "Browser", browser },
    { "Editor", vscode },
    { "Kitty", terminal },
    { "Discord", discord }
}

  mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon},
                                      { "apps", myapps},
                                     { "term", terminal }
                                   }
                         })
