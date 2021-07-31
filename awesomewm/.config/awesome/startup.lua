local awful = require("awful")

awful.spawn.with_shell('xrandr --output DP-2 --mode 3440x1440 --rate 144')
awful.spawn.with_shell('feh --bg-fill /home/vik/Pictures/wallpapers/961101.jpg')
awful.spawn.with_shell('killall compton && compton --vsync opengl')
awful.spawn.with_shell('xset r rate 250 45')
