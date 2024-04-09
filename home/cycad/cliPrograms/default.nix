/*
Cycad's default cliPrograms home manager module.
This imports other cliPrograms home manager modules.
All can be enabled by setting cliPrograms = true.
Modules are enabled by default so can be disabled by setting them to false.
*/
{ lib, config, ... }:
{
  # Cli programs to import
  imports = [
    ./btop.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./kitty.nix
    ./nixvim.nix
    ./starship.nix
    ./tmux.nix
  ];

  # Option to enable all cliPrograms modules
  options = {
    cliPrograms.enable = lib.mkEnableOption "enables cliPrograms";
  };
  config = lib.mkIf config.cliPrograms.enable {
    btop.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    helix.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    nixvim.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
  };
  
}