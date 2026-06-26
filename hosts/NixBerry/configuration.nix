{
  pkgs,
  ...
}:

{
  custom.profiles = {
    core.enable = true;
    server.enable = true;
  };

  # Bootloader
  boot = {
    /*
      WARN:
      `pkgs.linuxKernel.packages.linux_rpi4` is depracated.
      Consider switching to `pkgs.linuxPackages`.
      HATs and camera modules may require the custom kernel in
      `inputs.nixos-hardware.nixosModules.raspberry-pi-4`, but this can be slow to compile.
    */
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
    # wireless.enable = false; # Enables wireless support via wpa_supplicant.
  };

  services = {
    openssh.enable = true;
    # VSCode
    # vscode-server.enable = true;
    # vscodium-server.enable = true;
  };

  virtualisation.docker.enable = true; # Docker running as root

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.11";
}
