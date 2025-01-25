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
