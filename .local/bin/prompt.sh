#!/bin/bash
# Is used in concunction with another command: rofi_prompt.sh 'Are you sure?' && shutdown 

[ "$(echo -e "No\\nYes" | rofi_dmenu.sh "$1" )" = "Yes" ] && exit 0
