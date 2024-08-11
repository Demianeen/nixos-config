{ config, pkgs, lib, catppuccin, ... }:

{
  imports = [
    ./modules/atuin.nix
    ./modules/bat.nix
    ./modules/direnv.nix
    ./modules/editor-config.nix
    ./modules/fzf.nix
    ./modules/gh.nix
    ./modules/git.nix
    ./modules/go.nix
    ./modules/jq.nix
    ./modules/jqp.nix
    ./modules/lazygit.nix
    ./modules/ssh.nix
    ./modules/starship.nix
    ./modules/tealdeer.nix
    ./modules/wezterm.nix
    ./modules/yazi.nix
    ./modules/zsh.nix
  ];

  catppuccin = {
    flavor = "frappe";
    enable = true;
  };

  programs = {
    zoxide.enable = true;
    eza.enable = true;
    fd.enable = true;

    jqp.enable = true;
    jqp.config = { theme.name = "catppuccin-frappe"; };
  };
}
