{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.hardware.ddc;
in
{
  options.custom.modules.hardware.ddc = {
    enable = mkEnableOption "Enable DDC/CI monitor control";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ddcutil ];

    services.ddccontrol = mkDefault {
      enable = true;
      package = pkgs.ddcutil-service;
    };
  };
}
