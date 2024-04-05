# Cycad's default home manager module which imports other home manager modules
{ pkgs, ... }:
{
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    ./fish.nix
    ./git.nix
    ./gnome.nix
    ./gtk.nix
    ./hyprland.nix
    ./nixvim.nix
    ./starship.nix
    ./tmux.nix
    ./vscodium.nix
  ];

  # Fonts
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerdfonts
  ];
  # home.packages = [
  #   (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  # ];
}