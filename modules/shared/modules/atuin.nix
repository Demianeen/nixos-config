{
  programs.atuin = {
    enable = true;
    settings = {
      history_filter = [ "^cd" "^l$" "^z " ];
      filter_mode_shell_up_key_binding = "directory";

      style = "compact";
      enter_accept = true;

      # sync
      auto_sync = true;
      sync_frequency = "30m";
      sync_address = "https://api.atuin.sh";
    };
  };
}
