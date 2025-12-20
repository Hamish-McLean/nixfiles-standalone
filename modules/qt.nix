{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    qt_config.enable = lib.mkEnableOption "enables qt";
  };

  config = lib.mkIf config.qt_config.enable {
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
