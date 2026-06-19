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
        "docker"
        "input"
        "i2c"
        "networkmanager"
        "video"
        "wheel"
      ];
      linger = true;
      shell = pkgs.nushell;
    };
  };
}
