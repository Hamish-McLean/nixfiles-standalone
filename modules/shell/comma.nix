{
  config,
  inputs,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.shell.comma;
in
{
  imports = [ inputs.nix-index-database.nixosModules.default ];

  options.custom.modules.shell.comma = {
    enable = mkEnableOption "Enable comma for nix-index-database";
  };

  config = mkIf cfg.enable {
    programs.nix-index-database.comma.enable = true;
  };
}
