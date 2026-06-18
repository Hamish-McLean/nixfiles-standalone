{
  config,
  lib,
  ...
}:
{
  options = {
    sunshine.enable = lib.mkEnableOption "enable sunshine";
  };

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      openFirewall = true;
    };
  };
}
