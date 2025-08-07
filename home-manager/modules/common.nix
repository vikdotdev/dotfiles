{ config, pkgs, ... }:

{
  imports = [
    ./desktop/gnome.nix
    ./desktop/applications.nix
    ./desktop/syncthing.nix
    ./development/tools.nix
    ./shell/bash.nix
    ./fonts.nix
    ./gpg.nix
  ];
  # Home Manager basic settings
  home.username = "vik";
  home.homeDirectory = "/home/vik";
  home.stateVersion = "25.05";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;
  
  # Allow unfree packages in Home Manager
  nixpkgs.config.allowUnfree = true;

  # Packages installed to ~/.nix-profile/bin
  home.packages = with pkgs; [
  ];

  # PATH additions - added to ~/.profile
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/Repositories/dotfiles/bin"
  ];

  # Environment variables - added to ~/.profile
  home.sessionVariables = {
    EDITOR = "emacs";
    GIT_EDITOR = "$EDITOR";
    PAGER = "less";
    LESS = "-R --mouse --wheel-lines=3";
    BROWSER = "firefox";
    WEZTERM_SHELL_SKIP_ALL = "1";
    
    # XDG directories - common to all profiles
    EXT_XDG_NOTES_DIR = "$HOME/Documents/notes";
    EXT_XDG_REPOS_DIR = "$HOME/Repositories";
    EXT_XDG_DOTFILES_DIR = "$HOME/Repositories/dotfiles";
    EXT_XDG_WALLPAPER_DIR = "$(xdg-user-dir PICTURES)/wallpapers/";
  };

  # Program configurations
  programs = {
  };


  # Custom utility scripts (~/.local/bin/)
  home.file = {
    # Ruby configuration
    ".pryrc".source = ../configs/ruby/.pryrc;
  } // builtins.listToAttrs (map (script: {
    name = ".local/bin/${script}";
    value = {
      source = ../scripts/utils/${script};
      executable = true;
    };
  }) [
    "llm"
    "util-find-replace"
    "util-not-my-files"
    "util-reboot-to-windows"
    "util-screenkey"
  ]);

}
