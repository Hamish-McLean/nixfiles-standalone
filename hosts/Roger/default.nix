{
  hostname,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    defaultUser = "cycad";
  };

  networking.hostName = "Roger";

  programs.fish.enable = true;

  users.users.cycad = {
    isNormalUser = true;
    packages = with pkgs; [
      fish
      neovim
      tmux
    ];
    shell = pkgs.fish;
  };

  system.stateVersion = "23.11";
}
