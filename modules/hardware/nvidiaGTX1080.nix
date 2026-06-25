{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.hardware.nvidiaGTX1080;
in
{
  options.custom.modules.hardware.nvidiaGTX1080 = {
    enable = mkEnableOption "Enable configuration for nvidia GTX 1080";
  };

  config = mkIf cfg.enable {
    boot = {
      # initrd (initial RAM disk) Early KMS (Kernel Mode Setting)
      # for kenel control of GPU
      initrd.kernelModules = [
        "nvidia" # Nvidia drivers
        "nvidia_drm" # Nvidia Direct Rendering Manager for wayland
        "nvidia_modeset" # Handles display resolution and refresh rate
        "nvidia_uvm" # Nvidia Unified Video Memory shares memory between GPU and CPU
      ];
      kernelModules = [ "uinput" ]; # For keyboard and mouse emulation
      kernelParams = [
        "mem_sleep_default=s2idle" # More stable sleep for Nvidia resume
        "nvidia-drm.modeset=1" # For wayland
        # "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Save VRAM data to disk
        # "nvidia.NVreg_TemporaryFilePath=/var/tmp" # Path for VRAM data
      ];
    };

    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true; # NVIDIA GUI configuration tool
        open = false; # Open drivers must be disabled for this card
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        powerManagement.enable = true;
        powerManagement.finegrained = false;
      };
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
