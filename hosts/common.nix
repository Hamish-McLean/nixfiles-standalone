{ pkgs, unstablePkgs, lib, inputs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  time.timeZone = "Europe/London";

  nix = {
    settings = {
        experimental-features = [ "nix-command" "flakes" ];
        # warn-dirty = false;
    };
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5";
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  environment.systemPackages = with pkgs; [
    curl
    btop
    fish
    gh # Github
    git
    github-copilot-cli
    htop
    helix
    neovim
    neofetch
    tmux 
    tree
    wget
  ];

}