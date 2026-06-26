{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
    ./configuration.nix
    ./hardware-configuration.nix
    # ./lenny-fingerprint.nix
  ];
}
