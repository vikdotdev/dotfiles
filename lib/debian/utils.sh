#!/bin/bash

# Debian-specific utilities - extends the general utilities

package_installed() {
    local package="$1"
    # Try multiple methods to check if package is installed
    dpkg -l "$package" 2>/dev/null | grep -q "^ii" || \
    dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q "install ok installed"
}

install_packages() {
    local packages=("$@")
    
    log_info "Installing packages with apt: ${packages[*]}"
    ensure_sudo
    sudo apt update
    sudo apt install -y "${packages[@]}"
}

remove_packages() {
    local packages=("$@")
    
    log_info "Removing packages with apt: ${packages[*]}"
    ensure_sudo
    sudo apt remove -y "${packages[@]}"
}

update_package_lists() {
    log_info "Updating package lists"
    ensure_sudo
    sudo apt update
}

upgrade_packages() {
    log_info "Upgrading all packages"
    ensure_sudo
    sudo apt update
    sudo apt upgrade -y
}

clean_package_cache() {
    log_info "Cleaning package cache"
    ensure_sudo
    sudo apt clean
    sudo apt autoremove -y
}

get_debian_version() {
    if [[ -f /etc/debian_version ]]; then
        cat /etc/debian_version
    else
        echo "unknown"
    fi
}

is_debian() {
    [[ -f /etc/debian_version ]]
}

get_debian_codename() {
    if command_exists lsb_release; then
        lsb_release -cs
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${VERSION_CODENAME:-unknown}"
    else
        echo "unknown"
    fi
}

package_available() {
    local package="$1"
    apt-cache show "$package" &>/dev/null
}
