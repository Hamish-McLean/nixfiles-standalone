{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixvim.url = "github:nix-community/nixvim/nixos-23.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nixvim, hyprland, hyprland-plugins, ... }:
    let 
      inputs = { inherit nixpkgs nixpkgs-unstable home-manager; };

      genPkgs = system: import nixpkgs { inherit system; config.allowUnfree = true; };
      genUnstablePkgs = system: import nixpkgs-unstable { inherit system; config.allowUnfree = true; };

      # creates a nixos system config
      nixosSystem = system: hostname: username:
        let
          pkgs = genPkgs system;
          unstablePkgs = genUnstablePkgs system;
        in
          nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit pkgs unstablePkgs nixos-hardware;
              # lets us use these things in modules
              customArgs = { inherit system hostname username pkgs unstablePkgs; };
            };
            modules = [
              ./hosts/${hostname}
              ./hosts/common.nix
              home-manager.nixosModules.home-manager {
                networking.hostName = hostname;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = { 
                  imports = [ 
                    ./hosts/${hostname}/${username}.nix
                    nixvim.homeManagerModules.nixvim 
                  ]; 
                };
              }
            ];
          };

    in {
      nixosConfigurations = {
        Lenny = nixosSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = nixosSystem "aarch64-linux" "NixBerry" "cycad";
      };
    };
}
