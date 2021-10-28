local awful = require('awful')
local conf = awful.util.getdir('config')
local icon = conf .. '/icons/'

local icons = {}

icons.png = {
   me = icon .. "profile.png",
   start = icon .. "start.png",
   startorb = icon .. "StartOrb.png",
   apps = icon .. "dock/app_drawer_alt.png",
   chrome = icon .. "dock/chrome.png",
   discord = icon .. "dock/discord_alt.png",
   file = icon .. "dock/files.png",
   spotify = icon .. "dock/spotify.png",
   netflix = icon .. "dock/netflix.png",
   setting = icon .. "dock/settings.png",
   shutdown = icon .. "power/Shutdown.png",
   restart = icon .. "power/Restart.png",
   logoff = icon .. "power/Logoff.png",
}

return icons
