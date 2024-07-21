{ config, pkgs, lib, ... }:

# TODO: nixfmt
# TODO: difft
{
  imports = [
    ./modules/editor-config.nix
    ./modules/fzf.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/ssh.nix
    ./modules/starship.nix
    ./modules/wezterm.nix
    ./modules/zsh.nix
  ];
  programs = {
    zoxide.enable = true;
    eza.enable = true;
    fd.enable = true;
    bat.enable = true;
    direnv.enable = true;
  };
}
