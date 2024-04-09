# Cycad's default home manager module which imports other home manager modules
{ pkgs, ... }:
{
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  imports = [
    ./cliPrograms
    ./guiPrograms
  ];

  # Fonts
  fonts.fontconfig.enable = true;

  xdg.enable = true;

  catppuccin = {
    flavour = "mocha";
    accent = "sapphire";
  };

  home.packages = with pkgs; [
    nerdfonts
  ];
  # home.packages = [
  #   (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  # ];
}