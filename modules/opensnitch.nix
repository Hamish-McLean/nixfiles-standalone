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
{
  options = {
    opensnitch.enable = lib.mkEnableOption "enable opensnitch";
  };

  config = lib.mkIf config.opensnitch.enable {
    services.opensnitch = {
      enable = true;
      settings = {
        DefaultAction = "deny";
        Firewall = "nftables";
        ProcMonitorMethod = "ebpf";
      };
    };
    # May need to add eBPF when using custom kernals
    # boot.extraModulePackages = [ config.boot.kernelPackages.opensnitch-ebpf ];
  };
}
