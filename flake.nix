{
  description = "System flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    # For Lenny's 06cb-009a fingerprint sensor
    lenny-fingerprint.url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
    lenny-fingerprint.inputs.nixpkgs.follows = "nixpkgs";

    # Packages
    catppuccin.url = "github:catppuccin/nix/release-25.05";
    # cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      # submodules = true;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscodium-server.url = "github:unicap/nixos-vscodium-server";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:

    let
      nixosSystem =
        system: hostname: username:
        nixpkgs.lib.nixosSystem {
          # pkgs = pkgs;
          inherit system;
          specialArgs = {
            inherit inputs; # pkgs unstablePkgs;
            customArgs = { inherit system hostname username; };
          };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
              # Overlay to make unstable packages available as `pkgs.unstable.<package>`
              nixpkgs.overlays = [
                (final: prev: {
                  unstable = import nixpkgs-unstable {
                    inherit system;
                    config.allowUnfree = true; # Allow unfree in unstable pkgs as well
                  };
                })
              ];
            }
            ./hosts/${hostname}
            ./hosts/common.nix
            inputs.nix-index-database.nixosModules.default
            { programs.nix-index-database.comma.enable = true; }
          ];
        };

    in
    {
      nixosConfigurations = {
        # NixOS hosts
        Radagast = nixosSystem "x86_64-linux" "Radagast" "cycad";
        Lenny = nixosSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = nixosSystem "aarch64-linux" "NixBerry" "cycad";

        # WSL hosts
        Roger = nixosSystem "x86_64-linux" "Roger" "cycad";
        EMR0148 = nixosSystem "x86_64-linux" "EMR0148" "cycad";
      };
    };
}
