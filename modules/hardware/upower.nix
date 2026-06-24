/*
  Upower

  a DBus service that provides power management support to applications.
*/
{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.modules.hardware.upower;
in
{
  options.custom.modules.hardware.upower = {
    enable = lib.mkEnableOption "Enable upower";
  };

  config = lib.mkIf cfg.enable {
    services.upower = {
      enable = true;
    };
  };
}
