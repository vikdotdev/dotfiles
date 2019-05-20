#!/bin/bash
# needs work to make this work properly on my machine
# https://wiki.archlinux.org/index.php/Xrandr
# look into autorandr program which should automatically enable new monitor when it's connected

intern=LVDS1
extern=VGA1

if xrandr | grep "$extern disconnected"; then
    xrandr --output "$extern" --off --output "$intern" --auto
else
    xrandr --output "$intern" --off --output "$extern" --auto
fi
