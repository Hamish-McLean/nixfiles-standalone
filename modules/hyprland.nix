{
  config,
  hyprland,
  inputs,
  lib,
  pkgs,
  system,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      # package = inputs.hyprland.packages.${system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland;
    };

    # environment.systemPackages = with pkgs; [
    #   kitty
    # ];

    # services.xserver.displayManager.gdm.wayland = true;
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };

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
