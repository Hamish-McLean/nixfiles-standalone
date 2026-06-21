/*
  Upower

  a DBus service that provides power management support to applications.
*/
{
  config,
  lib,
  ...
}:
{
  options = {
    upower.enable = lib.mkEnableOption "enable upower";
  };

  config = lib.mkIf config.upower.enable {
    services.upower = {
      enable = true;
    };
  };
}
