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
  };
}
