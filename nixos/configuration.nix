# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    # Hardware config is passed via flake, not imported from file
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname is set in profile-specific configurations

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "Europe/London"; # Adjust to your timezone

  # Select internationalisation properties
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

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
    gnome-terminal    # Use wezterm instead
    gnome-console     # GNOME Console app (newer terminal)
    gedit            # Text editor
    gnome-text-editor # GNOME Text Editor (newer version)
    geary            # Email client
    epiphany         # GNOME Web browser
    gnome-tour       # Welcome tour
    yelp             # Help viewer
    gnome-contacts   # Contacts app
    gnome-music      # Music player
    gnome-photos     # Photos app
    totem            # Video player (use VLC instead)
    simple-scan      # Document scanner
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

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound with pipewire (sound.enable is deprecated)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with 'passwd'
  users.users.vik = {
    isNormalUser = true;
    description = "Viktor Habchak";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Enable experimental Nix features
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  # System packages (minimal set for system functionality)
  environment.systemPackages = with pkgs; [
    # Essential system tools
    wget
    curl
    git
    
    # System administration
    htop
    ncdu
    tldr
    ripgrep
    fd
    
    # Development essentials
    gcc
    gnumake
    cmake
    autoconf
    automake
    libtool
    pkg-config
    patch
    gettext
    clang
    
    # System libraries
    aspell
    aspellDicts.en
    xdg-user-dirs
    renameutils
    unzip
    texlivePackages.scheme-full
    
    # Shell environment
    direnv
    
    # Media and development tools
    imagemagick
    jpegoptim
    
    # Download tools
    yt-dlp
    deluge
    
    # Desktop Environment - GNOME
    gdm
    gnome-shell
    gnome-session
    gnome-settings-daemon
    gnome-control-center
    nautilus
    gnome-terminal
    mutter
    
    # Wayland utilities
    wl-clipboard
    wayland-utils
    xwayland
    
    # Virtualization
    virt-manager
  ];

  # Enable Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };

  # Enable Redis (Valkey)
  services.redis.servers."" = {
    enable = true;
    port = 6379;
  };


  # Enable SSH daemon
  # TODO: This is for VM debugging - remove or secure before production use
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Firewall
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];  # SSH - TODO: Remove when not needed for VM debugging
  networking.firewall.allowedUDPPorts = [ ];

  # System state version - DON'T CHANGE
  system.stateVersion = "24.05"; # Did you read the comment?
}
