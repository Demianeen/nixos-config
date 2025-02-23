{ pkgs }:

with pkgs;
let
  shared-packages = import ../shared/packages.nix { inherit pkgs; };
in
shared-packages
++ [
  darwin.trash

  # system
  dockutil

  # ui
  sketchybar
  sketchybar-app-font

  # password manager
  # _1password
]
