
[[ -f ~/.Xresources ]] && xrdb -merge  -I $HOME/.Xresources

xset r rate 250 44

# initializes .xbindkeys of xbindkeys utility
xbindkeys


# initialize various daemons
greenclip daemon &
transmission-daemon &

exec i3
