#!/bin/bash
# normally pamixer can go beyond 100% volue,
# this script keeps pamixer volume below argument value
current="$(pamixer --get-volume)"

[[ "$current" -ge "$1" ]] && exit 1
echo $current
