{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.desktop.sddm;
in
{
  options.custom.modules.desktop.sddm = {
    enable = lib.mkEnableOption "Enable sddm";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
    services.xserver = {
      enable = true;
      xkb.layout = "gb";
    };
  };
}
