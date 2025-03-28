{
  config,
  pkgs,
  lib,
  ...
}:
rec {
  home = {
    sessionPath = [
      "$HOME/.pnpm-packages/bin"
      "$HOME/.pnpm-packages"
      "$HOME/.npm-packages/bin"
      "$HOME/bin"
      "$HOME/.local/share/bin"
    ];
    sessionVariables = {
      # default editor
      EDITOR = "${lib.getBin pkgs.neovim}/bin/nvim";
      VISITOR = home.sessionVariables.EDITOR;
      ALTERNATE_EDITOR = "code";

      # zsh vi mode
      ZVM_VI_HIGHLIGHT_FOREGROUND = "black";
      ZVM_VI_HIGHLIGHT_BACKGROUND = "magenta";

      # TODO: nvim
      SQLITE_LIB_PATH = "${pkgs.sqlite.out}/lib/libsqlite3.${
        if pkgs.stdenv.isDarwin then "dylib" else "so"
      }";
    };
  };

  programs.zsh = {
    enable = false;
    autocd = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
      {
        name = "zsh-plugin-pnpm";
        src = pkgs.fetchFromGitHub {
          owner = "Leizhenpeng";
          repo = "zsh-plugin-pnpm";
          rev = "master";
          sha256 = "vpOiEhnsntg6GwOg2wvcRX3fV2NDl3nKuXEhn06l1m8=";
        };
        file = "pnpm.plugin.zsh";
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
      # {
      #     name = "powerlevel10k";
      #     src = pkgs.zsh-powerlevel10k;
      #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      # {
      #     name = "powerlevel10k-config";
      #     src = lib.cleanSource ./config;
      #     file = "p10k.zsh";
      # }
    ];

    shellAliases = {
      v = "$EDITOR -b";
      q = "exit";
      nvim = "$EDITOR -b";
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
      search = "rg -p --glob '!node_modules/*'  $@";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
    };

    initExtraFirst = # bash
      ''
        if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
          . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
        fi

        # Define variables for directories
        export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
        export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
        export PATH=$HOME/.local/share/bin:$PATH

        # nix shortcuts
        shell() {
            nix-shell '<nixpkgs>' -A "$1"
        }

        function nvim_plugins_update() {
          echo "[nvim] updating lazy plugins..."
          command nvim --headless "+Lazy! update" +qa
          echo "[nvim] lazy plugins updated..."

          CURRENT_DIR=$(pwd)
          cd ~/.config/nvim
          git restore --staged .
          git add ./lazy-lock.json
          git add ./spell/en.utf-8.add
          git add ./spell/en.utf-8.add.spl
          git commit -m "chore(lazy): bump versions"
          cd $CURRENT_DIR
        }
      '';
  };
}
