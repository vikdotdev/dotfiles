# Disable ctrl-s and ctrl-q.
stty -ixon

#Allows you to cd into directory merely by typing the directory name.
shopt -s autocd
shopt -s dotglob

# Infinite history.
HISTSIZE= HISTFILESIZE=

# removes duplicates from bash history
export HISTCONTROL=ignoreboth:erasedups

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

export PS1="\[\e[01;34m\]\u\[\e[m\]\[\e[01;33m\]@\[\e[m\]\[\e[01;32m\]\h\[\e[m\] \[\e[01;36m\]\w\[\e[m\] \[\e[01;35m\]\`parse_git_branch\`\[\e[m\]"

[ -f "$HOME/aliasrc" ] && source "$HOME/aliasrc"


set -o vi

# IMPORTANT: fzf should be specified after vim mode in terminal
export FZF_DEFAULT_OPTS="--layout=reverse"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f "/usr/share/fzf/key-bindings.bash" ] && source /usr/share/fzf/key-bindings.bash
[ -f "/usr/share/fzf/completion.bash" ] && source /usr/share/fzf/completion.bash
[ -f "~/.fzf.bash" ] && source ~/.fzf.bash

# necessary for android studio to work
# export _JAVA_AWT_WM_NONREPARENTING=1
# wmname LG3D # needs wmname package

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:$HOME/.emacs.d/bin/doom"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

if [ -x "$(command -v s-caps2ctrl-esc)" ]; then
  echo 'No s-caps2ctrl-esc script found.' && exit 1
fi
