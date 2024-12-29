{ pkgs, system, lib, inputs, helix, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  time.timeZone = "Europe/London";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    # Automate garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 5";
    };
  };

  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = (with pkgs; [
    btop
    curl
    ddgr
    du-dust
    fish
    gh # Github
    git
    github-copilot-cli
    # helix.packages."${pkgs.system}".helix
    htop
    nano
    fastfetch
    neovim
    nh # Nix helper
    nmap
    onefetch
    pet
    tldr
    tmux
    tree
    wget
  ]);

}
