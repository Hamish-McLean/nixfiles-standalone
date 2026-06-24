# LibreDNS
{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.network.libredns;
in
{
  options.custom.modules.network.libredns = {
    enable = mkEnableOption "Enable libredns";
  };

  config = mkIf cfg.enable {
    networking.nameservers = lib.mkDefault [
      "116.202.176.26#noads.libredns.gr"
      "2a01:4f8:1c0c:8274::1#noads.libredns.gr"
    ];
    services.resolved = mkDefault {
      enable = true;
      settings.Resolve = {
        DNSOverTLS = "opportunistic"; # "opportunistic" will attempt to encrypt DNS
        DNSSEC = true;
        FallbackDNS = [
          "1.1.1.1#one.one.one.one"
          "2606:4700:4700::1111#one.one.one.one"
          "1.0.0.1#one.one.one.one"
          "2606:4700:4700::1001#one.one.one.one"
        ];
      };
    };
  };
}
