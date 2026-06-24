{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.group.app;
in
{
  options.custom.modules.group.app = {
    enable = mkEnableOption "Enable app";
  };

  config = mkIf cfg.enable {

  };
}
