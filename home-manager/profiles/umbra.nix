{ config, pkgs, ... }:

{
  # Desktop-specific configuration (profile 1)
  # Features: NVIDIA drivers, desktop applications
  
  home.packages = with pkgs; [
    # Desktop-specific applications
    # (GUI apps will be managed by system packages or flatpak for now)
  ];

  # Desktop-specific session variables
  home.sessionVariables = {
    DOT_PROFILE = "1";
  };
}