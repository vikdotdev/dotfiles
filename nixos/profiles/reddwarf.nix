# Profile-specific configuration for reddwarf (laptop)
{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "reddwarf";

  # Laptop-specific settings
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 90;
    };
  };

  # Enable touchpad support
  services.xserver.libinput.enable = true;
}
