{ config, pkgs, ... }:

{
  # Syncthing package
  home.packages = with pkgs; [
    syncthing      # File synchronization
  ];

  # Syncthing file synchronization service
  services.syncthing = {
    enable = true;
  };

  # Hide Syncthing desktop entries (use via command line only)
  home.file = {
    ".local/share/applications/syncthing.desktop".source = ../../configs/desktop-entries/hidden.desktop;
    ".local/share/applications/syncthing-ui.desktop".source = ../../configs/desktop-entries/hidden.desktop;
  };
}