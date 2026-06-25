{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.core.nix;
in
{
  options.custom.modules.core.nix = {
    enable = mkEnableOption "Enable nix settings";
  };

  config = mkIf cfg.enable {
    nix.settings = mkDefault {
      accept-flake-config = true;
      auto-optimise-store = true; # deduplicates nix store when files are added; adds overhead
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };
    nix.gc.automatic = mkDefault false; # disable automatic garbage collection to handle with nh
  };
}
