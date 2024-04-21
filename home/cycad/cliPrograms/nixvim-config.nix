{ config, lib, nixvim, ... }:
{
  imports = [
    nixvim.homeManagerModules.nixvim
  ];
  
  options = {
    nixvim-config.enable = lib.mkEnableOption "enables nixvim-config";
  };
  config = lib.mkIf config.nixvim-config.enable {
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin = {
        enable = true;
        flavour = "mocha";
      };
      plugins = {
        bufferline.enable = true;
        lualine.enable = true;
        # neoscroll.enable = true;
        nvim-tree.enable = true;
      };
    };
  };
}