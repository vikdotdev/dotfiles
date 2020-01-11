#!/bin/bash
# xrandr -q | grep -w connected | awk '{print $1}'
# won't select dual if already on external
chosen=$(echo -e "Native\nExternal\nDual\nManual" | rofi_dmenu.sh "Which monitor?")

case "$chosen" in
    "Native") xrandr --output eDP1 --auto --output HDMI2 --off ;;
    "External") xrandr --output HDMI2 --auto --output eDP1 --off  ;;
    "Dual") xrandr --output HDMI2 --auto --output eDP-1 --below HDMI2 --auto ;;
    "Manual") arandr ;;
esac
