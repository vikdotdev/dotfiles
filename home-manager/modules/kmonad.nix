{ config, pkgs, ... }:

{
  # KMonad package installation
  home.packages = with pkgs; [
    kmonad
  ];

  # KMonad keyboard configuration (~/.config/kmonad/laptop.kbd)
  home.file.".config/kmonad/laptop.kbd".source = ../configs/kmonad/laptop.kbd;

  # KMonad systemd user service
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
      WantedBy = [ "default.target" ];
    };
  };
}