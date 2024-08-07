{ pkgs, lib, ... }: {
  programs.fzf = {
    enable = true;
    defaultOptions = [
      # keybindings similar to telescope
      ''--bind="ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up"''
    ];
    defaultCommand = "${pkgs.ripgrep}/bin/rg --files";

    # Command for the CTRL-T file widget
    fileWidgetCommand = "${pkgs.ripgrep}/bin/rg --files";
    fileWidgetOptions = [
      # Preview files with bat
      "--preview '${pkgs.bat}/bin/bat --color=always {}'"
      "--layout default"
    ];

    # Command for the ALT-C directory widget
    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";
    changeDirWidgetOptions =
      [ "--preview '${pkgs.eza}/bin/exa --tree --level=1 --color=always {}'" ];
  };
  programs.zsh = {
    initExtra = ''
      # macos keymaps
      bindkey "ç" fzf-cd-widget # option+c
    '';
  };
}
