export PATH="$PATH:$(du -L "$HOME/.bin/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"


export EDITOR="nvim"
export term="urxvt"
export FILE="vifm"
export BROWSER="chromium"
export READER="zathura"
export SUDO_ASKPASS="rofi_dmenu.sh password -password"

# rofi positional variables
export ROFI_LOC=2
export ROFI_OFFSET=250

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

export XDG_CONFIG_HOME="$HOME/.config" # for bspwm

if [[ "$(tty)" = "/dev/tty1" ]]; then
  startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

