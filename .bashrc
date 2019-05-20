# ~/.bashrc

# Disable ctrl-s and ctrl-q.
stty -ixon 

#Allows you to cd into directory merely by typing the directory name.
shopt -s autocd 

# Infinite history.
HISTSIZE= HISTFILESIZE=
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

source /usr/share/nvm/init-nvm.sh

# use vim mode in terminal
set -o vi
