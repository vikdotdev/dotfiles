# Disable ctrl-s and ctrl-q.
stty -ixon

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

# prompt
export PS1="\[\e[01;34m\]\u\[\e[m\]\[\e[01;33m\]@\[\e[m\]\[\e[01;32m\]\h\[\e[m\] \[\e[01;36m\]\w\[\e[m\] \[\e[01;35m\]\`parse_git_branch\`\[\e[m\]"

[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

set -o vi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=/usr/local/opt/mysql@5.7/bin:/Users/vhabc/.rvm/gems/ruby-2.6.5/bin:/Users/vhabc/.rvm/gems/ruby-2.6.5@global/bin:/Users/vhabc/.rvm/rubies/ruby-2.6.5/bin:/usr/local/opt/imagemagick@6/bin:/Users/vhabc/.config/nvm/versions/node/v12.14.1/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/vhabc/.bin/scripts/tools:/Users/vhabc/.bin/scripts/install:/Users/vhabc/.bin/scripts/polybar/__pycache__:/Users/vhabc/.bin/scripts/polybar:/Users/vhabc/.bin/scripts/qtile:/Users/vhabc/.bin/scripts/deprecated:/Users/vhabc/.bin/scripts:/Users/vhabc/.bin:/usr/local/opt/fzf/bin:/Users/vhabc/.rvm/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
