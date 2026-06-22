{
  config,
  lib,
  pkgs,
  ...
}:
let
  # Catppuccin Mocha - Sapphire Focused
  sapphire = "#74c7ec"; # Primary Accent
  sky = "#89dceb"; # Secondary Accent
  lavender = "#b4befe"; # Action Accent
  text = "#cdd6f4"; # Main Text
  subtext0 = "#a6adc8"; # Dimmer Text
  surface2 = "#585b70"; # Button/UI Elements
in
{
  options = {
    tuigreet.enable = lib.mkEnableOption "enable tuigreet";
  };

  config = lib.mkIf config.tuigreet.enable {
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = pkgs.lib.concatStringsSep " " [
          "${pkgs.tuigreet}/bin/tuigreet"
          "--time"
          "--remember"
          "--remember-user"
          "--cmd niri-session"
          "--theme 'border=${sapphire};text=${text};prompt=${sapphire};time=${sky};action=${lavender};button=${surface2}'"
        ];
        user = "greeter";
      };
      useTextGreeter = true;
    };
  };
}
