{
  description = "home-manager flake";

  inputs = {
    # Nix
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Packages
    catppuccin.url = "github:catppuccin/nix";
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    }; # Change URL to "github:nix-community/nixvim/nixos-24.05" when available
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    cosmic,
    vscode-server,
    vscodium-server,
    catppuccin,
    helix,
    nixvim,
    plasma-manager,
    hyprland,
    hyprland-plugins,
    ...
  }:
    let
      inputs = { inherit nixpkgs nixpkgs-unstable home-manager; };

      # creates a nixos system config
      homeSystem =
        system: hostname: username:
        let
          pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
          unstablePkgs = import nixpkgs-unstable { inherit system; config.allowUnfree = true; };
          # pkgs = genPkgs system;
          # unstablePkgs = genUnstablePkgs system;
        in
        home-manager.lib.homeManagerConfiguration {
          inherit system;
          specialArgs = {
            inherit
              catppuccin
              helix
              plasma-manager
              ; # removed pkgs unstablePkgs
            # lets us use these things in modules
            customArgs = { inherit system hostname username; }; # removed pkgs unstablePkgs
          };
          modules = [
            # Allow unfree packages
            { nixpkgs.config.allowUnfree = true; }
            ./hosts/${hostname}.nix
            {
              networking.hostName = hostname;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit
                  pkgs
                  unstablePkgs
                  nixvim
                  catppuccin
                  plasma-manager
                  hyprland-plugins
                  ;
                system = pkgs.system;
              };
              home-manager.users.${username} = {
                imports = [ ./home/${username}/hosts/${hostname}.nix ];
              };
            }

          ];
        };

    in
    {
      homeConfigurations = {
        # NixOS hosts
        Lenny = homeSystem "x86_64-linux" "Lenny" "cycad";
        NixBerry = homeSystem "aarch64-linux" "NixBerry" "cycad";
      };
    };
}
