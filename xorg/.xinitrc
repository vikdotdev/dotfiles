[[ -f ~/.Xresources ]] && xrdb -merge  -I $HOME/.Xresources

# caret speed
xset r rate 250 44
# set cursor to arrow
xsetroot -cursor_name left_ptr

# initializes .xbindkeys of xbindkeys utility
xbindkeys

# initialize xmodmap config
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# initialize various daemons
greenclip daemon &
transmission-daemon &
dunst -config ~/.config/dunst/dunstrc &

setxkbmap -model pc105 -layout us,ua -option grp:alt_shift_toggle

exec bspwm
