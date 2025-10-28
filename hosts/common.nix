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
  ];

  # Locale
  time.timeZone = lib.mkDefault "Europe/London";
  i18n.defaultLocale = lib.mkDefault "en_GB.UTF-8";
  i18n.extraLocaleSettings.LC_TIME = lib.mkDefault "en_DK.UTF-8"; # ISO 8601 datetimes

  # Network
  # DNS
  networking.nameservers = [
    "116.202.176.26#noads.libredns.gr"
    "2a01:4f8:1c0c:8274::1#noads.libredns.gr"
  ];
  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic"; # "opportunistic" will attempt to encrypt DNS
    dnssec = "true";
    fallbackDns = [
      "1.1.1.1#one.one.one.one"
      "2606:4700:4700::1111#one.one.one.one"
      "1.0.0.1#one.one.one.one"	
      "2606:4700:4700::1001#one.one.one.one"
    ];
  };

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
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 60d";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/home/cycad/.config/sops/age/keys.txt";
    secrets = { };
  };

  environment.systemPackages = (
    with pkgs;
    [
      btop
      curl
      fish
      gh # Github
      git
      # helix.packages."${pkgs.system}".helix
      htop
      nano
      fastfetch
      neovim
      nh # Nix helper
      nixd
      nixfmt-rfc-style
      nmap
      onefetch
      pet
      tldr
      tmux
      wget
    ]
  );

}
