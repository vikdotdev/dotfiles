{ config, pkgs, ... }:

{
  # Fonts
  home.packages = with pkgs; [
    iosevka        # Programming font
  ];
}