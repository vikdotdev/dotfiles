{ config, pkgs, ... }:

{
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
    thunderbird    # Email client
    gimp           # Image editor
    vlc            # Media player
    android-studio # Android development IDE
    obs-studio     # Screen recording and streaming
    reaper         # Digital audio workstation
    
    # Fonts
    iosevka        # Programming font
    
    # Development tools
    gh                      # GitHub CLI
    git-credential-manager  # Cross-platform git credential helper
    emacs-pgtk              # Emacs with pure GTK (better Wayland support)
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
    
    # XDG directories - common to all profiles
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
    ".config/emacs/init.el".source = ../configs/emacs/init.el;
    ".config/emacs/config.org".source = ../configs/emacs/config.org;
    ".emacs-profiles.el".source = ../configs/emacs/.emacs-profiles.el;
    
    # GNOME configuration files
    ".config/gtk-3.0/settings.ini".source = ../configs/gnome/settings3.ini;
    ".config/gtk-3.0/gtk.css".source = ../configs/gnome/gtk3.css;
    ".config/gtk-4.0/gtk.css".source = ../configs/gnome/gtk4.css;
    ".config/autostart/windows.desktop".source = ../configs/gnome/windows.desktop;
    ".local/share/pixmaps/windows.png".source = ../configs/gnome/windows.png;
    
    # Custom desktop entries
    ".local/share/applications/syncthing.desktop".text = ''
      [Desktop Entry]
      Name=Sync
      Comment=File synchronization
      Exec=syncthing-gtk
      Icon=syncthing
      Type=Application
      Categories=Network;FileTransfer;
      StartupNotify=true
    '';
    
    ".local/share/applications/android-studio.desktop".text = ''
      [Desktop Entry]
      Name=Android Studio
      Comment=Android development IDE
      Exec=android-studio
      Icon=android-studio
      Type=Application
      Categories=Development;IDE;
      StartupNotify=true
    '';
    
    ".local/share/applications/gimp.desktop".text = ''
      [Desktop Entry]
      Name=Image Editor
      Comment=GNU Image Manipulation Program
      Exec=gimp
      Icon=gimp
      Type=Application
      Categories=Graphics;2DGraphics;RasterGraphics;
      StartupNotify=true
      MimeType=image/bmp;image/g3fax;image/gif;image/x-fits;image/x-pcx;image/x-portable-anymap;image/x-portable-bitmap;image/x-portable-graymap;image/x-portable-pixmap;image/x-psd;image/x-sgi;image/x-tga;image/x-xbitmap;image/x-xwindowdump;image/x-xcf;image/x-compressed-xcf;image/x-gimp-gbr;image/x-gimp-pat;image/x-gimp-gih;image/x-sun-raster;image/tiff;image/jpeg;image/x-psp;image/png;image/x-icon;image/x-xpixmap;image/svg+xml;image/x-wmf;image/jp2;image/jpeg2000;image/jpx;image/x-xcursor;
    '';
    
    # Hide htop desktop entry by creating a hidden override
    ".local/share/applications/htop.desktop".text = ''
      [Desktop Entry]
      Hidden=true
    '';
    
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

  # GNOME dconf settings
  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer" "variable-refresh-rate"];
      overlay-key = "";
      dynamic-workspaces = false;
    };
    
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
    
    "org/gnome/desktop/peripherals/keyboard" = {
      repeat-interval = 32;
      delay = 250;
    };
    
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 10;
      focus-mode = "click";
    };
    
    "org/gnome/desktop/wm/keybindings" = {
      raise = [""];
      minimize = [""];
      switch-to-workspace-left = [""];
      switch-to-workspace-right = [""];
      move-to-workspace-left = [""];
      move-to-workspace-right = [""];
      begin-move = [""];
      always-on-top = [""];
      toggle-on-all-workspaces = [""];
      begin-resize = ["<Super>r"];
      toggle-fullscreen = ["<Super>f"];
      switch-windows = [""];
      switch-windows-backward = [""];
      switch-group = ["<Super>i" "<Super>e"];
      switch-group-backward = ["<Shift><Super>i"];
      cycle-windows = [""];
      cycle-windows-backward = [""];
      switch-applications = ["<Super>o" "<Super>w"];
      switch-applications-backward = [""];
      close = ["<Super>d"];
      move-to-center = ["<Super>c"];
      activate-window-menu = ["<Alt>space"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      switch-to-workspace-5 = ["<Super>5"];
      switch-to-workspace-6 = ["<Super>6"];
      switch-to-workspace-7 = ["<Super>7"];
      switch-to-workspace-8 = ["<Super>8"];
      switch-to-workspace-9 = ["<Super>9"];
      switch-to-workspace-10 = ["<Super>0"];
      move-to-workspace-1 = ["<Super><Shift>1"];
      move-to-workspace-2 = ["<Super><Shift>2"];
      move-to-workspace-3 = ["<Super><Shift>3"];
      move-to-workspace-4 = ["<Super><Shift>4"];
      move-to-workspace-5 = ["<Super><Shift>5"];
      move-to-workspace-6 = ["<Super><Shift>6"];
      move-to-workspace-7 = ["<Super><Shift>7"];
      move-to-workspace-8 = ["<Super><Shift>8"];
      move-to-workspace-9 = ["<Super><Shift>9"];
      move-to-workspace-10 = ["<Super><Shift>0"];
    };
    
    "org/gnome/shell/keybindings" = {
      toggle-application-view = ["<Super>a"];
      toggle-message-tray = ["<Super>t"];
      toggle-quick-settings = ["<Super>s"];
      toggle-overview = ["<Super>p"];
      switch-to-application-1 = [""];
      switch-to-application-2 = [""];
      switch-to-application-3 = [""];
      switch-to-application-4 = [""];
      switch-to-application-5 = [""];
      switch-to-application-6 = [""];
      switch-to-application-7 = [""];
      switch-to-application-8 = [""];
      switch-to-application-9 = [""];
      switch-to-application-10 = [""];
      open-new-window-application-1 = [""];
      open-new-window-application-2 = [""];
      open-new-window-application-3 = [""];
      open-new-window-application-4 = [""];
      open-new-window-application-5 = [""];
      open-new-window-application-6 = [""];
      open-new-window-application-7 = [""];
      open-new-window-application-8 = [""];
      open-new-window-application-9 = [""];
    };
    
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = ["<Super>z"];
    };
    
    "org/gnome/desktop/interface" = {
      clock-show-weekday = true;
      clock-show-date = true;
      clock-format = "24h";
      cursor-size = 40;
    };
    
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    
    "org/gnome/shell/extensions/go-to-last-workspace" = {
      shortcut-key = ["<Super>g"];
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
