{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    gnome.enable = lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.gnome.enable {
    services = {
      xserver = {
        # Enable X11
        enable = true;
        # Enable GNOME DM
        desktopManager.gnome.enable = true;
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

    environment.systemPackages = (
      with pkgs;
      [
        gnome-tweaks
        gnome-terminal
        gnomeExtensions.gsconnect
        nautilus
      ]
    );
  };
}
