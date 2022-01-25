local awful = require('awful')
local conf = awful.util.getdir('config')
local icon = conf .. '/icons/'

local icons = {}

icons.png = {
   me = icon .. "profile.png",
   start = icon .. "start.png",
   startorb = icon .. "StartOrb.png",
   chrome = icon .. "dock/chrome.png",
   file = icon .. "dock/folder.png",
   spotify = icon .. "dock/spotify.png",
   netflix = icon .. "dock/netflix.png",
   vscode = icon .. "dock/vscode.png",
   mail = icon .. "dock/mail.png",
   prev = icon.. "music/prev.png",
   play = icon.. "music/play.png",
   pause = icon.. "music/pause.png",
   next = icon.. "music/next.png",
}

return icons
