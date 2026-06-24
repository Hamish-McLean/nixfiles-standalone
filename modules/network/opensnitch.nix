/*
  OpenSnitch

  OpenSnitch is a GNU/Linux application firewall

  https://github.com/evilsocket/opensnitch
*/
{
  config,
  lib,
  ...
}:
let
  cfg = config.custom.modules.network.opensnitch;
in
{
  options.custom.modules.network.opensnitch = {
    enable = lib.mkEnableOption "Enable opensnitch";
  };

  config = lib.mkIf cfg.enable {
    services.opensnitch = {
      enable = true;
      settings = {
        DefaultAction = "allow";
        Firewall = "nftables";
        ProcMonitorMethod = "ebpf";
      };
    };
    # May need to add eBPF when using custom kernals
    # boot.extraModulePackages = [ config.boot.kernelPackages.opensnitch-ebpf ];
  };
}
