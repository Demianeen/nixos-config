{ pkgs, ... }:
let
  ghostty-mock = pkgs.writeShellScriptBin "ghostty-mock" ''
    true
  '';
in
{
  programs.ghostty = {
    enable = true;
    package = ghostty-mock;
    installBatSyntax = false;
    settings = {
      theme = "catppuccin-frappe";
      font-family = "FiraCode Nerd Font";
      font-size = 13;
      font-style = "Medium";
      adjust-cell-height = 5;
      macos-titlebar-style = "hidden";
      mouse-hide-while-typing = true;
      quit-after-last-window-closed = true;
      window-padding-x = "0,0";
      window-padding-y = "0,0";
    };
  };
}
