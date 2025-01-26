{
  pkgs,
  lib,
  ...
}:
rec {
  home = {
    sessionPath = [
      "$HOME/nixos-config/bin"
    ];
    sessionVariables = {
      # default editor
      EDITOR = "${lib.getBin pkgs.neovim}/bin/nvim";
      VISITOR = home.sessionVariables.EDITOR;
      ALTERNATE_EDITOR = "code";
    };
  };
  programs.fish = {
    enable = true;
    generateCompletions = true;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "ddeb28a7b6a1f0ec6dae40c636e5ca4908ad160a";
          sha256 = "0c5i7sdrsp0q3vbziqzdyqn4fmp235ax4mn4zslrswvn8g3fvdyh";
        };
      }
    ];

    shellAbbrs = {
      q = "exit";
      n = "pnpm nx";
      psb = "pnpm run storybook";
      y = "pbcopy";
      su = "softwareupdate";
      opf = "op-fuzzy";
      opfi = "op-fuzzy-pbcopy-id";
      ls = "ls --color=auto";
      l = "eza -1 --long --icons --git";
      lsm = "l --sort=modified";
      lgi = "l --git-ignore";
      yr = "yabai --restart-service";
      ys = "yabai_sudoers";
      diff = "difft";
      search = "rg -p --glob '!node_modules/*'";

      # pnpm commands
      p = "pnpm";
      pex = "pnpm exec"; # Execute a shell command in the scope of a project
      pdx = "pnpm dlx"; # Fetch a package without installing, hotload and run its command
      pa = "pnpm add"; # Install a package in dependencies (package.json)
      pad = "pnpm add --save-dev"; # Install a package in devDependencies (package.json)
      prm = "pnpm remove"; # Remove installed packages
      pls = "pnpm list"; # List installed packages
      pap = "pnpm add --save-peer"; # Install a package in peerDependencies (package.json)
      pi = "pnpm init"; # Interactively create or update a package.json file
      pin = "pnpm install"; # Install dependencies defined in package.json
      prun = "pnpm run"; # Run a defined package script
      pst = "pnpm start"; # Run the start script defined in package.json
      pln = "pnpm run lint"; # Run the lint script defined in package.json
      pdocs = "pnpm run docs"; # Run the docs script defined in package.json
      pb = "pnpm run build"; # Run the build script defined in package.json
      pd = "pnpm run dev"; # Run the dev script defined in package.json
      psv = "pnpm run serve"; # Run the serve script defined in package.json
      pt = "pnpm test"; # Run the test script defined in package.json
      ptc = "pnpm test --coverage"; # Run the test script defined in package.json with coverage
      pu = "pnpm update"; # Update packages to their latest version based on the specified range
      puil = "pnpm update --interactive --latest"; # Prompt for which outdated packages to upgrade
      pc = "pnpm create"; # Create a project from a create-* starter kit
      ppub = "pnpm publish"; # Publish a package to the registry
      pf = "pnpm -r --filter"; # Use filter in a monorepo root directory
      pre = "pnpm run preview"; # Run the preview script defined in package.json
      pr = "pnpm run release"; # Run the release script defined in package.json
    };

    shellAliases = {
      v = "$EDITOR";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
    };

    shellInit = # fish
      ''
        if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
            source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
        end

        if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.fish
            source /nix/var/nix/profiles/default/etc/profile.d/nix.fish
        end

        # Disable the startup message
        set -U fish_greeting
        fish_vi_key_bindings
      '';

    functions = {
      nvim_plugins_update = # fish
        ''
          echo "[nvim] updating lazy plugins..."
          command nvim --headless "+Lazy! update" +qa
          echo "[nvim] lazy plugins updated..."

          set CURRENT_DIR (pwd)
          cd ~/.config/nvim
          git restore --staged .
          git add ./lazy-lock.json
          git add ./spell/en.utf-8.add
          git add ./spell/en.utf-8.add.spl
          git commit -m "chore(lazy): bump versions"
          cd $CURRENT_DIR
        '';
    };
  };
}
