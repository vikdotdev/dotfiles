[[ -f ~/.bashrc ]] && . ~/.bashrc

export EDITOR="nvim"
export TERMINAL="rxvt-unicode"

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx
fi

