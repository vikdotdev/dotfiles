# GNOME Desktop Environment system configuration
{ config, pkgs, ... }:

{
  # Enable X11/Wayland support
  services.xserver.enable = true;
  
  # Enable GNOME Display Manager with Wayland
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  
  # Enable GNOME Desktop Manager
  services.desktopManager.gnome.enable = true;
  
  # Exclude unwanted GNOME applications
  environment.gnome.excludePackages = with pkgs; [
    gnome-terminal      # Use wezterm/ghossty instead
    gnome-console       # GNOME Console app (newer terminal)
    gedit               # Text editor
    gnome-text-editor   # GNOME Text Editor (newer version)
    geary               # Email client
    epiphany            # GNOME Web browser
    gnome-tour          # Welcome tour
    yelp                # Help viewer
    gnome-contacts      # Contacts app
    gnome-music         # Music player
    gnome-photos        # Photos app
    totem               # Video player (use VLC instead)
    simple-scan         # Document scanner
    cheese              # GNOME Camera/webcam app
    snapshot            # GNOME Camera app (newer version)
  ];

  # GNOME system packages
  environment.systemPackages = with pkgs; [
    # Desktop Environment - GNOME
    gdm
    gnome-shell
    gnome-session
    gnome-settings-daemon
    gnome-control-center
    nautilus
    gnome-terminal
    mutter
    
    # Wayland utilities (GNOME-related)
    wl-clipboard
    wayland-utils
    xwayland
  ];

  # Configure keymap (works for both X11 and Wayland)
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Wayland-specific settings
  environment.sessionVariables = {
    # Force Wayland for specific applications
    NIXOS_OZONE_WL = "1"; # For Electron apps
    MOZ_ENABLE_WAYLAND = "1"; # For Firefox
    QT_QPA_PLATFORM = "wayland"; # For Qt apps
    SDL_VIDEODRIVER = "wayland"; # For SDL apps
    CLUTTER_BACKEND = "wayland"; # For Clutter apps
    GDK_BACKEND = "wayland"; # For GTK apps
  };
}