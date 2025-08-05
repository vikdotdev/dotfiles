{ config, pkgs, ... }:

{
  imports = [
    ../modules/kmonad.nix
  ];

  # Laptop-specific configuration (profile 2)
  # Features: KMonad for keyboard remapping, laptop optimizations
  
  home.packages = with pkgs; [
    # Laptop-specific tools
  ];

  # Laptop-specific session variables
  home.sessionVariables = {
    DOT_PROFILE = "2";
  };
}