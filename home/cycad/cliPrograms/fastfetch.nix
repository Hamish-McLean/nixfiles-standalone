{ config, lib, unstablePkgs, ... }:
{
  options = {
    fastfetch.enable = lib.mkEnableOption "enables fastfetch";
  };
  config = lib.mkIf config.fastfetch.enable {
    programs.fastfetch = {
      enable = true;
      package = unstablePkgs.fastfetch;
    };
  };
}