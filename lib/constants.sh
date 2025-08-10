#!/bin/bash

# Common paths and constants
REPOS_DIR="$HOME/Repositories"
DOT_HOME="$REPOS_DIR/dotfiles"
LOG_DIR="$HOME/.local/share/dotfiles/logs"
CONFIG_DIR="$HOME/.config/dotfiles"
INSTALLATION_MARKER="$HOME/.local/share/dotfiles/installed_system"

# Profile detection
DESKTOP_PROFILE="desktop"
LAPTOP_PROFILE="laptop"

# System detection
FEDORA_VERSION=$(rpm -E %fedora 2>/dev/null || echo "unknown")
IS_SILVERBLUE=false

if command -v rpm-ostree &> /dev/null; then
    IS_SILVERBLUE=true
fi

# Ensure directories exist
ensure_directories() {
    mkdir -p "$LOG_DIR" "$CONFIG_DIR"
}

# Get current profile
get_profile() {
    if [[ -f "$CONFIG_DIR/profile" ]]; then
        cat "$CONFIG_DIR/profile"
    else
        echo "unknown"
    fi
}

# Set profile
set_profile() {
    local profile="$1"
    echo "$profile" > "$CONFIG_DIR/profile"
}

# Check if system is installed
is_system_installed() {
    [[ -f "$INSTALLATION_MARKER" ]]
}

# Mark system as installed
mark_system_installed() {
    local system="$1"
    mkdir -p "$(dirname "$INSTALLATION_MARKER")"
    echo "$system" > "$INSTALLATION_MARKER"
    echo "$(date)" >> "$INSTALLATION_MARKER"
}
