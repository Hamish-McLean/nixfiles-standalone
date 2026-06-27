{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.desktop.niri;
in
{
  imports = [ inputs.niri.nixosModules.niri ];

  options.custom.modules.desktop.niri = {
    enable = mkEnableOption "Enable niri";
    uwsm = mkOption {
      default = true;
      description = "Manage Niri with UWSM";
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
    };

    programs.uwsm = {
      enable = cfg.uwsm;
      waylandCompositors = mkIf cfg.uwsm {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri";
          extraArgs = [ "--session" ];
        };
      };
    };

    xdg.portal = {
      enable = mkDefault true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-gtk
      ];
      # Tells portals to fall back to GNOME/GTK interfaces under Niri
      config.common.default = [
        "gnome"
        "gtk"
      ];
    };
  };
}
