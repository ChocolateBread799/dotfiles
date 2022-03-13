local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Set colors
local active_color = beautiful.icon_selected .. "80"

local background_color = "#ffffff"

local ram_bar = wibox.widget {
    max_value = 100,
    value = 50,
    forced_height = dpi(30),
    forced_width = dpi(350),
    shape =  helpers.rrect(dpi(15)),
    bar_shape =  helpers.rrect(dpi(15)),
    color = active_color,
    background_color = background_color,
    widget = wibox.widget.progressbar
}

local update_interval = 1

local ram_script = [[
  sh -c "
  free -m | grep 'Mem:' | awk '{printf \"%d@@%d@\", $7, $2}'
  "]]

awesome.connect_signal("signals::ram", function(used, total)
    local used_ram_percentage = (used / total) * 100
    ram_bar.value = used_ram_percentage
end)

return ram_bar