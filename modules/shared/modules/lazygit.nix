{
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      os = {
        # https://github.com/jesseduffield/lazygit/issues/3064
        openLink = ''open "$(echo {{link}} | sed 's/%2F/\//g')"'';
        # https://github.com/FelipeSharkao/Settings/blob/2786656e249c737edb2bd1f8596cddf6153a2405/Lazygit/config.yml
        edit = "nvr --remote-tab-wait +'setl bufhidden=wipe' {{filename}}";
        editAtLine = "nvr --remote-tab-wait +'setl bufhidden=wipe | {{line}}' {{filename}}";
        editAtLineAndWait = "nvr --remote-tab-wait +'setl bufhidden=wipe | {{line}}' {{filename}}";
        openDirInEditor = "nvr --remote-tab-wait +'setl bufhidden=wipe' {{dir}}";
      };
      gui = {
        filterMode = "fuzzy";
        nerdFontsVersion = "3";
        border = "rounded";
        expandFocusedSidePanel = true;
        showBottomLine = false;
        commandLogSize = 3;
        showCommandLog = false;
      };
      git = {
        autoForwardBranches = "allBranches";
        overrideGpg = true; # overrides lazygit gpg restrictions
        branchLogCmd = "git lg {{branchName}}";
        paging = {
          externalDiffCommand = "difft";
        };
      };
      customCommands = [
        {
          key = "C";
          command = "npm run commit";
          description = "commit with commitizen";
          context = "files";
          loadingText = "opening commitizen commit tool...";
          output = "terminal";
        }
      ];
    };
  };
}
