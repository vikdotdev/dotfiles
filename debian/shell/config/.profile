# ~/.profile

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
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
    source . "$HOME/.profile.local"
fi
