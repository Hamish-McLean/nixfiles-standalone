{ config, lib, unstablePkgs, ... }:
{
  options = {
    eza.enable = lib.mkEnableOption "enables eza";
  };
  config = lib.mkIf config.eza.enable {
    programs.eza = {
      enable = true;
      # package = unstablePkgs.eza;
      # enableAliases = true; # Option removed from 24.05
      enableFishIntegration = true; # Option not in 23.11
      icons = true;
      git = true;
      extraOptions = [];
    };
  };
}