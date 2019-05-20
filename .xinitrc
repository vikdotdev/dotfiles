
[[ -f ~/.Xresources ]] && xrdb -merge  -I $HOME/.Xresources

xset r rate 250 32 

exec i3
