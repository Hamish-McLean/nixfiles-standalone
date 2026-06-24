{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.server;
in
{
  imports = [ ../modules ];

  options.custom.profiles.server = {
    enable = mkEnableOption "Enable server profile";
  };

  config = mkIf cfg.enable {
    # custom.modules.services = {
    #
    # };
  };
}
