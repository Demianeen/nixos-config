{
  programs.ssh = {
    enable = true;
    compression = true;
    addKeysToAgent = "yes";
    forwardAgent = true;
    # includes = [
    #   (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
    #     "/home/${user}/.ssh/config_external"
    #   )
    #   (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
    #     "/Users/${user}/.ssh/config_external"
    #   )
    # ];
    matchBlocks = {
      "kaiku-dev" = {
        hostname = "34.139.95.131";
        user = "demian_kaiku_co";
        identityFile = "dev-machine-key";
      };

      "github.com" = {
        identitiesOnly = true;
        #     identityFile = [
        #       (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        #         "/home/${user}/.ssh/id_github"
        #       )
        #       (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        #         "/Users/${user}/.ssh/id_github"
        #       )
        #     ];
      };

      "*" = {
        extraOptions = {
          identityAgent =
            "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
        };
      };
    };
  };
}
