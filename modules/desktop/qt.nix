{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.desktop.qt;
in
{
  options.custom.modules.desktop.qt = {
    enable = lib.mkEnableOption "Enable qt";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # libsForQt5.qt5ct
      # libsForQt5.qtstyleplugin-kvantum
    ];
    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };
  };
}
