{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.network.wakeOnLan;
in
{
  options.custom.modules.network.wakeOnLan = {
    enable = mkEnableOption "Enable wake-on-lan";
    interface = mkOption {
      default = "enp24s0";
      description = "Networking interface";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.ethtool ];

    networking.interfaces."${cfg.interface}".wakeOnLan.enable = true;

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
        ExecStart = "${pkgs.ethtool}/bin/ethtool -s ${cfg.interface} wol g";
        RemainAfterExit = "yes";
      };
    };
  };
}
