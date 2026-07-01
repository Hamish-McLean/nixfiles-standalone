{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.desktop;
in
{
  imports = [ ../modules ];

  options.custom.profiles.desktop = {
    enable = mkEnableOption "Enable desktop profile";
  };

  config = mkIf cfg.enable {
    custom.modules.desktop = mkDefault {
      niri.enable = true;
      noctalia-greeter.enable = true;
    };

    custom.modules.hardware = mkDefault {
      audio.enable = true;
      bluetooth.enable = true;
      ddc.enable = true;
      printing.enable = true;
    };

    custom.modules.network = mkDefault {
      # libredns.enable = true;
      opensnitch.enable = false;
      stevenblack.enable = true;
    };

    boot.plymouth.enable = mkDefault true;

    programs = {
      firefox.enable = mkDefault true;
      kdeconnect.enable = mkDefault true;
      ladybird.enable = mkDefault true;
    };

    services.flatpak.enable = mkDefault true;

    virtualisation.waydroid.enable = true;
  };
}
