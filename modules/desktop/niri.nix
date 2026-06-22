{
  config,
  inputs,
  lib,
  ...
}:
{
  imports = [ inputs.niri.nixosModules.niri ];

  options = {
    niri.enable = lib.mkEnableOption "enable niri";
  };

  config = lib.mkIf config.niri.enable {
    programs.niri = {
      enable = true;
    };
    programs.uwsm = {
      enable = lib.mkDefault true;
      waylandCompositors = {
        niri = {
          prettyName = "Niri";
          comment = "Niri compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/niri";
          extraArgs = [ "--session" ];
        };
      };
    };
  };
}
