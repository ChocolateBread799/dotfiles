local dpi = require('beautiful.xresources').apply_dpi
local wibox  = require('wibox')
local awful = require('awful')
local icons = require('icons')
local gears = require("gears")
local helpers = require("helpers")
local beautiful = require("beautiful")

chrome = "google-chrome-stable"
discord = "discocss"
file = "thunar"
netflix = "google-chrome-stable https://www.netflix.com"
setting = "code"
spotify = "spotify"

awful.screen.connect_for_each_screen(function (scr)

   local dock = awful.wibar{
      position = "bottom",
      height = 100,
      width = 600,
      screen = scr,
      visible = true,
      bg = "#00000000",
   }

   local function create_img_widget(image, apps)
      local widget = wibox.widget {
         image = image,
         widget = wibox.widget.imagebox()
      }
      widget:buttons(gears.table.join(awful.button({}, 1, function()
         awful.spawn(apps)
     end)))
      return widget
   end

   local spotify = create_img_widget(icons.png.spotify, spotify)
   local chrome = create_img_widget(icons.png.chrome, chrome)
   local discord = create_img_widget(icons.png.discord, discord)
   local file = create_img_widget(icons.png.file, file)
   local netflix = create_img_widget(icons.png.netflix, netflix)
   local setting = create_img_widget(icons.png.setting, setting)

   dock : setup {
      {
        spotify,
        chrome,
        discord,
        file,
        netflix,
        setting,
        layout = wibox.layout.fixed.horizontal,
      },
    bg = "#ffffff",
    shape = helpers.rrect(beautiful.border_radius * 2),
    widget = wibox.container.background(),
   }

end)