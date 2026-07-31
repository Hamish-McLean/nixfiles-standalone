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
      settings = {
        appearance = {
          hide_logo = true;
          password_style = "random";
          scheme = "Synced";
        };
        output.name = "DP-2";
        session.default = "Niri (UWSM)";
        user.default = "cycad";
      };
    };

    services.accounts-daemon.enable = true; # For profile picture

    services.greetd.settings.default = {
      # command = "";
      user = "greeter";
    };

    systemd.services.greetd.restartIfChanged = false;

    users.users.greeter = {
      extraGroups = [
        "video"
        "render"
      ]; # Crucial for Wayland greeter compositors
      group = "greeter";
      isSystemUser = true;
    };
    users.groups.greeter = { };
  };
}
