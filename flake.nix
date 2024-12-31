{
  description = "System flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager/release-24.11"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-wsl = { url = "github:nix-community/NixOS-WSL"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # For Lenny's 06cb-009a fingerprint sensor
    lenny-fingerprint = { url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor"; inputs.nixpkgs.follows = "nixpkgs"; };

    # Packages
    catppuccin.url = "github:catppuccin/nix";
    cosmic = { url = "github:lilyinstarlight/nixos-cosmic"; inputs.nixpkgs.follows = "nixpkgs-unstable"; };
    helix = { url = "github:helix-editor/helix"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; };
    nixvim = { url = "github:nix-community/nixvim/nixos-24.11"; inputs.nixpkgs.follows = "nixpkgs"; }; # Change URL to "github:nix-community/nixvim/nixos-24.05" when available
    plasma-manager = { url = "github:nix-community/plasma-manager"; inputs.nixpkgs.follows = "nixpkgs"; inputs.home-manager.follows = "home-manager"; };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscodium-server.url = "github:unicap/nixos-vscodium-server";
  };

  outputs = inputs@{
      self, nixpkgs, nixpkgs-unstable, home-manager, nixos-hardware, nixos-wsl, nix-on-droid, lenny-fingerprint,
      cosmic, vscode-server, vscodium-server, catppuccin, helix, nixvim, plasma-manager, hyprland, hyprland-plugins, ... 
    }:
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
              inherit nixos-hardware nixos-wsl lenny-fingerprint 
              cosmic catppuccin vscode-server vscodium-server helix plasma-manager; # removed pkgs unstablePkgs 
              # lets us use these things in modules
              customArgs = { inherit system hostname username; }; # removed pkgs unstablePkgs 
            };
            modules = [
              # Allow unfree packages
              { nixpkgs.config.allowUnfree = true; }
              ./hosts/${hostname}
              ./hosts/common.nix
              home-manager.nixosModules.home-manager {
                networking.hostName = hostname;
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.extraSpecialArgs = { 
                  inherit pkgs unstablePkgs nixvim catppuccin plasma-manager; 
                };
                home-manager.users.${username} = { 
                  imports = [ ./home/${username}/hosts/${hostname}.nix ]; 
                };
              }
              
            ];
          };

      nixOnDroidSystem = system: hostname: username:
        let
          pkgs = genPkgs system;
          unstablePkgs = genUnstablePkgs system;
        in
          nix-on-droid.lib.nixOnDroidConfiguration {
            inherit system;
            specialArgs = {
              inherit pkgs unstablePkgs nix-on-droid;
              customArgs = { inherit system hostname username pkgs unstablePkgs; };
            };
            modules = [
              ./hosts/${hostname}
              
              #home-manager = {
              #  config = ./home/cycad/hosts/${hostname} # Cycad username hardcoded for now
              #  useGlobalPkgs = true;
              #};
            ];
            home-manager-path = home-manager.outPath;
          };

    in {
      nixosConfigurations = {
        # NixOS hosts
        Lenny = nixosSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = nixosSystem "aarch64-linux" "NixBerry" "cycad";

        # WSL hosts
        Roger = nixosSystem "x86_64-linux" "Roger" "cycad";
        EMR0148 = nixosSystem "x86_64-linux" "EMR0148" "cycad";
      };

      nixOnDroidConfigurations = {
        Pixel5 = nixOnDroidSystem "aarch64-linux" "Pixel5" "nix-on-droid"; # Username must be set to nix-on-droid
      };
    };
}
