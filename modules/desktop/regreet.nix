{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    regreet.enable = lib.mkEnableOption "enable regreet";
  };

  config = lib.mkIf config.regreet.enable {
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
