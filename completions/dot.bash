#!/bin/bash

# Bash completion for dot command

_dot_completions() {
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    
    # Get dotfiles directory
    local DOT_HOME="$HOME/Repositories/dotfiles"
    local INSTALLATION_MARKER="$HOME/.local/share/dotfiles/installed_system"
    
    # Check if system is installed
    if [[ ! -f "$INSTALLATION_MARKER" ]]; then
        return 0
    fi
    
    local installed_system=$(head -n1 "$INSTALLATION_MARKER")
    local system_dir="$DOT_HOME/$installed_system"
    
    # Main commands
    local commands="install build upgrade pull sync pwd doctor help"
    
    # If we're on the first argument, complete with commands
    if [[ ${COMP_CWORD} -eq 1 ]]; then
        COMPREPLY=( $(compgen -W "${commands}" -- ${cur}) )
        return 0
    fi
    
    # If we're on the second argument, provide module completions based on the command
    if [[ ${COMP_CWORD} -eq 2 ]]; then
        case "${prev}" in
            install|build|upgrade)
                # Get available modules for this command
                local modules=""
                local modules_map=""  # Store both original and display names
                
                # Find all modules with the command script
                if [[ -d "$system_dir" ]]; then
                    while IFS= read -r script; do
                        local module_path=$(dirname "$script")
                        local module_name="${module_path#$system_dir/}"
                        
                        # Create display name by removing numeric prefixes like "00-", "01-", etc.
                        local display_name="$module_name"
                        display_name="${display_name//\/[0-9][0-9]-//\/}"  # Remove /00- pattern in paths
                        display_name="${display_name#[0-9][0-9]-}"         # Remove 00- at start
                        
                        # Store both for matching
                        modules="$modules $module_name"
                        
                        # If display name differs, also add it for completion
                        if [[ "$display_name" != "$module_name" ]]; then
                            modules="$modules $display_name"
                        fi
                    done < <(find "$system_dir" -name "$prev" -type f -executable 2>/dev/null | sort)
                fi
                
                # Build completion list with custom order
                local all_options="--list all $modules"
                
                # Use compgen but disable sorting with nosort option (bash 4.4+)
                if [[ "${BASH_VERSINFO[0]}" -ge 5 ]] || [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 ]]; then
                    compopt -o nosort 2>/dev/null || true
                fi
                
                # Build COMPREPLY preserving our order
                COMPREPLY=()
                for option in --list all $modules; do
                    if [[ -z "$cur" ]] || [[ "$option" == "$cur"* ]]; then
                        # Skip duplicates
                        local already_added=0
                        for existing in "${COMPREPLY[@]}"; do
                            if [[ "$existing" == "$option" ]]; then
                                already_added=1
                                break
                            fi
                        done
                        if [[ $already_added -eq 0 ]]; then
                            COMPREPLY+=("$option")
                        fi
                    fi
                done
                ;;
            *)
                # No completion for other commands
                ;;
        esac
    fi
}

complete -F _dot_completions dot