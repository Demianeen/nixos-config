{ pkgs, ... }:

let sbar-lua = pkgs.callPackage ./sbar-lua.nix { };
in {
  config = {
    services = {
      sketchybar = {
        enable = true;
        extraPackages = [ pkgs.lua5_4 ];
      };
    };
  };
}
