{ config, pkgs, lib, unstablePkgs, nixvim, ... }:
{
  options{
    nixvim.enable = lib.mkEnableOption "enables nixvim";
  };
  config = lib.mkIf config.nixvim.enable {
    nixvim = {
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