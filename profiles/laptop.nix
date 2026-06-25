{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.laptop;
in
{
  imports = [ ../modules ];

  options.custom.profiles.laptop = {
    enable = mkEnableOption "Enable laptop profile";
  };

  config = mkIf cfg.enable {
    # custom.modules.desktop = {
    #
    # };

    custom.modules.hardware = {
      upower.enable = mkDefault true;
    };

    services.power-profiles-daemon.enable = mkDefault true;
  };
}
