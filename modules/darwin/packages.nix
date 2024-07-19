{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
		# system
		dockutil

		# navigation
		yabai
		skhd

		# ui
		sketchybar
		sketchybar-app-font
		jankyborders
]
