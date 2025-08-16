#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

is_root() {
    [[ $EUID -eq 0 ]]
}

ensure_sudo() {
    if ! sudo -n true 2>/dev/null; then
        log_info "This operation requires sudo privileges"
        sudo -v
    fi
}

download_file() {
    local url="$1"
    local dest="$2"
    local retries="${3:-3}"
    
    for ((i=1; i<=retries; i++)); do
        if curl -L -o "$dest" "$url"; then
            return 0
        else
            log_warning "Download attempt $i/$retries failed"
            sleep 2
        fi
    done
    return 1
}

flatpak_installed() {
    local app="$1"
    flatpak list --app --system 2>/dev/null | grep -q "$app"
}

install_flatpak() {
    local app="$1"
    
    if flatpak_installed "$app"; then
        log_info "Flatpak $app already installed"
        return 0
    fi
    
    log_info "Installing flatpak: $app"
    ensure_sudo
    if sudo flatpak install --system --noninteractive flathub "$app"; then
        log_success "Flatpak $app installed"
        return 0
    else
        log_error "Failed to install flatpak $app"
        return 1
    fi
}

log_command() {
    local cmd=("$@")
    log_info "Executing: ${cmd[*]}"
    if "${cmd[@]}"; then
        return 0
    else
        local ret=$?
        log_error "Command failed with exit code $ret"
        return $ret
    fi
}

ensure_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        log_info "Created directory: $dir"
    fi
}

is_interactive() {
    [[ -t 0 ]]
}
