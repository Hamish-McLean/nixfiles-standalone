{
  description = "System flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-23.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nixvim, ... }:
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
              inherit pkgs unstablePkgs;
              # lets us use these things in modules
              customArgs = { inherit system hostname username pkgs unstablePkgs; };
            };
            modules = [
              ./hosts/${hostname}

              home-manager.nixosModules.home-manager {
                networking.hostName = hostname;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${username} = { 
                  imports = [ 
                    ./home/${username}
                    nixvim.homeManagerModules.nixvim 
                  ]; 
                };
              }

              ./hosts/common.nix
            ];
          };

    in {
      nixosConfigurations = {
        Lenny = nixosSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = nixosSystem "aarch64-linux" "NixBerry" "cycad";
      };
    };
}
