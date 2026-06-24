# Gaming settings
{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.desktop.gaming;
in
{
  options.custom.modules.desktop.gaming = {
    enable = lib.mkEnableOption "Enable gaming";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bottles
      lutris
      protonup-qt
      winetricks
      wineWow64Packages.wayland
    ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    hardware.steam-hardware.enable = true; # For steam controller

    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
        libGL
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
      gamescopeSession.enable = true;
      localNetworkGameTransfers.openFirewall = true;
      package = pkgs.unstable.steam;
    };
    programs.gamemode.enable = true;
    programs.gamescope.enable = true;
    programs.xwayland.enable = true;

    services.xserver = {
      enable = true;
      # extraConfig = pkgs.libGL.config;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
