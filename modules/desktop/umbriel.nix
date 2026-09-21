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
  };

  config = mkIf cfg.enable {
    programs.umbriel = {
      enable = true;
      portalPackage = inputs.xdg-desktop-portal-umbriel.packages.${system}.default;
    };
  };
}
