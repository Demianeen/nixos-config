{ pkgs, lib, ... }:
let
  name = "Feliche-Demian Netliukh";
  user = "demian";
  email = "51330172+Demianeen@users.noreply.github.com";
in {
  programs.git = {
    enable = true;
    userName = name;
    userEmail = email;

    aliases = {
      co = "checkout";
      lg =
        "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative --oneline --color";
    };
    ignores = [ "*.swp" ".DS_Store" ".direnv/" ];

    difftastic = { enable = true; };
    extraConfig = {
      init.defaultBranch = "main";
      core = { autocrlf = "input"; };
      pull.rebase = true;
      rebase.autoStash = true;

      # merging
      merge = { tool = "nvim"; };
      mergetool = {
        prompt = false;
        nvim = { cmd = ''nvim +"DiffviewOpen $branches" +tabonly''; };
      };

      # commit signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program = if pkgs.stdenv.isDarwin then
        "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
      else
        "${lib.getExe pkgs._1password-gui "op-ssh-sign"}";
      user.signingKey =
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMZoqTjeGfPX1oif9+1UCmI+QGWVHq2kJBlEBWtlSGXn";
    };
  };
}
