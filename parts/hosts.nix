{
  inputs,
  withSystem,
  ...
}:
let
  sharedModules = [
    ../modules
    ../profiles
  ];
in
{
  flake.nixosConfigurations = {
    Lenny = withSystem "x86_64-linux" (
      { pkgs, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          { nixpkgs.pkgs = pkgs; }
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t480s
          ../hosts/Lenny
          ../hosts/Lenny/hardware-configuration.nix
          ../hosts/Lenny/lenny-fingerprint.nix
        ];
      }
    );

    Radagast = withSystem "x86_64-linux" (
      { pkgs, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          { nixpkgs.pkgs = pkgs; }
          ../hosts/Radagast
          ../hosts/Radagast/disko-data.nix
          ../hosts/Radagast/disko-system.nix
          ../hosts/Radagast/hardware-configuration.nix
        ];
      }
    );

    NixBerry = withSystem "aarch64-linux" (
      { pkgs, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = sharedModules ++ [
          { nixpkgs.pkgs = pkgs; }
          inputs.nixos-hardware.nixosModules.raspberry-pi-4
          ../hosts/NixBerry
        ];
      }
    );
  };
}
