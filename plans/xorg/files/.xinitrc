eval $(gnome-keyring-daemon -r -d)
export SSH_AUTH_SOCK
dbus-update-activation-environment --systemd DISPLAY

awesome
