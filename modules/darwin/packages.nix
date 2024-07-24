{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; };
in shared-packages ++ [
  darwin.trash

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
  _1password-gui
]
