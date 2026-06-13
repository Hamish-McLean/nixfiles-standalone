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
    ./noctalia-greet.nix
    ./opensnitch.nix
    ./printing.nix
    ./qt.nix
    ./regreet.nix
    ./sddm.nix
    ./tuigreet.nix
  ];

  cat-colours.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;

}
