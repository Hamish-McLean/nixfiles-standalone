{ config, lib, ... }:
{
  options = {
    starship.enable = lib.mkEnableOption "enables starship";
  };
  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };
  };
}