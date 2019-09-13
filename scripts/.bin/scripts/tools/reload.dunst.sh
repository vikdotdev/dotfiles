#!/bin/bash

pidof dunst && killall dunst
dunst -config ~/.config/dunst/dunstrc &

notify-send 'Notification daemon restarted.'
