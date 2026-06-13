{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  options = {
    noctalia-greet.enable = lib.mkEnableOption "enable noctalia-greeter";
  };

  config = lib.mkIf config.noctalia-greet.enable {
    programs.noctalia-greeter = {
      enable = true;
      # greeter-args = "";
    };

    services.greetd.settings.default = {
      # command = "";
      user = "greeter";
    };

    users.users.greeter = {
      group = "greeter";
      isSystemUser = true;
    };
    users.groups.greeter = { };
  };
}
