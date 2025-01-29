{
  pkgs,
  ...
}:
{
  config = {
    users.users.cycad = {
      isNormalUser = true;
      description = "Hamish McLean";
      extraGroups = [
        "input"
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
