{
  programs.starship = {
    enable = true;
    settings = {
      package.disabled = true;
      nodejs.disabled = true;
      lua.disabled = true;
      gcloud.disabled = true;
      git_status.disabled = true;
      cmd_duration.disabled = true;

      directory = {
        truncation_length = 4;
        style = "bold lavender";
      };
    };
  };
}
