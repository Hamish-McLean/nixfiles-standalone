{
  inputs,
  withSystem,
  ...
}:
let
  mkHost =
    system: hostname:
    withSystem system (
      { pkgs, ... }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          { nixpkgs.pkgs = pkgs; }
          ../hosts/${hostname}
          ../modules
          ../profiles
        ];
      }
    );
in
{
  flake.nixosConfigurations = {
    Lenny = mkHost "x86_64-linux" "Lenny";

    Radagast = mkHost "x86_64-linux" "Radagast";

    NixBerry = mkHost "aarch64-linux" "NixBerry";
  };
}
