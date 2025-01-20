{
  pkgs,
  ...
}:
{
  imports = [
    ../common.nix
  ];
  # environment.packages = with pkgs; [
  #   fish
  #   gh
  #   git
  # ];

  programs.fish.enable = true;

  user.shell = pkgs.fish;

  # nix.extraOptions = ''
  #   experimental-features = nix-command flakes
  # '';

  system.stateVersion = "24.05";
}