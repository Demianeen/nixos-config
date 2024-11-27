{ pkgs, ... }:
let
  yaziPlugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "master";
    hash = "sha256-UOSH8RM+6VkQqi14bwUdFUNm8CgbDRlNial9VevjYuU=";
  };
  systemClipboard = pkgs.fetchFromGitHub {
    owner = "orhnk";
    repo = "system-clipboard.yazi";
    rev = "master";
    hash = "sha256-tfR9XHvRqm7yPbTu/joBDpu908oceaUoBiIImehMobk=";
  };
  glow = pkgs.fetchFromGitHub {
    owner = "Reledia";
    repo = "glow.yazi";
    rev = "main";
    hash = "sha256-fKJ5ld5xc6HsM/h5j73GABB5i3nmcwWCs+QSdDPA9cU=";
  };
in
{
  programs.yazi.plugins = {
    chmod = "${yaziPlugins}/chmod.yazi";
    smart-filter = "${yaziPlugins}/smart-filter.yazi";
    system-clipboard = systemClipboard;
    glow = glow;
  };
}
