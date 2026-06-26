_: {
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "nixfiles";

      packages = [
        pkgs.just
        pkgs.statix # Helpful linting suggestions
        pkgs.nvd # For generation diffs
      ];

      shellHook = ''
        # Standard ANSI 16-color names
        # 36 = Cyan, 34 = Blue, 32 = Green, 0 = Reset. Adding '1;' makes it Bold.
        COLOR_TITLE='\033[1;34m'  # Will render as Catppuccin Blue / Sapphire
        COLOR_ACCENT='\033[1;36m' # Will render as Catppuccin Cyan / Sky
        COLOR_RESET='\033[0m'

        echo -e "''${COLOR_TITLE}  nixfiles development shell active''${COLOR_RESET}"
        # echo -n "Available shortcuts: "
        # echo -en "''${COLOR_ACCENT}just fmt''${COLOR_RESET}, "
        # echo -en "''${COLOR_ACCENT}just check''${COLOR_RESET}, "
        # echo -en "''${COLOR_ACCENT}just diff''${COLOR_RESET}"
      '';
      # shellHook = ''
      #   echo "  Nixfiles development shell active"
      #   echo -e "Available shortcuts: just fmt, just check, just diff"
      # '';
    };
  };
}
