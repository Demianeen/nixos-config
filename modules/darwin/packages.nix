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

  # sketchybar
  sketchybar
  sketchybar-app-font
  yabai
  skhd

  # nvim
  pngpaste # img-clip.nvim

  # password manager
  # _1password
]
