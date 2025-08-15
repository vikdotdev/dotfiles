#!/bin/bash

REPOS_DIR="$HOME/Repositories"
DOT_HOME="$REPOS_DIR/dotfiles"
LOG_DIR="$HOME/.local/share/dotfiles/logs"
CONFIG_DIR="$HOME/.config/dotfiles"
INSTALLATION_MARKER="$HOME/.local/share/dotfiles/installed_system"

ensure_directories() {
    mkdir -p "$LOG_DIR" "$CONFIG_DIR"
}

is_system_installed() {
    [[ -f "$INSTALLATION_MARKER" ]]
}

mark_system_installed() {
    local system="$1"
    mkdir -p "$(dirname "$INSTALLATION_MARKER")"
    echo "$system" > "$INSTALLATION_MARKER"
    echo "$(date)" >> "$INSTALLATION_MARKER"
}

get_installed_system() {
    if [[ -f "$INSTALLATION_MARKER" ]]; then
        head -n1 "$INSTALLATION_MARKER"
    else
        echo "none"
    fi
}
