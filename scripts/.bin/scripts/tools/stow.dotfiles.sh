#!/bin/bash

[[ ! -d "$HOME/Repositories/dotfiles" ]] && echo 'No ~/Repositories/dotfiles directory found.' && exit 1

# -I etc ignores etc folder
DIRS=$(ls "$HOME/Repositories/dotfiles")
echo $DIRS
stow --verbose=1 --dir="$HOME/Repositories/dotfiles" --target="$HOME" $@ $DIRS
