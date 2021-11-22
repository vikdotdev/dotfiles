local awful = require("awful")
local commands = {
  'xrandr --output DP-2 --mode 3440x1440 --rate 144',
  'util-wallpaper',
  'killall compton || compton --vsync opengl',
  -- 'xset r rate 250 45',
  'xinput set-prop "$(xinput list --name-only | grep -i touchpad)" "libinput Tapping Enabled" 1'
}

for _, command in ipairs(commands) do
  awful.spawn.with_shell(command)
end
