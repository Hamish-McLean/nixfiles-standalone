{ config, lib, pkgs, ... }:
{
  options = {
    gnome_config.enable = lib.mkEnableOption "enables gnome_config";
  };

  config = lib.mkIf config.gnome_config.enable {
    # GNOME dconf settings
    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;

        # `gnome-extensions list` for a list
        enabled-extensions = [
          "gsconnect@andyholmes.github.io"
          "iso8601ish@S410"
          "just-perfection-desktop@just-perfection"
          "mprisLabel@moon-0xff.github.com"
          "trayIconsReloaded@selfmade.pl"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };
    };

    home.packages = with pkgs.gnomeExtensions; [
      gsconnect
      iso8601-ish-clock
      just-perfection
      mpris-label
      tray-icons-reloaded
      user-themes
    ];
    # ]) ++ (with pkgs; [
    #   nerdfonts
    # ]);
    # (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  };
}