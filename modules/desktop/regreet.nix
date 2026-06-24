{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.desktop.regreet;
in
{
  options.custom.modules.desktop.regreet = {
    enable = lib.mkEnableOption "Enable regreet";
  };

  config = lib.mkIf cfg.enable {
    programs.regreet.enable = true;
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };
}
