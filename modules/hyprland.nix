{ pkgs, lib, config, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland.enable = true;

    services = {
      xserver = {
        # Enable X11
        enable = true;
        # Enable display manager
        displayManager.sddm.enable = true;
        displayManager.sddm.wayland.enable = true;
        # Configure keymap in X11
        layout = "gb";
        xkbVariant = "";
        # excludePackages = [ pkgs.xterm ];
      };
    };

    programs = {
      fish.enable = true;
      # kdeconnect.enable = true;
      gnome-terminal.enable = true;
    };

    environment.systemPackages = with pkgs.gnome; [
      gnome-terminal
    ];
  };
}