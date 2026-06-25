{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.users.cycad;
in
{
  options.custom.modules.users.cycad = {
    enable = mkEnableOption "Enable user cycad";
  };

  config = lib.mkIf cfg.enable {
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
