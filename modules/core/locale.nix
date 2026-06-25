{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.core.locale;
in
{
  options.custom.modules.core.locale = {
    enable = mkEnableOption "Enable locale";
    timeZone = mkOption {
      default = "Europe/London";
      description = "Time zone";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    time.timeZone = cfg.timeZone;
    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings.LC_TIME = "en_DK.UTF-8"; # ISO 8601 datetimes
  };
}
