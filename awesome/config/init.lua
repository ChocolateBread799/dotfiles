local beautiful = require("beautiful")
local gears = require("gears")
local gfs = require("gears.filesystem")

require("config.key")
require("config.icons")
require("config.menu")
require("config.notif")

if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)
end