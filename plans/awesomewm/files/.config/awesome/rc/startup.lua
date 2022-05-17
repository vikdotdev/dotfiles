local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local util = require("lib.util")

local commands = {
  'util-wallpaper',
  'sys-compton-restart',
}

if util.is_desktop() then
  naughty.notify { text = 'desktop' }
  commands = gears.table.join(
    commands,
    {
      -- TODO: move to awesome startup script
      'xrandr --output DP-4 --mode 3440x1440 --rate 100.00'
    }
  )
end

if util.is_laptop() then
  commands = gears.table.join(
    commands,
    {
      -- TODO: use xort reset script or a startup script
      'xinput set-prop "$(xinput list --name-only | grep -i touchpad)" "libinput Tapping Enabled" 1'
    }
  )
end

for _, command in ipairs(commands) do
  awful.spawn.with_shell(command)
end
