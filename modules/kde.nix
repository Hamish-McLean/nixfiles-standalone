{ config, lib, pkgs, ... }:
{ 
  options = {
    kde.enable = lib.mkEnableOption "enables kde";
  };

  config = lib.mkIf config.kde.enable {
    services = {
      xserver.enable = true;
      displayManager.sddm.wayland.enable = true; # displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };

    # Exclude packages
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      # plasma-browser-integration
      # konsole
      # oxygen
    ];

    environment.systemPackages = with pkgs; [
      # libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];

    qt = {
      enable = true;
      platformTheme = "qt5ct";
      style = "kvantum";
    };

    # xdg.configFile = {
    #   "Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
    #   "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=ArcDark";
    # };
  };

}