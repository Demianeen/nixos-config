{ config, pkgs, lib, catppuccin, ... }:

# TODO: difft
{
  imports = [
    ./modules/atuin.nix
    ./modules/editor-config.nix
    ./modules/fzf.nix
    ./modules/gh.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/lazygit.nix
    ./modules/ssh.nix
    ./modules/starship.nix
    ./modules/tealdeer.nix
    ./modules/wezterm.nix
    ./modules/yazi.nix
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
