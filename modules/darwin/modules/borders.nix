{ pkgs, ... }: {
  services.jankyborders = {
    enable = true;
    package = pkgs.jankyborders;
    ax_focus = true;
    style = "round";
    width = 8.0;
    hidpi = true;
    active_color = "0xffabff4f";
    inactive_color = "0x00ffffff";
  };
}
