{
  lib,
  ...
}:
with lib;
{
  imports = [ ../modules ];

  custom.modules = {
    catppuccin.enable = mkDefault true;
    nh.enable = mkDefault true;
  };
}
