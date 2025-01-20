{
  description = "System flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-24.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      # inputs.home-manager.follows = "home-manager";
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
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    vscodium-server.url = "github:unicap/nixos-vscodium-server";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-hardware,
      nixos-wsl,
      nix-on-droid,
      lenny-fingerprint,
      cosmic,
      vscode-server,
      vscodium-server,
      catppuccin,
      hyprland,
      hyprland-plugins,
      ...
    }:
    let

      genPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      genUnstablePkgs =
        system:
        import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };

      # creates a nixos system config
      nixosSystem =
        system: hostname: username:
        let
          pkgs = genPkgs system;
          unstablePkgs = genUnstablePkgs system;
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit
              system
              inputs
              nixos-hardware
              nixos-wsl
              lenny-fingerprint
              cosmic
              catppuccin
              vscode-server
              vscodium-server
              # plasma-manager
              ; # removed pkgs unstablePkgs
            # lets us use these things in modules
            customArgs = { inherit system hostname username; }; # removed pkgs unstablePkgs
          };
          modules = [
            # Allow unfree packages
            { nixpkgs.config.allowUnfree = true; }
            ./hosts/${hostname}
            ./hosts/common.nix
          ];
        };

      nixOnDroidSystem =
        system: hostname: username:
        let
          pkgs = genPkgs system;
          unstablePkgs = genUnstablePkgs system;
        in
        nix-on-droid.lib.nixOnDroidConfiguration {
          inherit system;
          pkgs = pkgs;
          specialArgs = {
            inherit inputs pkgs unstablePkgs nix-on-droid;
            customArgs = { inherit system hostname username ; };
          };
          modules = [
            ./hosts/nix-on-droid
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

      nixOnDroidConfigurations = {
        default = nixOnDroidSystem "aarch64-linux" "localhost" "nix-on-droid"; # Username must be set to nix-on-droid
      };
    };
}
