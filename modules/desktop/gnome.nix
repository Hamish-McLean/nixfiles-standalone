{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.custom.modules.desktop.gnome;
in
{
  options.custom.modules.desktop.gnome = {
    enable = lib.mkEnableOption "Enable gnome";
  };

  config = lib.mkIf cfg.enable {
    services = {
      desktopManager.gnome.enable = true;
      xserver = {
        # Enable X11
        enable = true;
        # Enable GNOME DM
        excludePackages = [ pkgs.xterm ];
      };
      gnome = {
        # Disable default GNOME core-utilities
        core-apps.enable = true;
        # Enable GNOME utilities
        sushi.enable = true;
      };
    };

    networking.firewall.allowedTCPPortRanges = [
      # gsconnect
      {
        from = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      # gsconnect
      {
        from = 1714;
        to = 1764;
      }
    ];

    programs = {
      dconf.enable = true;
      gnome-terminal.enable = true;
    };

    environment.systemPackages = with pkgs; [
      gnome-tweaks
      gnome-terminal
      gnomeExtensions.gsconnect
      nautilus
    ];
  };
}
