{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.services.mosh;
in
{
  options.custom.modules.services.mosh = {
    enable = mkEnableOption "Enable mosh";
  };

  config = mkIf cfg.enable {
    programs.mosh = {
      enable = true;
      openFirewall = true;
    };
  };
}
