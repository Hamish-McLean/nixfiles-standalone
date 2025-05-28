{
  description = "System flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-24.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";
    # For Lenny's 06cb-009a fingerprint sensor
    lenny-fingerprint = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Packages
    catppuccin.url = "github:catppuccin/nix";
    cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      # submodules = true;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
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
        # let
        #   pkgs = import nixpkgs {
        #     inherit system;
        #     config.allowUnfree = true;
        #   };
        #   unstablePkgs = import nixpkgs-unstable {
        #     inherit system;
        #     config.allowUnfree = true;
        #   };
        # in
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
                # This overlay adds an 'unstable' attribute to pkgs,
                # which contains packages from the nixpkgs-unstable input.
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
          ];
        };

    in
    {
      nixosConfigurations = {
        # NixOS hosts
        Lenny = nixosSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = nixosSystem "aarch64-linux" "NixBerry" "cycad";

        # WSL hosts
        Roger = nixosSystem "x86_64-linux" "Roger" "cycad";
        EMR0148 = nixosSystem "x86_64-linux" "EMR0148" "cycad";
      };
    };
}
