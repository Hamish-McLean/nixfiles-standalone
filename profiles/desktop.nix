{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.desktop;
in
{
  imports = [ ../modules ];

  options.custom.profiles.desktop = {
    enable = mkEnableOption "Enable desktop profile";
  };

  config = mkIf cfg.enable {
    # custom.modules.desktop = {
    #
    # };

    custom.modules.network = {
      libredns.enable = mkDefault true;
    };
  };
}
