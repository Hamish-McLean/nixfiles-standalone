{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.custom.modules.core.catppuccin;
in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options.custom.modules.core.catppuccin = {
    enable = lib.mkEnableOption "Enable catppuccin";
  };

  config = lib.mkIf cfg.enable {
    catppuccin = {
      accent = "sapphire";
      cache.enable = true; # Catppuccin's binary cache
      enable = true;
      flavor = "mocha";

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
