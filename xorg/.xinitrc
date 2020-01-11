[[ -f ~/.Xresources ]] && xrdb -merge  -I $HOME/.Xresources

# caret speed
xset r rate 250 44
# set cursor to arrow
xsetroot -cursor_name left_ptr

# initializes .xbindkeys of xbindkeys utility
# xbindkeys

# initialize xmodmap config
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# initialize various daemons
greenclip daemon &
transmission-daemon &
dunst -config ~/.config/dunst/dunstrc &

setxkbmap -model pc105 -layout us,ua -option grp:win_space_toggle

exec ~/.xprofile &
exec dwm


# Loop
while true
do
    # Set root title
    sh xsetroot.sh

    # Check battery level
    BATT=$( acpi -b | sed 's/.*[charging|unknown], \([0-9]*\)%.*/\1/gi' )
    STATUS=$( acpi -b | sed 's/.*: \([a-zA-Z]*\),.*/\1/gi' )

    # Update every 10s
    sleep 10s
done &
