{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; };
in shared-packages ++ [
  darwin.trash
  postgresql_15

  # system
  dockutil

  # navigation
  yabai
  skhd

  # ui
  sketchybar
  sketchybar-app-font
  jankyborders

  # password manager
  _1password
]
