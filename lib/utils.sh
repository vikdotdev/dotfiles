#!/bin/bash

# Utility functions

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if running as root
is_root() {
    [[ $EUID -eq 0 ]]
}

# Ask for sudo if not root
ensure_sudo() {
    if ! sudo -n true 2>/dev/null; then
        log_info "This operation requires sudo privileges"
        sudo -v
    fi
}



# Download file with retry
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

# Check if package is installed (dnf/rpm-ostree)
package_installed() {
    local package="$1"
    if $IS_SILVERBLUE; then
        rpm-ostree status --json | grep -q "\"$package\""
    else
        rpm -q "$package" >/dev/null 2>&1
    fi
}

# Check if flatpak is installed
flatpak_installed() {
    local app="$1"
    flatpak list --app --system 2>/dev/null | grep -q "$app"
}

# Install packages based on system type
install_packages() {
    local packages=("$@")
    
    if $IS_SILVERBLUE; then
        log_info "Installing packages with rpm-ostree: ${packages[*]}"
        ensure_sudo
        sudo rpm-ostree install "${packages[@]}"
        log_warning "Reboot required to complete package installation"
    else
        log_info "Installing packages with dnf: ${packages[*]}"
        ensure_sudo
        sudo dnf install -y "${packages[@]}"
    fi
}

# Remove packages based on system type
remove_packages() {
    local packages=("$@")
    
    if $IS_SILVERBLUE; then
        log_info "Removing packages with rpm-ostree: ${packages[*]}"
        ensure_sudo
        sudo rpm-ostree override remove "${packages[@]}"
        log_warning "Reboot required to complete package removal"
    else
        log_info "Removing packages with dnf: ${packages[*]}"
        ensure_sudo
        sudo dnf remove -y "${packages[@]}"
    fi
}

# Install flatpak
install_flatpak() {
    local app="$1"
    
    if flatpak_installed "$app"; then
        log_info "Flatpak $app already installed"
        return 0
    fi
    
    log_info "Installing flatpak: $app"
    ensure_sudo
    sudo flatpak install -y --system flathub "$app"
}