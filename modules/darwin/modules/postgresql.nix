{ pkgs, ... }:

{
  services = {
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
    };
  };
}
