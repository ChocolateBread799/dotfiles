local awful = require('awful')
local conf = awful.util.getdir('config')
local icon = conf .. '/icons/'

local icons = {}

icons.png = {
   me = icon .. "me.png",
   desktop = icon .. "desktop.png",
   folder = icon .. "folder.png",
   internet = icon .. "internet.png",
   trashbin = icon .. "trashbin.png",
   awesome = icon .. "awesome.png"
}

return icons
