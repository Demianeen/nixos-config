{ pkgs, config, ... }:

# let
#  githubPublicKey = "ssh-ed25519 AAAA...";
# in
{

  # ".ssh/id_github.pub" = {
  #   text = githubPublicKey;
  # };

  ".config/pgcli/config" = {
    text = builtins.readFile ../shared/config/pgcli/config.ini;
  };
}
