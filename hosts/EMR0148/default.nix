{
  config,
  lib,
  pkgs,
  nixos-wsl,
  vscode-server,
  ...
}:

{
  imports = [
    ../common.nix
    nixos-wsl.nixosModules.wsl
    vscode-server.nixosModules.default
  ];

  wsl = {
    enable = true;
    defaultUser = "cycad";
  };

  networking.hostName = "EMR0148";

  # vscode server as a module -- try import this module as a separate file
  services.vscode-server.enable = true;

  programs.fish.enable = true;

  users.users.cycad = {
    isNormalUser = true;
    packages = with pkgs; [
      fish
      gh
      git
      # helix.packages."${pkgs}".helix
      neovim
      tmux
      wget
    ];
    shell = pkgs.fish;
  };

  system.stateVersion = "23.11";
}
