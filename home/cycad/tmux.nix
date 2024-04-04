{ config, lib, pkgs, ... }:
{
  options = {
    tmux.enable = lib.mkEnableOption "enables tmux";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      #keyMode = "vi";
      clock24 = true;
      historyLimit = 10000;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        better-mouse-mode
      ];
    };
  };
}