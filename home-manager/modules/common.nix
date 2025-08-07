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
    ./shell/bash.nix
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

  };


  # Custom utility scripts (~/.local/bin/)
  home.file = {
    
    
    
    
    
    
    
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
