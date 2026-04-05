# Radagast
{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # ./hardware-configuration.nix
    ../common.nix
    ../../modules
    ../../users/cycad.nix
    ../../users/fallo.nix
  ];

  # Custom options
  gaming.enable = true;
  niri.enable = true;

  boot.loader.limine.enable = true;
  boot.plymouth.enable = true;

  # NVIDIA graphics card GTX 1080
  hardware = {
    graphics = {
      enable = true;
      enable32bit = true;
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
    hostname = "Radagast";
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
  services.tailscale.enable = true;

  console.keyMap = "uk";

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
}
