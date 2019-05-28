#!/bin/bash
cat .config/emoji | rofi_dmenu.sh "Which emoji?" | awk '{print $1}' | xclip --selection clipboard
