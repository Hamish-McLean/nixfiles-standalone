{
  # config,
  inputs,
  pkgs,
  # lib,
  ...
}:

{
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    inputs.vscode-server.nixosModules.default
    inputs.vscodium-server.nixosModules.default
    ../common.nix
    ../../users/cycad.nix
  ];

  # Bootloader
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true; # What does this do?
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
    options = [ "noatime" ];
  };

  networking = {
    hostName = "NixBerry";
    wireless.enable = false; # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Didn't work...
  };

  services = {
    openssh.enable = true;
    tailscale.enable = true;
    # VSCode
    vscode-server.enable = true;
    vscodium-server.enable = true;
  };

  virtualisation.docker.enable = true; # Docker running as root

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}

