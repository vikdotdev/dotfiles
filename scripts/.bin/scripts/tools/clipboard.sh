#!/bin/bash

rofi -location "$ROFI_LOC" -yoffset "$ROFI_OFFSET" -modi "clipboard:greenclip print" -show clipboard -run-command "{cmd}"
