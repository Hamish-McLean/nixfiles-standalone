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

    systemd.tmpfiles.rules = [
      (
        "f /var/lib/noctalia-greeter/greeter.toml 0640 greeter greeter - "
        + "[output]\\n"
        + "name = \"DP-2\""
        + "\\n\\n"
        + "[appearance]\\n"
        + "password_style = \"random\""
      )
    ];

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
