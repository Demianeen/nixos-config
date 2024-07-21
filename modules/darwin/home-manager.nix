{ config, pkgs, lib, home-manager, ... }:

let
  user = "demian";
  # Define the content of your file as a derivation
  myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
    #!/bin/sh
    emacsclient -c -n &
  '';
  sharedFiles = import ../shared/files.nix { inherit config pkgs; };
  additionalFiles = import ./files.nix { inherit user config pkgs; };
in
{
  imports = [
   ./dock
		./modules/skhd.nix
		./modules/yabai.nix
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
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

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
    users.${user} = { pkgs, config, lib, ... }:{
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          additionalFiles
          { "emacs-launcher.command".source = myEmacsLauncher; }
        ];
				sessionPath = [
					"$HOME/.pnpm-packages/bin"
					"$HOME/.pnpm-packages"
					"$HOME/.npm-packages/bin"
					"$HOME/bin"
					"$HOME/.local/share/bin"
				];

				sessionVariables = {
					EDITOR = "nvim -b";
					VISITOR = config.home.sessionVariables.EDITOR;
					ALTERNATE_EDITOR = "code";
				};

        stateVersion = "23.11";
      };
			editorconfig = {
				enable = true;
				settings = {
					"*" = {
						charset = "utf-8";
						trim_trailing_whitespace = true;
						insert_final_newline = true;
						max_line_width = 80;
						indent_style = "tab";
					};
				};
			};



      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
      } // import ../shared/home-manager.nix { inherit config pkgs lib; };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = false;
      entries = [
        { path = "/Applications/Spotify.app/"; }
				{ path = "/Applications/Things3.app/"; }
				{ path = "/Applications/Amie.app/"; }
        { path = "/Applications/WezTerm.app/"; }
        { path = "/Applications/Telegram.app/"; }
        { path = "/Applications/Arc.app/"; }
        {
          path = "${config.users.users.${user}.home}/.local/share/";
          section = "others";
          options = "--sort name --view grid --display folder";
        }
        {
          path = "${config.users.users.${user}.home}/Downloads";
          section = "others";
          options = "--sort name --view grid --display stack";
        }
      ];
    };
  };
}
