{ config, lib, pkgs, ... }:
{
  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };
  config = lib.mkIf config.hyprland.enable {
    programs.waybar.enable = true;
    home.packages = with pkgs; [
      wofi
    ];
    catppuccin.hyprland.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      # catppuccin.enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, F, exec, firefox"
          "$mod, Q, exec, kitty"
          "$mod, M, exit"
          "$mod, E, exec, nautilus"
          "$mod, V, togglefloating"
          "$mod, C, killactive"
          "$mod, J, togglesplit"
          ", Print, exec, grimblast copy area"
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