# Radagast
{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../common.nix
    ./disko-config.nix
    ./hardware-configuration.nix
    ../../modules
    ../../users/cycad.nix
    ../../users/fallo.nix
  ];

  # Custom options
  gaming.enable = true;
  niri.enable = true;
  hyprland.enable = true;
  sddm.enable = true;

  boot.loader.limine.enable = true;
  boot.plymouth.enable = true;

  # NVIDIA graphics card GTX 1080
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false; # Open drivers must be disabled for this card
      powerManagement.enable = true;
      powerManagement.finegrained = false;
    };
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  boot = {
    # initrd (initial RAM disk) Early KMS (Kernel Mode Setting)
    # for kenel control of GPU
    initrd.kernelModules = [
      "nvidia" # Nvidia drivers
      "nvidia_drm" # Nvidia Direct Rendering Manager for wayland
      "nvidia_modeset" # Handles display resolution and refresh rate
      "nvidia_uvm" # Nvidia Unified Video Memory shares memory between GPU and CPU
    ];
    kernelParams = [
      "mem_sleep_default=s2idle" # More stable sleep for Nvidia resume
      "nvidia-drm.modeset=1" # For wayland
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Save VRAM data to disk
      "nvidia.NVreg_TemporaryFilePath=/var/tmp" # Path for VRAM data
    ];
  };

  # Network
  networking = {
    hostName = "Radagast";
    networkmanager.enable = true;
    stevenblack = {
      # Local ad and content blocker
      enable = true;
      block = [
        "fakenews"
        "gambling"
      ]; # Options: "fakenews" "gambling" "porn" "social"
      whitelist = [ ];
    };
  };
  opensnitch.enable = true; # OpenSnitch application firewall
  libredns.enable = true;
  services.tailscale.enable = true;

  services.printing.enable = true; # CUPS printing

  users.users.cycad.packages = (
    with pkgs;
    [
      bitwarden-desktop
      firefox
      libreoffice
      obsidian
    ]
  );

  system.stateVersion = "25.11";
}
