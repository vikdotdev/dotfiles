xset r rate 250 44
xset s 180 5

[ -x "$(command -v setxkbmap)" ] && setxkbmap -layout us,ua

# only if profile 1
xrandr --output DP-4 --mode 3440x1440 --rate 100.00

# only if profile 2
xinput set-prop "$(xinput list --name-only | grep -i touchpad)" "libinput Tapping Enabled" 1

exec awesome
