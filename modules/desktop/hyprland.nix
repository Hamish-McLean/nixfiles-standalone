{
  config,
  # inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.custom.modules.desktop.hyprland;
in
{
  options.custom.modules.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland";
  };

  config = lib.mkIf cfg.enable {

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      xwayland.enable = true;
      package = pkgs.hyprland;
      # package = inputs.hyprland.packages.${system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };
  };
}
