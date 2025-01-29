{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options = {
    cat-colours.enable = lib.mkEnableOption "enables catppuccin";
  };

  config = lib.mkIf config.cat-colours.enable {
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "sapphire";

      # Options
      grub.enable = true;
      plymouth.enable = true;
      sddm = {
        enable = true;
        background = ./wallpapers/rainbow_reverse.png;
      };
      tty.enable = true;
    };
  };
}
