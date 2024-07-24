{ config, pkgs, lib, catppuccin, ... }:

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
    catppuccin.homeManagerModules.catppuccin
  ];
  catppuccin = {
    flavor = "frappe";
    enable = true;
  };

  programs = {
    zoxide.enable = true;
    eza.enable = true;
    fd.enable = true;
    bat.enable = true;
    direnv.enable = true;
  };
}
