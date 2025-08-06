{ config, pkgs, ... }:

{
  # KMonad package installation
  home.packages = with pkgs; [
    kmonad
    # Try the current version first, can be updated if issues persist
    gnomeExtensions.kmonad-toggle
  ];

  # KMonad keyboard configuration (~/.config/kmonad/laptop.kbd)
  home.file.".config/kmonad/laptop.kbd".source = ../configs/kmonad/laptop.kbd;

  # KMonad systemd user service (enabled but not started automatically)
  systemd.user.services.kmonad = {
    Unit = {
      Description = "Launch KMonad";
    };
    Service = {
      Type = "simple";
      StandardOutput = "journal";
      ExecStart = "${pkgs.kmonad}/bin/kmonad %h/.config/kmonad/laptop.kbd";
    };
    Install = {
      # Don't start automatically - use kmonad-toggle extension to start manually
      # WantedBy = [ "default.target" ];
    };
  };
}