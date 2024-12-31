{ config, lib, ... }:
{
  options = {
    kitty.enable = lib.mkEnableOption "enables kitty";
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      # catppuccin.enable = true;
      shellIntegration.enableFishIntegration = true;
      settings = {
        hide_window_decorations = false; # Disables white top bar
      };
    };
    catppuccin.kitty.enable = true;
  };
}
