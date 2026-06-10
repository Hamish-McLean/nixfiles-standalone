{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    printing.enable = lib.mkEnableOption "enable printing";
  };

  config = lib.mkIf config.printing.enable {
    networking.printing = {
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
