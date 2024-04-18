{ config, lib, pkgs, unstablePkgs, ... }:
{
  options = {
    helix.enable = lib.mkEnableOption "enables helix";
  };
  config = lib.mkIf config.helix.enable {
    programs.helix = {
      enable = true;
      package = unstablePkgs.helix;
      catppuccin.enable = true;
      languages.language = [{
        name = "nix";
        auto-format = true;
      }];
    };
  };
}
