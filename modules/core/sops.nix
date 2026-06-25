{
  config,
  inputs,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.core.sops;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.custom.modules.core.sops = {
    enable = mkEnableOption "Enable sops";
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/cycad/.config/sops/age/keys.txt";
      secrets = { };
    };

  };
}
