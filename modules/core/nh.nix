# Nix Helper
{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.modules.nh;
in
{
  options = {
    custom.modules.nh.enable = lib.mkEnableOption "enable nh";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep 5 --keep-since 7d";
      };
    };
  };
}
