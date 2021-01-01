[ -s "$HOME/.profile.default" ] && . "$HOME/.profile.default"

export EDITOR="emacs -nw"
export GIT_EDITOR="$EDITOR"
export DESKTOP_HOSTNAME="top"
export LAPTOP_HOSTNAME="pad"

# less/man colors
export LESS=-R
export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

[ -s "$HOME/bin/s-kbd" ] && \. "$HOME/bin/s-kbd"
[ -s "$HOME/bin/s-scroll" ] && \. "$HOME/bin/s-scroll"
[ -s "$HOME/.Xmodmap" ] && xmodmap ~/.Xmodmap

export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:`pwd`/Repositories/flutter/bin"
