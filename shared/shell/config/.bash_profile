# ~/.bash_profile

# Source .profile for environment variables
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Source asdf if available
if [ -d ~/.asdf ] && [ -f ~/.asdf/asdf.sh ]; then
    . ~/.asdf/asdf.sh
fi

# Source mise if available
if [ -f ~/.local/bin/mise ]; then
    eval "$(~/.local/bin/mise activate bash)"
fi
