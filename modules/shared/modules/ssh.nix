{
  programs.ssh = {
    enable = true;
    compression = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    extraConfig = ''
      IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
    # includes = [
    #   (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
    #     "/home/${user}/.ssh/config_external"
    #   )
    #   (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
    #     "/Users/${user}/.ssh/config_external"
    #   )
    # ];
    matchBlocks = {
      "personalgit" = {
        hostname = "github.com";
        identityFile = "Github";
      };
      "workgit" = {
        hostname = "github.com";
        identityFile = "GithubMinimal";
      };
    };
  };
}
