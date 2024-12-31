{
  pkgs,
  lib,
  config,
  hyprland,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland = {
      enable = true;
      # package = hyprland.packages.pkgs.hyprland;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      kitty
      waybar
    ];

    # services.xserver.displayManager.gdm.wayland = true;
    services.displayManager.sddm = {
      enable = true;
      package = pkgs.kdePackages.sddm;
      # theme = "catppuccin-mocha";
    };
    catppuccin.sddm.enable = true;

    # services = {
    #   xserver = {
    #     # Enable X11
    #     enable = true;
    #     # Enable display manager
    #     displayManager.sddm.enable = true;
    #     displayManager.sddm.wayland.enable = true;
    #     # Configure keymap in X11
    #     layout = "gb";
    #     xkbVariant = "";
    #     # excludePackages = [ pkgs.xterm ];
    #   };
    # };

  };
}
