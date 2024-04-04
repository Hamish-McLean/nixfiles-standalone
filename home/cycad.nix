{ config, pkgs, lib, unstablePkgs, nixvim, ... }:
{
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
  
  # Programs

  programs = {
    
    fish = {
      enable = true;
      interactiveShellInit = ''
        set -U fish_greeting "🐟"
      '';
      # plugins = [ { name = "tide"; src = pkgs.fishPlugins.tide.src; } ];
      
      # plugins = with pkgs.fishPlugins; [
        # fzf-fish.src
        # pure.src
        # tide.src
      # ];
    };

    git = {
      enable = true;
      userEmail = "HamishMcLean94@gmail.com";
      userName = "Hamish McLean";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    starship = {
      enable = true;
      # Configuration written to ~/.config/starship.toml
      settings = {
        # add_newline = false;

        # character = {
        #   success_symbol = "[➜](bold green)";
        #   error_symbol = "[➜](bold red)";
        # };

        # package.disabled = true;
      };
    };
    
    tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      #keyMode = "vi";
      clock24 = true;
      historyLimit = 10000;
      plugins = with pkgs.tmuxPlugins; [
        catppuccin
        better-mouse-mode
      ];
    };

    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   viAlias = true;
    #   vimAlias = true;
    #   vimdiffAlias = true;
    #   plugins = with pkgs.vimPlugins; [
    #     catppuccin-nvim
    #     dashboard-nvim
    #     feline-nvim
    #     lspsaga-nvim
    #   ];
    #   # Use the Nix package search engine to find
    #   # even more plugins : https://search.nixos.org/packages
    # };

    nixvim = {
      enable = true;
      colorschemes.catppuccin = {
        enable = true;
        flavour = "mocha";
      };
      plugins = {
        bufferline.enable = true;
        lualine.enable = true;
        # neoscroll.enable = true;
        nvim-tree.enable = true;
      };
    };

    vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        jnoortheen.nix-ide
      ];
    };

  };

  # Other configs

  fonts.fontconfig.enable = true;
  # home.packages = [
  #   (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  # ];

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "teal" ];
        size = "standard";
        # tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
  };

  # Now symlink the `~/.config/gtk-4.0/` folder declaratively:
  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };

  # GNOME dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # `gnome-extensions list` for a list
      enabled-extensions = [
        "gsconnect@andyholmes.github.io"
        "iso8601ish@S410"
        "just-perfection-desktop@just-perfection"
        "mprisLabel@moon-0xff.github.com"
        "trayIconsReloaded@selfmade.pl"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
  };

  home.packages = (with pkgs.gnomeExtensions; [
    gsconnect
    iso8601-ish-clock
    just-perfection
    mpris-label
    tray-icons-reloaded
    user-themes
  ]) ++ (with pkgs; [
    nerdfonts
  ]);
  # (pkgs.nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })

}