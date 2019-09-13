#!/bin/bash
# Is used in conjunction with another command, for example: rofi_prompt.sh 'Are you sure?' && shutdown

[ "$(echo -e "No\\nYes" | rofi_dmenu.sh "$1" )" = "Yes" ] && exit 0
