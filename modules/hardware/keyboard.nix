{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.modules.hardware.keyboard;
in
{
  options.custom.modules.hardware.keyboard = {
    enable = lib.mkEnableOption "Enable keyboard settings";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.xkb.layout = lib.mkDefault "gb";
    console.useXkbConfig = true;
    console.keyMap = lib.mkDefault "uk";
  };
}
