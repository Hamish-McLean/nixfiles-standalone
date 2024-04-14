{ config, lib, pkgs, ... }:

{
  environment.packages = with pkgs; [
    fish
    gh
    git
  ];

  #programs.fish.enable = true;

  users.users.nix-on-droid.shell = pkgs.fish;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  ''

  system.stateVersion = "23.11"
}