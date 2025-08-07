{ config, pkgs, ... }:

let
  # Desktop entry template for hiding applications
  hiddenDesktopEntry = ''
    [Desktop Entry]
    Hidden=true
  '';
in
{
  imports = [
    ./desktop/gnome.nix
    ./desktop/applications.nix
    ./development/tools.nix
  ];
  # Home Manager basic settings
  home.username = "vik";
  home.homeDirectory = "/home/vik";
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
  
  # Allow unfree packages in Home Manager
  nixpkgs.config.allowUnfree = true;

  # Packages installed to ~/.nix-profile/bin
  home.packages = with pkgs; [
    
    # Fonts
    iosevka        # Programming font
    
    
    # System utilities
  ];

  # PATH additions - added to ~/.profile
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/Repositories/dotfiles/bin"
  ];

  # Environment variables - added to ~/.profile
  home.sessionVariables = {
    EDITOR = "emacs";
    GIT_EDITOR = "$EDITOR";
    PAGER = "less";
    LESS = "-R --mouse --wheel-lines=3";
    BROWSER = "firefox";
    WEZTERM_SHELL_SKIP_ALL = "1";
    
    # XDG directories - common to all profiles
    EXT_XDG_NOTES_DIR = "$HOME/Documents/notes";
    EXT_XDG_REPOS_DIR = "$HOME/Repositories";
    EXT_XDG_DOTFILES_DIR = "$HOME/Repositories/dotfiles";
    EXT_XDG_WALLPAPER_DIR = "$(xdg-user-dir PICTURES)/wallpapers/";
  };

  # Program configurations
  programs = {

    # GPG configuration (~/.gnupg/gpg.conf)
    gpg = {
      enable = true;
      settings = {
        # Add any gpg settings here if needed
      };
    };

    # Bash configuration (~/.bashrc, ~/.bash_profile, ~/.profile)
    bash = {
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
        ${builtins.readFile ../scripts/prompt.sh}
      '';
    };
  };


  # Custom utility scripts (~/.local/bin/)
  home.file = {
    ".inputrc".source = ../configs/inputrc;
    
    
    
    
    
    
    
    # Ruby configuration
    ".pryrc".source = ../configs/ruby/.pryrc;
  } // builtins.listToAttrs (map (script: {
    name = ".local/bin/${script}";
    value = {
      source = ../scripts/utils/${script};
      executable = true;
    };
  }) [
    "llm"
    "util-find-replace"
    "util-not-my-files"
    "util-reboot-to-windows"
    "util-screenkey"
    "util-temp"
  ]);

  # Firefox configuration
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extraConfig = builtins.readFile ../configs/firefox/user.js;
      userChrome = builtins.readFile ../configs/firefox/userChrome.css;
    };
  };


  # Services configuration
  services = {
    # GPG agent configuration (~/.gnupg/gpg-agent.conf + systemd service)
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 36000;
      maxCacheTtl = 72000;
      extraConfig = ''
        allow-preset-passphrase
        allow-loopback-pinentry
        # This will invoke the prompt in the terminal
        # pinentry-program /usr/bin/pinentry-curses
      '';
    };

    # Syncthing file synchronization service
    syncthing = {
      enable = true;
    };
  };
}
