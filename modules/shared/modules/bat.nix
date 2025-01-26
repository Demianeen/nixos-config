{ pkgs, ... }: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batgrep
      batman
      batpipe
      batwatch
      batdiff
      prettybat
    ];
  };

  home = {
    sessionVariables = {
      BATDIFF_USE_DELTA = "true";
    };
  };

  programs.fish = {
    shellAliases = {
      cat = "bat";
      rg = "batgrep";
      man = "batman";
    };
    shellAbbrs = {
      "-h" = "-h 2>&1 | bat --language=help --style=plain";
      "--help" = "--help 2>&1 | bat --language=help --style=plain";
    };
    shellInit = ''
      fzf() {
      	command fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
      }
      eval "$(batpipe)"
    '';
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
      rg = "batgrep";
      man = "batman";
    };
    shellGlobalAliases = {
      "-h" = "-h 2>&1 | bat --language=help --style=plain";
      "--help" = "--help 2>&1 | bat --language=help --style=plain";
    };
    initExtra = ''
      fzf() {
      	command fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"
      }
      eval "$(batpipe)"
    '';
  };
}
