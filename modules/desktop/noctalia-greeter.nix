{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.custom.modules.desktop.noctalia-greeter;
in
{
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  options.custom.modules.desktop.noctalia-greeter = {
    enable = lib.mkEnableOption "Enable noctalia-greeter";
  };

  config = lib.mkIf cfg.enable {
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
