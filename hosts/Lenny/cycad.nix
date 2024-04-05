# Cycad's host-specific home manager module for toggling other home manager modules
{ ... }:
{
  imports = [
    ../../home/cycad
  ];

  fish.enable = true;
  git.enable = true;
  gnome_config.enable = true;
  gtk_config.enable = true;
  hyprland.enable = false;
  nixvim.enable = true;
  starship.enable = true;
  tmux.enable = true;
  vscodium.enable = true;
}