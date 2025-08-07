{ config, pkgs, ... }:

{
  # GUI Applications
  home.packages = with pkgs; [
    # Communication & Social
    spotify
    telegram-desktop
    signal-desktop
    slack
    discord
    zapzap         # WhatsApp client
    thunderbird    # Email client
    
    # Productivity & Utilities
    blanket        # Ambient sound app
    smile          # Slideshow maker
    gnome-solanum  # Pomodoro timer
    
    # Media & Graphics
    gimp           # Image editor
    vlc            # Media player
    obs-studio     # Screen recording and streaming
    
    # Audio Production
    reaper         # Digital audio workstation
    jack2          # JACK Audio Connection Kit
    qjackctl       # JACK control GUI
    yabridge       # VST bridge for Linux
    carla          # Audio plugin host
    
    # Download Tools
    yt-dlp         # YouTube downloader
    deluge         # BitTorrent client
    
    # Terminal Emulators
    wezterm        # Terminal emulator
    ghostty        # Fast terminal emulator
  ];

  # Application configuration files
  home.file = {
    ".config/wezterm/wezterm.lua".source = ../../configs/wezterm.lua;
    
    
    
    # Custom application desktop entries
    ".local/share/applications/gimp.desktop".source = ../../configs/desktop-entries/gimp.desktop;
    
    ".local/share/applications/virt-manager.desktop".source = ../../configs/desktop-entries/virt-manager.desktop;
  };

  # Firefox configuration
  programs.firefox = {
    enable = true;
    profiles.default = {
      isDefault = true;
      extraConfig = builtins.readFile ../../configs/firefox/user.js;
      userChrome = builtins.readFile ../../configs/firefox/userChrome.css;
    };
  };
}
