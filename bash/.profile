[ -s "$HOME/.profile.default" ] && . "$HOME/.profile.default"

export EDITOR="nvim"
export GIT_EDITOR="$EDITOR"
export DESKTOP_HOSTNAME="umbra"
export LAPTOP_HOSTNAME="pad"
export LESS='-R --mouse --wheel-lines=3'
export TERM=xterm-256color
export DENO_INSTALL="/home/vik/.deno"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$DENO_INSTALL/bin:$PATH"

eval "$(gh completion -s bash)"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PATH="$PATH:$HOME/.rvm/bin"
