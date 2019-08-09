#!/bin/bash

capacity=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

statusfmt=$(echo "$status" | sed -e "s/,//;s/Discharging/BAT/;s/Not Charging/NOT/;s/Charging/CHR/;s/Unknown/UNK/;s/Full/FUL/;s/ 0*/ /g;s/ :/ /g")

echo $statusfmt $capacity
