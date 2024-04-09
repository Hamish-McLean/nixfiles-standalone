{ config, lib, ... }:
{
  options = {
    kitty.enable = lib.mkEnableOption "enables kitty";
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      catppuccin.enable = true;
    };
  };
}