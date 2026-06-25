# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
    # ./lenny-fingerprint.nix
    ../../modules
    ../../profiles
    ../../users/cycad.nix
    ../../users/fallo.nix
  ];

  custom.profiles = {
    core.enable = true;
    desktop.enable = true;
    laptop.enable = true;
  };

  # Bootloader
  boot.loader = {
    limine.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "Lenny";

  services.dbus.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Flatpaks
  services.flatpak.enable = true;

  users.users.cycad.packages = (
    with pkgs;
    [
      # bitwarden-desktop # Requires insecure electron package in nixpkgs 26.05
      fractal
      # modrinth-app
      mumble
      oh-my-git
      # stremio
      warp-terminal
    ]
  );

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
