{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    rofi.enable = lib.mkEnableOption "enables rofi";
  };
  config = lib.mkIf config.rofi.enable {
    home.packages = [ pkgs.rofi ];
    catppuccin.rofi.enable = true;
    programs.rofi = {
      enable = true;
      location = "center";
      terminal = "kitty";
      # plugins = [];
      extraConfig = {
        modi = "drun";
        show-icons = true;
      };
    };
  };
}
