{ pkgs, ... }:

{
  imports = [
    ./keymap.nix
    ./plugins.nix
    ./settings.nix
  ];

  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    shellWrapperName = "ya";

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;

    initLua = # lua
      ''
        require("git"):setup()
      '';
  };
}
