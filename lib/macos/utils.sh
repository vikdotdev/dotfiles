#!/bin/bash

# macOS-specific utilities - extends the general utilities

ensure_homebrew() {
    if ! command_exists brew; then
        log_warning "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

brew_installed() {
    local formula="$1"
    brew list "$formula" &>/dev/null
}

cask_installed() {
    local cask="$1"
    brew list --cask "$cask" &>/dev/null
}

install_formula() {
    local formulas=("$@")

    ensure_homebrew
    log_info "Installing formulas with brew: ${formulas[*]}"
    brew install "${formulas[@]}"
}

install_cask() {
    local casks=("$@")

    ensure_homebrew
    log_info "Installing casks with brew: ${casks[*]}"
    brew install --cask "${casks[@]}"
}

remove_formula() {
    local formulas=("$@")

    log_info "Removing formulas with brew: ${formulas[*]}"
    brew uninstall "${formulas[@]}"
}

update_homebrew() {
    log_info "Updating Homebrew"
    ensure_homebrew
    brew update
}

upgrade_formulas() {
    log_info "Upgrading all formulas"
    ensure_homebrew
    brew upgrade
}

cleanup_homebrew() {
    log_info "Cleaning up Homebrew"
    ensure_homebrew
    brew cleanup
}

get_macos_version() {
    sw_vers -productVersion
}

is_macos() {
    [[ "$OSTYPE" == "darwin"* ]]
}

get_macos_codename() {
    local version=$(sw_vers -productVersion)
    local major=$(echo "$version" | cut -d. -f1)
    local minor=$(echo "$version" | cut -d. -f2)

    case "$major" in
        15) echo "Sequoia" ;;
        14) echo "Sonoma" ;;
        13) echo "Ventura" ;;
        12) echo "Monterey" ;;
        11) echo "Big Sur" ;;
        10)
            case "$minor" in
                15) echo "Catalina" ;;
                14) echo "Mojave" ;;
                13) echo "High Sierra" ;;
                *) echo "unknown" ;;
            esac
            ;;
        *) echo "unknown" ;;
    esac
}

formula_available() {
    local formula="$1"
    brew info "$formula" &>/dev/null
}
