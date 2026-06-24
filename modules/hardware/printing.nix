{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.hardware.printing;
in
{
  options.custom.modules.hardware.printing = {
    enable = lib.mkEnableOption "Enable printing";
  };

  config = lib.mkIf cfg.enable {
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        canon-cups-ufr2
      ];
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
