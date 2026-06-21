{
  inputs,
  lib,
  pkgs,
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

  # Keyboard
  services.xserver.xkb.layout = lib.mkDefault "gb";
  console.useXkbConfig = true;
  console.keyMap = lib.mkDefault "uk";

  # Network
  # DNS
  libredns.enable = lib.mkDefault true;

  # Firewall
  networking = {
    firewall.enable = true;
    nftables.enable = true;
  };

  # Nix
  nix = {
    # nixPath = [ "nixpkgs=${nixpkgs}" ];
    settings = {
      accept-flake-config = true;
      auto-optimise-store = true; # deduplicates nix store when files are added; adds overhead
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };
    gc.automatic = false; # disable automatic garbage collection to handle with nh instead
  };

  security.sudo.wheelNeedsPassword = true;

  services.ddccontrol.enable = true;

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/cycad/.config/sops/age/keys.txt";
    secrets = { };
  };

  environment.systemPackages = (
    with pkgs;
    [
      curl
      ddcutil
      fish
      git
      nano
      nixd
      nixfmt
      nmap
      pet
      wget
    ]
  );

}
