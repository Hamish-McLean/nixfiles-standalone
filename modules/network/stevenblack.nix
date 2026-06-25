/*
  StevenBlack

  Local ad and content blocker

  🔒 Consolidating and extending hosts files from several well-curated sources.
  Optionally pick extensions for porn, social media, and other categories.
*/
{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.custom.modules.network.stevenblack;
in
{
  options.custom.modules.network.stevenblack = {
    enable = mkEnableOption "Enable StevenBlack local ad and content blocker";
  };

  config = mkIf cfg.enable {
    networking.stevenblack = {
      enable = true;
      block = [
        "fakenews"
        "gambling"
      ]; # Options: "fakenews" "gambling" "porn" "social"
      whitelist = [ ];
    };
  };
}
