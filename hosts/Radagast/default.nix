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
  libredns.enable = false;
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
