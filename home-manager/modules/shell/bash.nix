{ config, pkgs, ... }:

{
  # Bash configuration (~/.bashrc, ~/.bash_profile, ~/.profile)
  programs.bash = {
    enable = true;
    enableCompletion = true;
    
    # Your custom shell options
    shellOptions = [
      "autocd"        # cd into directory by typing name
      "dotglob"       # include hidden files in globs
      "histappend"    # append to history
      "checkwinsize"  # check window size
      "extglob"       # extended globbing
      "globstar"      # ** globbing
      "checkjobs"     # check jobs
    ];
    
    # Your custom aliases
    shellAliases = {
      # Your existing custom aliases
      ls = "ls -hN --color=auto --group-directories-first";
      ll = "ls -l";
      la = "ls -A";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      e = "exit";
      o = "xdg-open";
      open = "xdg-open";
      psql = "PAGER='less -S' command psql";
    };
    
    # History configuration matching your setup
    historySize = -1;  # Unlimited
    historyFileSize = -1;  # Unlimited
    historyControl = [ "ignoreboth" "erasedups" ];
    historyIgnore = [ "pwd" "ls" "ll" "la" ];
    
    # Custom initialization
    initExtra = ''
      # Disable ctrl-s and ctrl-q
      stty -ixon
      
      # Disable CTRL-d
      set -o ignoreeof
      
      # Set terminal
      export TERM=xterm-256color
      
      # Disable command not found prompt
      unset command_not_found_handle
      
      # ASDF integration
      if [ -f "$HOME/.asdf/asdf.sh" ]; then
        . "$HOME/.asdf/asdf.sh"
        . "$HOME/.asdf/completions/asdf.bash"
      fi
      
      # Direnv integration (using profile version)
      if command -v direnv >/dev/null 2>&1; then
        eval "$(direnv hook bash)"
        direnv allow "$HOME/.envrc" 2>/dev/null || true
      fi
      
      # Prompt setup with git functions - using external script to avoid escaping
      ${builtins.readFile ../../scripts/prompt.sh}
    '';
  };

  # Shell-related configuration files
  home.file = {
    ".inputrc".source = ../../configs/inputrc;
  };
}