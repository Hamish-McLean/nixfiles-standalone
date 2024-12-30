{ config, lib, plasma-manager... }:
{
  options = {
    plasma.enable = lib.mkEnableOption "enables plasma";
  };
  config = lib.mkIf config.plasma.enable {
    imports = [
      plasma-manager.homeManagerModules.plasma-manager
    ];

    programs.plasma = {
      enable = true;

    };
    
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    catppuccin.kvantum = {
      enable = true;
      apply = true;
    };
  };
}