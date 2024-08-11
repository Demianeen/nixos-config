{ config, pkgs, lib, home-manager, catppuccin, ... }:

let
  user = "demian";
  # Define the content of your file as a derivation
  myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
    #!/bin/sh
    emacsclient -c -n &
  '';
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in {
  imports = [
    ./dock
    ./modules/skhd.nix
    ./modules/yabai.nix
    ./modules/postgresql.nix
    ./modules/sketchybar/sketchybar.nix
    ./modules/borders.nix
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    global = { autoUpdate = true; };
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
    };

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    masApps = {
      # "1password" = 1333542190;
      # "wireguard" = 1451685025;
      telegram = 747648890;
      # paste = 967805235;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = { pkgs, config, lib, ... }: {
      imports =
        [ ../shared/home-manager.nix catppuccin.homeManagerModules.catppuccin ];
      home = {
        enableNixpkgsReleaseCheck = false;

        packages = pkgs.callPackage ./packages.nix { };
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
          { "emacs-launcher.command".source = myEmacsLauncher; }
        ];
        stateVersion = "23.11";
      };
      # disable Home Manager's man in favor of Nix-Darwin's
      programs.man.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      entries = [
        { path = "/Applications/Spotify.app/"; }
        { path = "/Applications/Things3.app/"; }
        { path = "/Applications/Amie.app/"; }
        { path = "/Applications/WezTerm.app/"; }
        { path = "/Applications/Telegram.app/"; }
        { path = "/Applications/Arc.app/"; }
        {
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort dateadded --view fan --display stack";
        }
      ];
    };
  };
}
