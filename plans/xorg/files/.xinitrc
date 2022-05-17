xset r rate 250 44
xset s 180 5

[ -x "$(command -v setxkbmap)" ] && setxkbmap -layout us,ua

exec awesome
