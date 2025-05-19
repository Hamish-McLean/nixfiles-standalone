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
        "adbusers"
        "input"
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.fish;
    };
  };
}
