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
    custom.modules.desktop = mkDefault {
      niri.enable = true;
      noctalia-greeter.enable = true;
    };

    custom.modules.hardware = mkDefault {
      printing.enable = true;
    };

    custom.modules.network = mkDefault {
      opensnitch.enable = false;
      libredns.enable = true;
    };
  };
}
