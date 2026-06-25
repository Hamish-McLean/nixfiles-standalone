{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.shell.sudo-rs;
in
{
  options.custom.modules.shell.sudo-rs = {
    enable = mkEnableOption "Enable sudo-rs instead of sudo";
  };

  config = mkIf cfg.enable {
    security.sudo.enable = mkDefault false;
    security.sudo-rs = {
      enable = true;
    };
  };
}
