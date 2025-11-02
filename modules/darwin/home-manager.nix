{
  config,
  pkgs,
  catppuccin,
  ...
}:

let
  user = "demian";
  # Define the content of your file as a derivation
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
    ./modules/skhd.nix
    ./modules/yabai.nix
    ./modules/postgresql.nix
    ./modules/sketchybar/sketchybar.nix
    ./modules/borders.nix
  ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.fish;
    ignoreShellProgramCheck = true;
  };

  security = {
    pam = {
      services = {
        sudo_local = {
          enable = true;
          reattach = true;
          touchIdAuth = true;
          watchIdAuth = true;
        };
      };
    };
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./casks.nix { };
    onActivation = {
      # autoUpdate = true;
      # FIXME: error on casks uninstall https://github.com/zhaofengli/nix-homebrew/issues/5
      # cleanup = "uninstall";
    };
    # taps = builtins.attrNames config.nix-homebrew.taps;

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
      # telegram = 747648890;
      # whatsapp = 310633997;
      # nextdns = 1464122853;
      # paste = 967805235;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    users.${user} =
      {
        pkgs,
        config,
        lib,
        ...
      }:
      {
        programs.fish.enable = true;
        imports = [
          ../shared/home-manager.nix
          catppuccin.homeModules.catppuccin
        ];
        home = {
          enableNixpkgsReleaseCheck = false;

          packages = pkgs.callPackage ./packages.nix { };
          file = lib.mkMerge [
            sharedFiles
            additionalFiles
          ];
          stateVersion = "23.11";
        };
        # disable Home Manager's man in favor of Nix-Darwin's
        programs.man.enable = false;
      };
  };
}
