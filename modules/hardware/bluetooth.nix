{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.hardware.bluetooth;
in
{
  options.custom.modules.hardware.bluetooth = {
    enable = mkEnableOption "Enable bluetooth";
  };

  config = mkIf cfg.enable {
    hardware = {
      enableRedistributableFirmware = true;
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };
  };
}
