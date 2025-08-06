# Profile-specific configuration for umbra (desktop with NVIDIA)
{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "umbra";

  # NVIDIA drivers with Wayland support
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # Wayland support (handled via environment variables in configuration.nix)
  };

  # NVIDIA-specific Wayland settings
  environment.sessionVariables = {
    # NVIDIA Wayland compatibility
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Profile-specific packages can be added here if needed
  # environment.systemPackages = with pkgs; [
  # ];
}