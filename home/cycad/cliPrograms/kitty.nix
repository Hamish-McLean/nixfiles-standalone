{ config, lib, ... }:
{
  options = {
    kitty.enable = lib.mkEnableOption "enables kitty";
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        hide_window_decorations = true; # Disables white top bar             
      };
    };
  };
}