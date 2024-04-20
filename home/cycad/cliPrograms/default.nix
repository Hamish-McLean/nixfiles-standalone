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
    ./bat.nix
    ./btop.nix
    ./direnv.nix
    ./eza.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gitui.nix
    ./helix.nix
    ./kitty.nix
    ./nixvim.nix
    ./pandoc.nix
    ./starship.nix
    ./tmux.nix
    ./zoxide.nix
    # ./warp.nix
  ];

  # Option to enable all cliPrograms modules
  options = {
    cliPrograms.enable = lib.mkEnableOption "enables cliPrograms";
  };
  config = lib.mkIf config.cliPrograms.enable {
    bat.enable = lib.mkDefault true;
    btop.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    fish.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    gitui.enable = lib.mkDefault true;
    # helix.enable = lib.mkDefault true;
    kitty.enable = lib.mkDefault true;
    nixvim.enable = lib.mkDefault true;
    pandoc.enable = lib.mkDefault true;
    starship.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    # warp.enable = lib.mkDefault true; Installed from unstablePkgs
    zoxide.enable = lib.mkDefault true;

    # Extra programs
    # programs = {
    #   htop.enable = lib.mkDefault true;
    # };
  };
  
}
