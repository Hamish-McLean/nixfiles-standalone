{
  lib,
  ...
}:
{
  imports = [
    ./catppuccin.nix
    ./nh.nix
  ];

  cat-colours.enable = lib.mkDefault true;
  nh.enable = lib.mkDefault true;
}
