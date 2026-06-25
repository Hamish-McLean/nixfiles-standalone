{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.network.firewall;
in
{
  options.custom.modules.network.firewall = {
    enable = mkEnableOption "Enable firewall";
  };

  config = mkIf cfg.enable {
    networking = {
      firewall.enable = mkDefault true;
      nftables.enable = mkDefault true;
    };
  };
}
