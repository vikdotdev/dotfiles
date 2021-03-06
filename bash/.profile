[ -s "$HOME/.profile.default" ] && . "$HOME/.profile.default"

export EDITOR="nvim"
export GIT_EDITOR="$EDITOR"
export DESKTOP_HOSTNAME="umbra"
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

export PATH="$PATH:$HOME/.emacs.d/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:`pwd`/Repositories/flutter/bin"
export PATH="$PATH":"$HOME/.pub-cache/bin"

eval "$(gh completion -s bash)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export DENO_INSTALL="/home/vik/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export TERM=xterm-256color

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
