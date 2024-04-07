{ config, pkgs, unstablePkgs, lib, nixos-hardware, ... }:

{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.raspberry-pi-4
    ../common.nix
  ];

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    loader = {
      grub.enable = false;
      generic-extlinux.compatible.enable = true; # What does this do?
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType =  "ext4";
    options = [ "noatime" ];
  };

  networking = {
    hostName = "NixBerry";
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  programs.fish.enable = true;

  services.openssh.enable = true;

  services.tailscale = true;

  virtualisation.docker.enable = true; # Docker running as root

  users.users.cycad = {
    isNormalUser = true;
    description = "Hamish McLean";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}