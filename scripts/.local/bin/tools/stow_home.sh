#!/bin/bash

[[ ! -d "$HOME/repos/dotfiles" ]] && echo 'No ~/repos/dotfiles directory found.' && exit 1

dirs=$(ls -I etc "$HOME/repos/dotfiles")
stow --verbose=1 --dir="$HOME/repos/dotfiles" --target="$HOME" $@ $dirs
