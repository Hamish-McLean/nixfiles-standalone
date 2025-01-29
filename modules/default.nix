{
  lib,
  ...
}:
{
  imports = [
    ./catppuccin.nix
    ./cosmic-de.nix
    ./gaming.nix
    ./gnome.nix
    ./hyprland.nix
    ./kde.nix
    ./qt.nix
  ];

  cat-colours.enable = lib.mkDefault true;
}
