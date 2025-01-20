{
  programs.yazi.settings = {
    log.enabled = true;
    manager = {
      show_hidden = false;
      sort_dir_first = false;
    };
    plugin = {
      prepend_previewers = [
        {
          name = "*.md";
          run = "glow";
        }
      ];
    };
  };
}
