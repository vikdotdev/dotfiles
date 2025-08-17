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
    local commands="install build upgrade pull pwd doctor help"
    
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
                local modules="all --list"
                
                # Find all modules with the command script
                if [[ -d "$system_dir" ]]; then
                    while IFS= read -r script; do
                        local module_path=$(dirname "$script")
                        local module_name="${module_path#$system_dir/}"
                        modules="$modules $module_name"
                    done < <(find "$system_dir" -name "$prev" -type f -executable 2>/dev/null)
                fi
                
                COMPREPLY=( $(compgen -W "${modules}" -- ${cur}) )
                ;;
            *)
                # No completion for other commands
                ;;
        esac
    fi
}

complete -F _dot_completions dot