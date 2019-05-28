
[[ -f ~/.Xresources ]] && xrdb -merge  -I $HOME/.Xresources

xset r rate 250 44

# initializes .xbindkeys of xbindkeys utility
xbindkeys


# setxkbmap -layout us,ua
# setxkbmap -option 'grp:alt_shift_toggle'

# initialize greepclip daemon
greenclip daemon &

exec i3
