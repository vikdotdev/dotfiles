{ config, pkgs, ... }:

{
  # Home Manager basic settings
  home.username = "vik";
  home.homeDirectory = "/home/vik";
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Packages installed to ~/.nix-profile/bin
  home.packages = with pkgs; [
    # This is for tools that are always useful but don't need config
  ];

  # PATH additions - added to ~/.profile
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/Repositories/dotfiles/bin"
    "$HOME/.fly/bin"
    "$HOME/.cargo/bin"
    "$HOME/.local/share/Google/android-studio/bin"
    "$HOME/.local/share/android/cmdline-tools/latest/bin"
    "$HOME/.local/share/android/platform-tools/"
    "$HOME/.local/share/android/tools"
    "$HOME/.local/share/android/tools/bin"
    "$HOME/.local/share/android/emulator"
    "$HOME/.local/share/android/emulator/bin64"
  ];

  # Environment variables - added to ~/.profile
  home.sessionVariables = {
    EDITOR = "emacs";
    GIT_EDITOR = "$EDITOR";
    PAGER = "less";
    LESS = "-R --mouse --wheel-lines=3";
    BROWSER = "firefox";
    WEZTERM_SHELL_SKIP_ALL = "1";
    
    # XDG directories based on config.yml - common to all profiles
    EXT_XDG_NOTES_DIR = "$HOME/Documents/notes";
    EXT_XDG_REPOS_DIR = "$HOME/Repositories";
    EXT_XDG_DOTFILES_DIR = "$HOME/Repositories/dotfiles";
    EXT_XDG_WALLPAPER_DIR = "$(xdg-user-dir PICTURES)/wallpapers/";
    
    # Go paths
    GOBIN = "$HOME/.local/bin";
    GOPATH = "$HOME/.local/share/go";
    
    # Other paths from your profile template
    FLYCTL_INSTALL = "$HOME/.fly";
    ANDROID_INSTALLATION = "$HOME/.local/share/Google/android-studio";
    ANDROID_HOME = "$HOME/.local/share/android";
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
        l = "ls -CF";
        grep = "grep --color=auto";
        diff = "diff --color=auto";
        e = "exit";
        t = "tmux";
        o = "xdg-open";
        open = "xdg-open";
        ch = "chezmoi";
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
        source ${builtins.readFile ../scripts/prompt.sh}
      '';
    };
  };

  # Readline configuration (~/.inputrc)
  home.file.".inputrc".source = ../configs/inputrc;

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
  };
}
