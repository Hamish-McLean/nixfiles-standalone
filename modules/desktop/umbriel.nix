{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.desktop.umbriel;
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [ inputs.umbriel.nixosModules.default ];

  options.custom.modules.desktop.umbriel = {
    enable = mkEnableOption "Enable noctalia umbriel compositor";
    uwsm = mkOption {
      default = true;
      description = "Manage Umbriel with UWSM";
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.umbriel = {
      enable = true;
      portalPackage = inputs.xdg-desktop-portal-umbriel.packages.${system}.default;
    };

    programs.uwsm = {
      enable = cfg.uwsm;
      waylandCompositors = mkIf cfg.uwsm {
        umbriel = {
          prettyName = "Umbriel";
          comment = "Umbriel compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/umbriel";
          extraArgs = [ "--session" ];
        };
      };
    };
  };
}
