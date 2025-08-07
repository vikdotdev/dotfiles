{ config, pkgs, ... }:

let
  # Override kmonad-toggle to use a specific version
  kmonad-toggle-v11 = pkgs.gnomeExtensions.kmonad-toggle.overrideAttrs (oldAttrs: rec {
    version = "11";
    src = pkgs.fetchFromGitHub {
      owner = "jurf";
      repo = "gnome-kmonad-toggle";
      rev = "v${version}";
      # You'll need to update this hash after trying to build
      sha256 = pkgs.lib.fakeSha256;
    };
  });
in
{
  # KMonad package installation
  home.packages = with pkgs; [
    kmonad
    kmonad-toggle-v11
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
