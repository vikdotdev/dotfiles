[ -s "$HOME/.bashrc.default" ] && . "$HOME/.bashrc.default"

# Disable ctrl-s and ctrl-q.
stty -ixon

#Allows you to cd into directory merely by typing the directory name.
shopt -s autocd
shopt -s dotglob

HISTSIZE=
HISTFILESIZE=
export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE="pwd:ls:ll:la"

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}] "
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

alias ls="ls -hN --color=auto --group-directories-first" \
  ll="ls -l" \
  la="ls -A" \
  lal="ll -A" \
  mkd="mkdir -pv" \
  grep="grep --color=auto" \
  diff="diff --color=auto" \
  q="exit" \
  e="emacs &" \
  et="emacs -nw" \
  etc="emacs -nw --with-profile custom" \
  ed="emacs --eval '(dired \"~\")' &" \
  etd="emacs -nw --eval '(dired \"~\")'" \
  mux="tmuxinator" \
  magit='git rev-parse --git-dir > /dev/null 2>&1 && emacs -nw --eval "(magit-status \"$(git rev-parse --show-toplevel)\")"'

export TERM=xterm-256color

export PS1="\[\e[33m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]: \[\e[32m\]\w\[\e[m\] \[\e[36m\]\\$\[\e[m\] "

export PATH="$PATH:$HOME/bin"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$HOME/.rvm/bin:$PATH" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

alias luamake=/home/vik/Repositories/lua-language-server/3rd/luamake/luamake
