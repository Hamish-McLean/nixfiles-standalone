{ config, lib, pkgs, ... }:
{
  imports = [
    ./waybar.nix
    ./rofi.nix
  ];
  
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };
  
  config = lib.mkIf config.hyprland.enable {
    
    home.packages = with pkgs; [
      rofi
      tofi
      wofi
    ];
    
    # programs.hyprlock.enable = true;
    programs.tofi.enable = true;

    rofi.enable = true;
    waybar.enable = true;
    
    catppuccin = {
      hyprland.enable = true;
      tofi.enable = true;
    };
    
    wayland.windowManager.hyprland = {
      enable = true;
      # catppuccin.enable = true;
      # plugins = with pkgs.hyprlandPlugins; [
      #   hyprbars
      #   hyprspace
      #   hyprtrails
      # ];
      settings = {
        monitor = [
          "eDP-1,preferred,auto,1" # Scaling for laptop screen
          "HDMI-A-2,preferred,auto,1" # Scaling for external monitor
        ];
        input = {
          kb_layout = "gb";
        };
        "$mod" = "SUPER";
        bind = [
          # "$mod, exec, rofi -show drun, release"
          "$mod, SPACE, exec, rofi -show drun"
          "$mod, C, killactive"
          "$mod, E, exec, nautilus"
          "$mod, F, exec, firefox"
          "$mod, J, togglesplit"
          "$mod, K, exec, kitty"
          "$mod, M, exit"
          "$mod, R, exec, rofi -show drun"
          "$mod, V, togglefloating"
          ", Print, exec, grimblast copy area"

          # Windows
          "$mod, LEFT, swapnext"
          "$mod, RIGHT, swapnext"
          "$mod SHIFT, LEFT, movetoworkspace, -1"
          "$mod SHIFT, RIGHT, movetoworkspace, +1"
          "CTRL, TAB, focuswindow, r"
          "CTRL SHIFT, TAB, focuswindow, l"
        ] ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          ) 10)

        );
        # Mouse binds. LMB -> 272, RMB -> 273.
        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
      };
    };
  };
}