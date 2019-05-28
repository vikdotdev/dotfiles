#!/bin/bash
# xrandr -q | grep -w connected | awk '{print $1}'
# won't select dual is already on external
chosen=$(echo -e "Native\nExternal\nDual\nManual" | rofi_dmenu.sh "Which monitor?")

case "$chosen" in
    "Native") xrandr --output eDP-1 --auto --output HDMI-1 --off ;;
    "External") xrandr --output HDMI-1 --auto --output eDP-1 --off  ;;
    "Dual") xrandr --output HDMI-1 --auto --output eDP-1 --below HDMI-1 --auto ;;
    "Manual") arandr ;;
esac
