{
  hostname,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
    inputs.vscode-server.nixosModules.default
    inputs.vscodium-server.nixosModules.default
    ../../modules
    ../../users/cycad.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "cycad";
  };

  # Networking
  networking.hostName = "Roger";
  libredns.enable = false;

  programs.fish.enable = true;

  # VSCode
  services.vscode-server.enable = true;
  services.vscodium-server.enable = true;

  system.stateVersion = "23.11";
}
