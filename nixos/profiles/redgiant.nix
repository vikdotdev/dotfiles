# Profile-specific configuration for redgiant (laptop with kmonad)
{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "redgiant";

  # Laptop-specific settings
  services.thermald.enable = true;
  
  # Power management with TLP (disable conflicting power-profiles-daemon)
  services.power-profiles-daemon.enable = false;
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
  services.libinput.enable = true;

  # KMonad support - uinput permissions
  users.groups.uinput = {};
  users.users.vik.extraGroups = [ "input" "uinput" ];
  
  # Load uinput module
  boot.kernelModules = [ "uinput" ];
  
  # Udev rules for uinput device permissions
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
}
