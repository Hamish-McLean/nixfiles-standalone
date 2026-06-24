# Radagast
{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../common.nix
    ./disko-data.nix
    ./disko-system.nix
    ./hardware-configuration.nix
    ../../modules
    ../../profiles
    ../../users/cycad.nix
    ../../users/fallo.nix
  ];

  custom.profiles = {
    core.enable = true;
    desktop.enable = true;
    gaming.enable = true;
  };

  custom.modules = {
    network.wakeOnLan.enable = true;
  };

  # Custom options
  niri.enable = true;
  noctalia-greet.enable = true;
  hyprland.enable = false;
  printing.enable = true;
  sddm.enable = false;
  sunshine.enable = true;

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
      nvidiaSettings = true; # NVIDIA GUI configuration tool
      open = false; # Open drivers must be disabled for this card
      package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
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
    kernelModules = [ "uinput" ]; # For keyboard and mouse emulation
    kernelParams = [
      "mem_sleep_default=s2idle" # More stable sleep for Nvidia resume
      "nvidia-drm.modeset=1" # For wayland
      # "nvidia.NVreg_PreserveVideoMemoryAllocations=1" # Save VRAM data to disk
      # "nvidia.NVreg_TemporaryFilePath=/var/tmp" # Path for VRAM data
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
  # opensnitch.enable = true; # OpenSnitch application firewall
  services.tailscale.enable = true;

  # Bluetooth
  hardware = {
    enableRedistributableFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.printing.enable = true; # CUPS printing

  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  programs.ladybird.enable = true;

  users.users.cycad.packages = (
    with pkgs;
    [
      # bitwarden-desktop # Requires insecure electron package in nixpkgs 26.05
      # firefox
      libreoffice
      obsidian
      rustdesk
    ]
  );

  # nixpkgs.config.permittedInsecurePackages = [ "electron-39.8.10" ]; # Required for bitwarden

  system.stateVersion = "25.11";
}
