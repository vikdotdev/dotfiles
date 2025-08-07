{ config, pkgs, ... }:

{
  # Development packages
  home.packages = with pkgs; [
    # Version Control & Collaboration
    gh                      # GitHub CLI
    git-credential-manager  # Cross-platform git credential helper
    
    # Development IDEs & Editors
    android-studio         # Android development IDE
    emacs-pgtk             # Emacs with pure GTK (better Wayland support)
    chemacs2               # Emacs profile switcher
  ];

  # Git configuration (~/.gitconfig)
  programs.git = {
    enable = true;
    userName = "Viktor Habchak";
    userEmail = "vikdotdev@gmail.com";
    signing = {
      key = "7392D21113383CBB";
      # Uncommment to enable GPG signing
      # signByDefault = true;
    };
    
    aliases = {
      ci = "commit";
      st = "status";
      br = "branch --show-current";
      co = "checkout";
      fe = "fetch";
      di = "diff";
      root = "rev-parse --show-toplevel";
      logo = "log --oneline";
      amend = "commit --amend --no-edit";
    };
    
    extraConfig = {
      core = {
        autocrlf = "input";
      };
      commit = {
        verbose = true;
      };
      github = {
        user = "vikdotdev";
      };
      gpg = {
        program = "gpg";
      };
      credential = {
        helper = "${pkgs.git-credential-manager}/bin/git-credential-manager";
      };
      diff = {
        gpg = {
          textconv = "gpg --no-tty --decrypt";
        };
      };
    };
  };

  # Development application configuration files and scripts
  home.file = {
    # Emacs configuration
    ".config/emacs/init.el".source = ../../configs/emacs/init.el;
    ".config/emacs/config.org".source = ../../configs/emacs/config.org;
    ".emacs-profiles.el".source = ../../configs/emacs/.emacs-profiles.el;
    
    # Custom Android Studio desktop entry
    ".local/share/applications/android-studio.desktop".text = ''
      [Desktop Entry]
      Name=Android Studio
      Comment=Android development IDE
      Exec=android-studio
      Icon=android-studio
      Type=Application
      Categories=Development;IDE;
      StartupNotify=true
    '';
  } // builtins.listToAttrs (map (script: {
    name = ".local/bin/${script}";
    value = {
      source = ../../scripts/utils/${script};
      executable = true;
    };
  }) [
    "git-branch-files-changed"
    "git-default-branch"
    "git-deploy"
    "git-log-changed"
    "git-nuke"
    "git-summary"
  ]);
}