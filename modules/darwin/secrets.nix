{
  config,
  pkgs,
  agenix,
  secrets,
  ...
}:

let
  user = "demian";
in
{
  age.identityPaths = [ "/Users/${user}/.ssh/id_ed25519" ];

  # Your secrets go here
  #
  # Note: the installWithSecrets command you ran to boostrap the machine actually copies over
  #       a Github key pair. However, if you want to store the keypair in your nix-secrets repo
  #       instead, you can reference the age files and specify the symlink path here. Then add your
  #       public key in shared/files.nix.
  #
  #       If you change the key name, you'll need to update the SSH configuration in shared/home-manager.nix
  #       so Github reads it correctly.

  age.secrets."gemini-api-key" = {
    symlink = true;
    path = "/Users/${user}/.config/secrets/gemini-api-key";
    file = "${secrets}/gemini-api-key.age";
    mode = "600";
    owner = "${user}";
  };

  age.secrets."groq-api-key" = {
    symlink = true;
    path = "/Users/${user}/.config/secrets/groq-api-key";
    file = "${secrets}/groq-api-key.age";
    mode = "600";
    owner = "${user}";
  };

  age.secrets."fal-api-key" = {
    symlink = true;
    path = "/Users/${user}/.config/secrets/fal-api-key";
    file = "${secrets}/fal-api-key.age";
    mode = "600";
    owner = "${user}";
  };

  #
  # age.secrets."github-ssh-key" = {
  #   symlink = true;
  #   path = "/Users/${user}/.ssh/id_github";
  #   file =  "${secrets}/github-ssh-key.age";
  #   mode = "600";
  #   owner = "${user}";
  #   group = "staff";
  # };

  # age.secrets."github-signing-key" = {
  #   symlink = false;
  #   path = "/Users/${user}/.ssh/pgp_github.key";
  #   file =  "${secrets}/github-signing-key.age";
  #   mode = "600";
  #   owner = "${user}";
  # };
}
