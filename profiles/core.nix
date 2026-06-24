{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.profiles.core;
in
{
  imports = [ ../modules ];

  options.custom.profiles.core = {
    enable = mkEnableOption "Enable core profile";
  };

  config = mkIf cfg.enable {
    custom.modules.core = mkDefault {
      catppuccin.enable = true;
      locale.enable = true;
      nix.enable = true;
      sops.enable = false;
    };

    custom.modules.hardware = mkDefault {
      keyboard.enable = true;
    };

    custom.modules.network = mkDefault {
      firewall.enable = true;
    };

    custom.modules.shell = mkDefault {
      nh.enable = true;
      packages.enable = true;
      sudo-rs.enable = false;
    };
  };
}
