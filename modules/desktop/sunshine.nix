{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.desktop.sunshine;
in
{
  options.custom.modules.desktop.sunshine = {
    enable = lib.mkEnableOption "Enable sunshine";
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = false; # Enable for escalated privileges
      openFirewall = true;
      package = pkgs.sunshine.override {
        cudaSupport = true;
        # cudaPackages = pkgs.cudaPackages;
      };
    };

    hardware.uinput.enable = true; # For input events
    users.users.cycad.extraGroups = [ "uinput" ];
  };
}
