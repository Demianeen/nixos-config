{
  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      os = { editPreset = "nvim-remote"; };
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
        branchLogCmd = "git lg {{branchName}}";
        paging = { externalDiffCommand = "difft"; };
      };
      customCommands = [
        {
          key = "C";
          command = "npm run commit";
          description = "commit with commitizen";
          context = "files";
          loadingText = "opening commitizen commit tool...";
          subprocess = true;
        }
        {
          key = "f";
          context = "localBranches";
          prompts = [
            {
              type = "menu";
              title = "What kind of branch is it?";
              key = "BranchType";
              options = [
                {
                  name = "feature";
                  description = "a feature branch";
                  value = "feature";
                }
                {
                  name = "bugfix";
                  description = "a bugfix branch";
                  value = "bugfix";
                }
                {
                  name = "release";
                  description = "a release branch";
                  value = "release";
                }
                {
                  name = "hotfix";
                  description = "a hotfix branch";
                  value = "hotfix";
                }
              ];
            }
            {
              type = "input";
              title = "What is the new branch name?";
              key = "BranchName";
              initialValue = "";
            }
          ];
          command = "git flow {{.Form.BranchType}} start {{.Form.BranchName}}";
          description = "run gitflow";
          loadingText = "creating branch...";
        }
      ];
    };
  };
}
