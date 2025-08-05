{ config, pkgs, ... }:

{
  # Laptop-specific configuration (profile 2)
  # Features: KMonad for keyboard remapping, laptop optimizations
  
  home.packages = with pkgs; [
    # Laptop-specific tools
    # (KMonad will be handled by system-level configuration)
  ];

  # Laptop-specific session variables
  home.sessionVariables = {
    DOT_PROFILE = "2";
  };
}