{ config, lib, pkgs, nixos-wsl, ... }:

{
  imports = [
    nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = "cycad";
  };

  networking.hostName = "EMR0148";

  programs.fish.enable = true;

  users.users.cycad = {
    isNormalUser = true;
    packages = with pkgs; [
      fish
      gh
      git
      neovim
      tmux
      wget
    ];
    shell = pkgs.fish;
  };

  system.stateVersion = "23.11";
}
