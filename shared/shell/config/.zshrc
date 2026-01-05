# ~/.zshrc

# Source common profile (PATH, EDITOR, etc.)
if [ -f "$HOME/.profile" ]; then
    source "$HOME/.profile"
fi

# Source shared aliases
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# History settings
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Zsh completions
autoload -Uz compinit
compinit

# Note: Bash completions don't work in zsh
# TODO: Add proper zsh completions later

# Git prompt (using vcs_info)
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '[%b%u%c] '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'

# Colorful prompt with git info
PROMPT='%F{yellow}%n%f%F{cyan}@%f%F{magenta}%m%f: %F{green}%~%f %F{magenta}${vcs_info_msg_0_}%f%F{cyan}%#%f '

# Tool version manager
if [ -f ~/.local/bin/mise ]; then
    eval "$(~/.local/bin/mise activate zsh)"
fi
