# Disable ctrl-s and ctrl-q.
stty -ixon 

#Allows you to cd into directory merely by typing the directory name.
shopt -s autocd 

# Infinite history.
HISTSIZE= HISTFILESIZE=
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc" # Load shortcut aliases
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"


source /usr/share/nvm/init-nvm.sh

set -o vi

# IMPORTANT: fzf should be specified after vim mode in terminal
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash
[ -f "/usr/share/fzf/completion.bash" ] && source /usr/share/fzf/completion.bash
[ -f "~/.fzf.bash" ] && source ~/.fzf.bash


