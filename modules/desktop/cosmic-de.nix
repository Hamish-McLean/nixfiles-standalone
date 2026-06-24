{
  config,
  # inputs,
  lib,
  ...
}:
let
  cfg = config.custom.modules.desktop.cosmic;
in
{
  imports = [
    # inputs.cosmic.nixosModules.default
  ];

  options.custom.modules.desktop.cosmic = {
    enable = lib.mkEnableOption "Enable cosmic";
  };

  config = lib.mkIf cfg.enable {

    # nix.settings = {
    #   substituters = [ "https://cosmic.cachix.org/" ];
    #   trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
    # };

    services.desktopManager.cosmic.enable = true;
    services.displayManager.cosmic-greeter.enable = false;

    # environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID";
    # security.pam.services.cosmic-greeter.enableGnomeKeyring = true;
  };

}
