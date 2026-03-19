{
  config,
  lib,
  ...
}:
{
  options = {
    regreet.enable = lib.mkEnableOption "enable regreet";
  };

  config = lib.mkIf config.regreet.enable {
    programs.regreet = {
      enable = true;
      settings = {};
    };
  };
}
