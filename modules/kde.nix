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

    # qt = {
    #   enable = true;
    #   platformTheme = "qtct";
    #   style.name = "kvantum";
    # };

    # xdg.configFile = {
    #   "Kvantum/ArcDark".source = "${pkgs.arc-kde-theme}/share/Kvantum/ArcDark";
    #   "Kvantum/kvantum.kvconfig".text = "[General]\ntheme=ArcDark";
    # };
  };

}