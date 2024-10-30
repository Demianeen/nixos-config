{ lib, ... }:
{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = lib.strings.stringToCharacters "cF";
        run = "plugin system-clipboard";
        desc = "Copy file";
      }
      {
        on = lib.strings.stringToCharacters "Cm";
        run = "plugin chmod";
        desc = "Chmod selected files";
      }
      {
        on = lib.strings.stringToCharacters "F";
        run = "plugin smart-filter";
        desc = "Smart filter";
      }
    ];
  };
}
