{ config, pkgs, ... }:

{
  # GPG configuration (~/.gnupg/gpg.conf)
  programs.gpg = {
    enable = true;
    settings = {
      # Add any gpg settings here if needed
    };
  };

  # GPG agent configuration (~/.gnupg/gpg-agent.conf + systemd service)
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 36000;
    maxCacheTtl = 72000;
    extraConfig = ''
      allow-preset-passphrase
      allow-loopback-pinentry
      # This will invoke the prompt in the terminal
      # pinentry-program /usr/bin/pinentry-curses
    '';
  };
}