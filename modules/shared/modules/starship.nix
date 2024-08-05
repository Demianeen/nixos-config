{ lib, ... }: {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = lib.concatStrings [
        "$directory"
        "\${custom.git_server_icon}"
        "\${custom.nix_shell}"
        "$character"
      ];

      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };

      custom = {
        git_server_icon = {
          description =
            "Show a GitLab or GitHub icon depending on current git remote";
          when = "git rev-parse --is-inside-work-tree 2> /dev/null";
          command = ''
            GIT_REMOTE=$(git ls-remote --get-url 2> /dev/null); if [[ "$GIT_REMOTE" =~ "github" ]]; then printf ""; elif [[ "$GIT_REMOTE" =~ "gitlab" ]]; then echo ""; else echo "󰊢"; fi'';
          shell = [ "bash" "--noprofile" "--norc" ];
          style = "bold #f74e27"; # git brand color
          format = "[$output]($style)";
        };
        nix_shell = {
          description = "Show an indicator when inside a Nix ephemeral shell";
          when = ''[ "$IN_NIX_SHELL" != "" ]'';
          shell = [ "bash" "--noprofile" "--norc" ];
          style = "bold #6ec2e8";
          format = "[ ]($style)";
        };
      };
    };
  };
}
