{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.core;
in
{
  imports = [ ../modules ];

  options.custom.profiles.core = {
    enable = mkEnableOption "Enable core modules";
  };
  config = mkIf cfg.enable {
    custom.modules.core = {
      catppuccin.enable = mkDefault true;
    };

    custom.modules.shell = {
      nh.enable = mkDefault true;
    };
  };
}
