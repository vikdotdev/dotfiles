#!/bin/bash

cat .config/emoji | rofi_dmenu.sh "emoji" | awk '{print $1}' | xclip -selection clipboard
