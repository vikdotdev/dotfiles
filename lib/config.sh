#!/bin/bash

# Module configuration - which modules to run on which profiles

# Ensure constants are loaded
if [[ -z "${DOT_HOME:-}" ]]; then
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    DOT_HOME="$(dirname "$SCRIPT_DIR")"
    source "$DOT_HOME/lib/constants.sh"
fi

# Get current profile
get_current_profile() {
    get_profile
}

# Check if module should run on current profile
should_run_module() {
    local module="$1"
    local profile=$(get_current_profile)
    
    case "$module" in
        kmonad)
            # KMonad only runs on laptop profile
            [[ "$profile" == "$LAPTOP_PROFILE" ]]
            ;;
        nvidia)
            # NVIDIA only runs on desktop profile
            [[ "$profile" == "$DESKTOP_PROFILE" ]]
            ;;
        *)
            # All other modules run on all profiles
            true
            ;;
    esac
}

# Skip module with proper logging and return
skip_module_for_profile() {
    local module="$1"
    local profile=$(get_current_profile)
    
    log_info "Skipping $module (not enabled for $profile profile)"
    finalize_module_logging "success"
    return 0
}

# Check and skip if module shouldn't run on current profile  
check_profile_and_skip() {
    local module="$1"
    
    if ! should_run_module "$module"; then
        skip_module_for_profile "$module"
        return 0
    fi
    
    return 1  # Module should run
}