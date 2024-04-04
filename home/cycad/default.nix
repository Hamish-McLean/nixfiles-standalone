{ config, pkgs, lib, unstablePkgs, nixvim, ... }:
{
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    ./fish.nix
    ./git.nix
    ./gnome.nix
    ./gtk.nix
    ./nixvim.nix
    ./starship.nix
    ./tmux.nix
    ./vscodium.nix
  ];

  fish.enable = true;
  git.enable = true;
  gnome.enable = true;
  gtk_config.enable = true;
  nixvim.enable = true;
  starship.enable = true;
  tmux.enable = true;
  vscodium.enable = true;

  # Fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerdfonts
  ];
  # home.packages = [
  #   (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  # ];
}