[ -s "$HOME/.profile.default" ] && . "$HOME/.profile.default"

# Default variables
export EDITOR="nvim"
export GIT_EDITOR="$EDITOR"
export LESS='-R --mouse --wheel-lines=3'
export ZK_NOTEBOOK_DIR="$HOME/notes"

# Path variables
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin"
export GOBIN="$HOME/.local/bin"

# Custom variables
export HOSTNAME_DESKTOP="umbra"
export HOSTNAME_LAPTOP="reddwarf"

export EXT_XDG_REPOS_DIR="$HOME/repos"
export EXT_XDG_DOTFILES_DIR="$HOME/repos/dotfiles"
export EXT_XDG_NOTES_DIR="$HOME/repos/docs"
export EXT_XDG_WALLPAPER_DIR="$(xdg-user-dir PICTURES)/wallpapers/"

source ~/.nvm/nvm.sh

if [ -x "$(command -v setxkbmap)" ]; then
  setxkbmap -layout us,ua
fi
