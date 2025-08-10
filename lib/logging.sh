#!/bin/bash

# Unified logging system - logs per command run with timestamps

# Initialize logging for a command (install, build, upgrade)
init_logging() {
    local command="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local logfile="$LOG_DIR/${command}_${timestamp}.log"
    
    ensure_directories
    
    # Export for use in other functions and scripts
    export CURRENT_LOG="$logfile"
    export CURRENT_COMMAND="$command"
    
    # Setup log tee for all output
    exec > >(tee -a "$logfile")
    exec 2> >(tee -a "$logfile" >&2)
    
    log_info "Starting $command operation"
    log_info "Log file: $logfile"
    
    # Log session info
    {
        echo "=== $command operation started at $(date) ==="
        echo "User: $USER"
        echo "Hostname: $(hostname)"
        echo "Working Directory: $(pwd)"
        echo "Profile: $(get_profile 2>/dev/null || echo 'unknown')"
        echo "Silverblue: $IS_SILVERBLUE"
        echo "DOT_HOME: $DOT_HOME"
        echo ""
    } >> "$logfile"
}

# Log command execution with full details
log_command() {
    local cmd=("$@")
    local start_time=$(date)
    
    echo "$(date): Executing: ${cmd[*]}"
    
    if "${cmd[@]}"; then
        local end_time=$(date)
        echo "$(date): Command succeeded (started: $start_time, finished: $end_time)"
        return 0
    else
        local exit_code=$?
        local end_time=$(date)
        echo "$(date): Command failed with exit code $exit_code (started: $start_time, finished: $end_time)"
        return $exit_code
    fi
}

# Log git information for upgrade operations
log_git_info() {
    local repo_path="$1"
    local module="$2"
    
    if [[ -d "$repo_path/.git" ]]; then
        echo "=== Git information for $module ==="
        echo "Repository: $repo_path"
        echo "Current commit:"
        (cd "$repo_path" && git log -1 --oneline) 2>&1
        echo "Remote URL:"
        (cd "$repo_path" && git remote get-url origin) 2>&1
        echo ""
    fi
}

# Simple module initialization (no separate logging)
init_module_logging() {
    local module="$1"
    # Modules no longer create separate logs, just announce themselves
    log_step "Starting module: $module"
}

# Simple module finalization (no separate logging)
finalize_module_logging() {
    local status="$1"
    # Just a separator, no separate log files
    echo ""
}

# Finalize logging
finalize_logging() {
    local status="$1"
    
    if [[ "$status" == "success" ]]; then
        echo "=== Operation completed successfully at $(date) ==="
        log_success "Operation completed successfully"
    else
        echo "=== Operation failed at $(date) ==="
        log_error "Operation failed"
    fi
    
    log_info "Full log available at: $CURRENT_LOG"
    
    # Stop tee redirection
    exec 1>&1
    exec 2>&2
}