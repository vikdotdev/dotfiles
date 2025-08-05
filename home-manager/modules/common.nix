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
    # GUI applications - migrated from flatpak
    spotify
    telegram-desktop
    signal-desktop
    slack
    discord
    solanum        # Pomodoro timer (org.gnome.Solanum)
    blanket        # Ambient sound app (com.rafaelmardojai.Blanket)
    zapzap         # WhatsApp client (com.rtosta.zapzap)
    stretchly      # Break reminder app
    wezterm        # Terminal emulator
    syncthing      # File synchronization
    firefox        # Web browser
    thunderbird    # Email client
    gimp           # Image editor
    vlc            # Media player
    android-studio # Android development IDE
    
    # Fonts
    iosevka        # Programming font
    
    # Development tools
    git                     # Version control
    gh                      # GitHub CLI
    git-credential-manager  # Cross-platform git credential helper
    chemacs2                # Emacs profile switcher
    
    # System utilities
    pavucontrol    # PulseAudio volume control GUI
  ];

  # PATH additions - added to ~/.profile
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/Repositories/dotfiles/bin"
    "$HOME/.fly/bin"
    "$HOME/.cargo/bin"
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
  };

  # Program configurations
  programs = {
    # Git configuration (~/.gitconfig)
    git = {
      enable = true;
      userName = "Viktor Habchak";
      userEmail = "vikdotdev@gmail.com";
      signing = {
        key = "7392D21113383CBB";
        # Uncommment to enable GPG signing
        # signByDefault = true;
      };
      
      aliases = {
        ci = "commit";
        st = "status";
        br = "branch --show-current";
        co = "checkout";
        fe = "fetch";
        di = "diff";
        root = "rev-parse --show-toplevel";
        logo = "log --oneline";
        amend = "commit --amend --no-edit";
      };
      
      extraConfig = {
        core = {
          autocrlf = "input";
        };
        commit = {
          verbose = true;
        };
        github = {
          user = "vikdotdev";
        };
        gpg = {
          program = "gpg";
        };
        credential = {
          helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
        };
        diff = {
          gpg = {
            textconv = "gpg --no-tty --decrypt";
          };
        };
      };
    };

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


  # Custom utility scripts (~/.local/bin/)
  home.file = {
    ".inputrc".source = ../configs/inputrc;
    ".config/wezterm/wezterm.lua".source = ../configs/wezterm.lua;
    ".config/user-dirs.dirs".source = ../configs/xdg/user-dirs.dirs;
    ".config/user-dirs.locale".source = ../configs/xdg/user-dirs.locale;
    ".config/emacs/init.el".source = ../configs/emacs/init.el;
    ".config/emacs/config.org".source = ../configs/emacs/config.org;
    ".emacs-profiles.el".source = ../configs/emacs/.emacs-profiles.el;
    
    # GNOME configuration files
    ".config/gtk-3.0/settings.ini".source = ../configs/gnome/settings3.ini;
    ".config/gtk-3.0/gtk.css".source = ../configs/gnome/gtk3.css;
    ".config/gtk-4.0/gtk.css".source = ../configs/gnome/gtk4.css;
    ".config/autostart/windows.desktop".source = ../configs/gnome/windows.desktop;
    ".local/share/pixmaps/windows.png".source = ../configs/gnome/windows.png;
    ".config/dconf/user.ini".source = ../configs/gnome/dconf.ini;
    
    # Ruby configuration
    ".pryrc".source = ../configs/ruby/.pryrc;
  } // builtins.listToAttrs (map (script: {
    name = ".local/bin/${script}";
    value = {
      source = ../scripts/utils/${script};
      executable = true;
    };
  }) [
    "git-branch-files-changed"
    "git-default-branch"
    "git-deploy"
    "git-log-changed"
    "git-nuke"
    "git-summary"
    "llm"
    "util"
    "util-basic-auth"
    "util-curl-n"
    "util-find-replace"
    "util-kill-rails"
    "util-not-my-files"
    "util-reboot-to-windows"
    "util-screenkey"
    "util-temp"
    "util-url"
    "maintenance-install-gnome-shell-go-to-last-workspace"
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
