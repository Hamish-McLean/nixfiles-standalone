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

    custom.modules.hardware = {
      printing.enable = mkDefault true;
    };

    custom.modules.network = {
      opensnitch.enable = mkDefault false;
      libredns.enable = mkDefault true;
    };
  };
}
