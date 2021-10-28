local awful = require("awful")
local gears = require("gears")

local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then findme = cmd:sub(0, firstspace - 1) end
  awful.spawn.with_shell(string.format(
                             'pgrep -u $USER -x %s > /dev/null || (%s)',
                             findme, cmd), false)
end

-- xrandr

run_once("xrandr --output DP-1 --mode 1920x1080 --rate 164.97 &")

-- picom

run_once("picom --experimental-backends --config " ..
             gears.filesystem.get_configuration_dir() .. "config/picom.conf")

return autostart