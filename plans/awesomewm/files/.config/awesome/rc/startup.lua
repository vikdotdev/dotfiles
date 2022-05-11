local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local util = require("lib.util")

local commands = {
  'util-wallpaper',
  'killall compton || compton --vsync opengl --backend glx --paint-on-overlay',
  'xset s 180 5',
  'xset r rate 250 44'
}

if util.is_desktop() then
  naughty.notify { text = 'desktop' }
  commands = gears.table.join(
    commands,
    {
      'xrandr --output DP-4 --mode 3440x1440 --rate 144.00'
    }
  )
end

if util.is_laptop() then
  commands = gears.table.join(
    commands,
    {
      'xinput set-prop "$(xinput list --name-only | grep -i touchpad)" "libinput Tapping Enabled" 1'
    }
  )
end

for _, command in ipairs(commands) do
  awful.spawn.with_shell(command)
end
