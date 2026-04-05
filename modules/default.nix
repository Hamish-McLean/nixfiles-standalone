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
    ./niri.nix
    ./opensnitch.nix
    ./qt.nix
    ./regreet.nix
    ./sddm.nix
    ./tuigreet.nix
  ];

  cat-colours.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;

}
