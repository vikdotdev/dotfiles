#!/bin/bash

[[ ! -d "$HOME/repos/dotfiles" ]] && echo 'No ~/repos/dotfiles directory found.' && exit 1

# -I etc ignores etc folder
DIRS=$(ls -I etc "$HOME/repos/dotfiles")
echo $DIRS
stow --verbose=1 --dir="$HOME/repos/dotfiles" --target="$HOME" $@ $DIRS
