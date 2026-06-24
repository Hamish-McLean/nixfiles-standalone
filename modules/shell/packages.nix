{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.custom.modules.shell.packages;
in
{
  options.custom.modules.shell.packages = {
    enable = mkEnableOption "Enable extra system packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      curl
      git
      nano
      nixd
      nixfmt
      nmap
      pet
      wget
    ];
  };
}
