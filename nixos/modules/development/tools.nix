# System-level development tools and services
{ config, pkgs, ... }:

{
  # Development system packages
  environment.systemPackages = with pkgs; [
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
    
    # Media and development tools
    imagemagick
    jpegoptim
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

  # Add user to docker group (assuming 'vik' user)
  users.users.vik.extraGroups = [ "docker" ];
}