# ~/.profile

# Add user's local bin to PATH
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Add dotfiles bin to PATH
DOTFILES_BIN="$HOME/Repositories/dotfiles/bin"
if [ -d "$DOTFILES_BIN" ] && ! echo "$PATH" | grep -q "$DOTFILES_BIN" ; then
    PATH="$DOTFILES_BIN:$PATH"
fi

# Set default editor
export EDITOR=emacs
export VISUAL=emacs

# Source .bashrc if running bash
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# Local machine specific configurations
if [ -f "$HOME/.profile.local" ] ; then
    . "$HOME/.profile.local"
fi
