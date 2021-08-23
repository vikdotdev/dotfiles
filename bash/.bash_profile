[ -s "$HOME/.bash_profile.default" ] && . "$HOME/.bash_profile.default"
[ -s "$HOME/.profile.default" ] && . "$HOME/.profile.default"

if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
