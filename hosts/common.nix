{
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
{

  imports = [
    inputs.sops-nix.nixosModules.sops
    ../modules
  ];

  # Locale
  time.timeZone = lib.mkDefault "Europe/London";
  i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = lib.mkDefault "en_DK.UTF-8"; # ISO 8601 datetimes

  # Network
  # DNS
  libredns.enable = lib.mkDefault true;

  # Nix
  nix = {
    # nixPath = [ "nixpkgs=${nixpkgs}" ];
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
    gc.automatic = false; # disable automatic garbage collection to handle with nh instead
  };

  security.sudo.wheelNeedsPassword = false;

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/cycad/.config/sops/age/keys.txt";
    secrets = { };
  };

  environment.systemPackages = (with pkgs; [
    curl
    fish
    git
    nano
    nixd
    nixfmt-rfc-style
    nmap
    pet
    wget
  ]);

}
