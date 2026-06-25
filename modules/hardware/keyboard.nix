{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.hardware.keyboard;
in
{
  options.custom.modules.hardware.keyboard = {
    enable = mkEnableOption "Enable keyboard settings";
  };

  config = mkIf cfg.enable {
    services.xserver.xkb.layout = mkDefault "gb";
    console.useXkbConfig = true;
    console.keyMap = mkDefault "uk";
  };
}
