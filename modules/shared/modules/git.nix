let
  name = "Feliche-Demian Netliukh";
  user = "demian";
  email = "51330172+Demianeen@users.noreply.github.com";
in {
  programs.git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = { enable = true; };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
      # commit signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".program =
        "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
    };
  };
}
