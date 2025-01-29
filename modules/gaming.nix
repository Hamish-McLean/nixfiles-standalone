# Gaming settings
{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    gaming.enable = lib.mkEnableOption "enables gaming";
  };

  config = lib.mkIf config.gaming.enable {
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        libGL
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession.enable = true;
    };
    programs.gamemode.enable = true;
    services.xserver = {
      enable = true;
      # extraConfig = pkgs.libGL.config;
    };
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
    hardware.steam-hardware.enable = true; # For steam controller
    environment.systemPackages = with pkgs; [
      bottles
      lutris
      protonup-qt
    ];

  };
}
