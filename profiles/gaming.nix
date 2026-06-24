{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.gaming;
in
{
  imports = [ ../modules ];

  options.custom.profiles.gaming = {
    enable = mkEnableOption "Enable gaming profile";
  };

  config = mkIf cfg.enable {
    custom.modules.desktop = {
      gaming.enable = true;
    };
  };
}
