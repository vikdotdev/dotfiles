# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    # Hardware config is passed via flake, not imported from file
    ./modules/desktop/gnome.nix
    ./modules/development/tools.nix
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
    extraGroups = [ "networkmanager" "wheel" ];
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
    htop
    ncdu
    tldr
    ripgrep
    fd
    
    # System libraries
    aspell
    aspellDicts.en
    xdg-user-dirs
    renameutils
    unzip
    texlivePackages.scheme-full
    
    # Shell environment
    direnv
    
    # Virtualization
    virt-manager
  ];



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
  system.stateVersion = "25.05";
}
