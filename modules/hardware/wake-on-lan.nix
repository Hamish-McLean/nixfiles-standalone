{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    wake-on-lan.enable = lib.mkEnableOption "enable wake-on-lan";
  };

  config = lib.mkIf config.wake-on-lan.enable {
    environment.systemPackages = [ pkgs.ethtool ];
    systemd.services.wake-on-lan = {
      description = "Keep wake on LAN active after shutdown";
      wantedBy = [
        "shutdown.target"
        "sleep.target"
      ];
      before = [
        "shutdown.target"
        "sleep.target"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp24s0 wol g";
        RemainAfterExit = "yes";
      };
    };
  };
}
