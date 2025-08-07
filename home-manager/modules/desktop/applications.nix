{ config, pkgs, ... }:

let
  # Desktop entry template for hiding applications
  hiddenDesktopEntry = ''
    [Desktop Entry]
    Hidden=true
  '';
in
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
    syncthing      # File synchronization
    gnome-solanum  # Pomodoro timer
    
    # Media & Graphics
    gimp           # Image editor
    vlc            # Media player
    obs-studio     # Screen recording and streaming
    reaper         # Digital audio workstation
    
    
    # Terminal Emulators
    wezterm        # Terminal emulator
    ghostty        # Fast terminal emulator
  ];

  # Application configuration files
  home.file = {
    ".config/wezterm/wezterm.lua".source = ../../configs/wezterm.lua;
    
    # Hide Syncthing desktop entries (use via command line only)
    ".local/share/applications/syncthing.desktop".text = hiddenDesktopEntry;
    ".local/share/applications/syncthing-ui.desktop".text = hiddenDesktopEntry;
    
    
    # Custom GIMP desktop entry
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
    
    # Custom virt-manager desktop entry
    ".local/share/applications/virt-manager.desktop".text = ''
      [Desktop Entry]
      Name=VM Manager
      Comment=Virtual machine manager
      Exec=virt-manager
      Icon=virt-manager
      Type=Application
      Categories=System;
      StartupNotify=true
    '';
  };
}