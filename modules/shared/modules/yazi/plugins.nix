{ pkgs, ... }:
let
  yaziPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "master";
    hash = "sha256-UOSH8RM+6VkQqi14bwUdFUNm8CgbDRlNial9VevjYuU=";
  };
  systemClipboardPlugin = pkgs.fetchFromGitHub {
    owner = "orhnk";
    repo = "system-clipboard.yazi";
    rev = "master";
    hash = "sha256-tfR9XHvRqm7yPbTu/joBDpu908oceaUoBiIImehMobk=";
  };
in
{
  programs.yazi.plugins = {
    chmod = "${yaziPlugins}/chmod.yazi";
    diff = "${yaziPlugins}/diff.yazi";
    full-border = "${yaziPlugins}/full-border.yazi";
    git = "${yaziPlugins}/git.yazi";
    system-clipboard = systemClipboardPlugin;
  };
}
