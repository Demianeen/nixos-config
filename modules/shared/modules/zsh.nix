{ config, pkgs, lib, ... }: rec {
  home = {
    sessionPath = [
      "$HOME/.pnpm-packages/bin"
      "$HOME/.pnpm-packages"
      "$HOME/.npm-packages/bin"
      "$HOME/bin"
      "$HOME/.local/share/bin"
    ];
    sessionVariables = {
      # FIXME: nvim is not found
      EDITOR = "nvim -b";
      VISITOR = home.sessionVariables.EDITOR;
      ALTERNATE_EDITOR = "code";
    };
  };

  programs.zsh = {
    enable = true;
    autocd = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
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

    zplug = {
      enable = true;
      plugins = [{ name = "Leizhenpeng/zsh-plugin-pnpm"; }];
    };

    shellAliases = {
      # zshrc="ce ~/.zshrc";
      # lazyvimjson="ce ~/.config/nvim/lazyvim.json";
      # ohmyzsh="$EDITOR ~/.oh-my-zsh";
      # zsh-plugins="~/.oh-my-zsh/custom/plugins";
      v = "nvim -b";
      n = "pnpm nx";
      nl = "n lint";
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
    };

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }
    '';
  };
}
