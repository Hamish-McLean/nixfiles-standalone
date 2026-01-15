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
    ./libredns.nix
    ./nh.nix
    ./qt.nix
    ./sddm.nix
  ];

  cat-colours.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;

}
