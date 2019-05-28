#!/bin/bash
# Second argument shoudl be -password
if [ "$2" = "-password" ]; then
  rofi -dmenu -i -no-fixed-num-lines -location $ROFI_LOC -yoffset $ROFI_OFFSET -p "$1" "$2"
else
  rofi -dmenu -i -no-fixed-num-lines -location $ROFI_LOC -yoffset $ROFI_OFFSET -p "$1"
fi
