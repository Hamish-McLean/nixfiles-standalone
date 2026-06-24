{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.modules.desktop.sunshine;
in
{
  options.custom.modules.desktop.sunshine = {
    enable = lib.mkEnableOption "Enable sunshine";
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
    };
  };
}
