# ~/.bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:" ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add dotfiles bin to PATH
if ! [[ "$PATH" =~ "$HOME/Repositories/dotfiles/bin:" ]]; then
    PATH="$HOME/Repositories/dotfiles/bin:$PATH"
fi

export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'

# History settings
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

# Editor
export EDITOR=emacs
export VISUAL=emacs

# Git prompt
function parse_git_branch() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == "" ]; then
    STAT=`parse_git_dirty`
    echo "[${BRANCH}${STAT}] "
  else
    echo ""
  fi
}

function parse_git_dirty {
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=""
  if [ "${renamed}" == "0" ]; then bits=">${bits}"; fi
  if [ "${ahead}" == "0" ]; then bits="*${bits}"; fi
  if [ "${newfile}" == "0" ]; then bits="+${bits}"; fi
  if [ "${untracked}" == "0" ]; then bits="?${bits}"; fi
  if [ "${deleted}" == "0" ]; then bits="x${bits}"; fi
  if [ "${dirty}" == "0" ]; then bits="!${bits}"; fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

# Set the colorful prompt
export PS1='\[\e[33m\]\u\[\e[m\]\[\e[36m\]@\[\e[m\]\[\e[35m\]\h\[\e[m\]: \[\e[32m\]\w\[\e[m\] \[\e[m\]\[\e[35m\]$(parse_git_branch)\[\e[m\]\[\e[36m\]\$\[\e[m\] '

# Tool version manager
if [ -f ~/.local/bin/mise ]; then
    eval "$(~/.local/bin/mise activate bash)"
fi
