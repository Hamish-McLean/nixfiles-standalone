{ pkgs, ... }:

{
  config = {
    #home-manager.users.cycad = /home/cycad/.config/home-manager/home.nix;
    users.users.cycad = {
      isNormalUser = true;
      description = "Hamish McLean";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
