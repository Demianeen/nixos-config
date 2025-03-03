{ pkgs, ... }:

let
  sbar-lua = pkgs.callPackage ./sbar-lua.nix { };
in
{
  config = {
    services = {
      sketchybar = {
        enable = false;
        extraPackages = [ pkgs.lua5_4 ];
      };
    };
    launchd.user.agents.sketchybar.serviceConfig = {
      StandardOutPath = "/tmp/sketchybar-logs/sketchybar.stdout.log";
      StandardErrorPath = "/tmp/sketchybar-logs/sketchybar.stderr.log";
    };
  };
}
