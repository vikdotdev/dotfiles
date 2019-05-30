#!/bin/bash

current="$(pamixer --get-volume)"


[[ "$current" -ge "$1" ]] && exit 1
echo $current
