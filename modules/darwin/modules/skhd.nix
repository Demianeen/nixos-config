{ pkgs, ... }:

{
  config = {
    services = {
      skhd = {
        enable = true;
        package = pkgs.skhd;
        skhdConfig = ''
          ## Window focus
          # moving between windows focus within a space
          lalt - j : yabai -m window --focus south
          lalt - k : yabai -m window --focus north
          lalt - h : yabai -m window --focus west
          lalt - l : yabai -m window --focus east

          # moving between displays
          ralt - a : yabai -m display --focus west
          ralt - s : yabai -m display --focus east

          ## Layout
          # rotate layout clockwise
          ralt - r : yabai -m space --rotate 270

          # flip along x and y axis
          alt - y : yabai -m space --mirror y-axis
          ralt - x : yabai -m space --mirror x-axis

          # toggle window float
          ralt - t: yabai -m window --toggle float --grid 8:8:1:1:6:6; sketchybar --trigger window_focus

          ## Window Size
          # maximize window
          ralt - m : yabai -m window --toggle zoom-fullscreen; sketchybar --trigger window_focus
          lalt - p : yabai -m window --toggle zoom-parent; sketchybar --trigger window_focus

          # balance out tree of windows (resize to occupy the same area)
          ralt - e : yabai -m space --balance

          ## Window Navigation
          # swap windows
          shift + alt - j : yabai -m window --swap south
          shift + alt - k : yabai -m window --swap north
          shift + alt - h : yabai -m window --swap west
          shift + alt - l : yabai -m window --swap east

          # move windows and split
          ctrl + alt - j : yabai -m window --warp south
          ctrl + alt - k : yabai -m window --warp north
          ctrl + alt - h : yabai -m window --warp west
          ctrl + alt - l : yabai -m window --warp east

          # move window to display left and right
          shift + ralt - a : yabai -m window --display west; yabai -m display --focus west
          shift + ralt - s : yabai -m window --display east; yabai -m display --focus east

          # move to prev/next space
          shift + ralt - p : yabai -m window --space prev
          shift + ralt - n : yabai -m window --space next

          # focusing on desktops
          alt - 0 : yabai -m space --focus recent

          # alt - left : yabai -m space --focus prev
          # alt - right : yabai -m space --focus next

          ralt - 1 : yabai -m space --focus 1
          ralt - 2 : yabai -m space --focus 2
          ralt - 3 : yabai -m space --focus 3
          ralt - 4 : yabai -m space --focus 4
          ralt - 5 : yabai -m space --focus 5
          lalt - 6 : yabai -m space --focus 6
          lalt - 7 : yabai -m space --focus 7
          lalt - 8 : yabai -m space --focus 8
          lalt - 9 : yabai -m space --focus 9

          # move window to space
          shift + ralt - 1 : yabai -m window --space 1
          shift + ralt - 2 : yabai -m window --space 2
          shift + ralt - 3 : yabai -m window --space 3
          shift + ralt - 4 : yabai -m window --space 4
          shift + ralt - 5 : yabai -m window --space 5
          shift + lalt - 6 : yabai -m window --space 6
          shift + lalt - 7 : yabai -m window --space 7
          shift + lalt - 8 : yabai -m window --space 8
          shift + lalt - 9 : yabai -m window --space 9

          # resizing windows
          alt + fn - l : ~/.config/yabai/scripts/resizeWindow.sh -l
          alt + fn - h : ~/.config/yabai/scripts/resizeWindow.sh -h
          alt + fn - j : ~/.config/yabai/scripts/resizeWindow.sh -d
          alt + fn - k : ~/.config/yabai/scripts/resizeWindow.sh -u

          ## Start/Stop yabai
          fn + ralt -q : yabai --stop-service
          fn + ralt -s : yabai --start-service
          fn + ralt -r : yabai --restart-service

          cmd + ralt - e : yabai -m window --resize left:320:0

          ralt - q : ~/.bin/exit_fullscreen

          # -- Window stacking ---------------------------------------------------------------------------------------------------

          lalt + shift - left	: yabai -m window  west --stack $(yabai -m query --windows --window | jq -r '.id') && sketchybar --trigger window_focus
          lalt + shift - down	: yabai -m window south --stack $(yabai -m query --windows --window | jq -r '.id') && sketchybar --trigger window_focus
          lalt + shift - up	: yabai -m window north --stack $(yabai -m query --windows --window | jq -r '.id') && sketchybar --trigger window_focus
          lalt + shift - right	: yabai -m window east --stack $(yabai -m query --windows --window | jq -r '.id') && sketchybar --trigger window_focus
          lalt + shift - 0x21	: yabai -m window --focus stack.prev
          lalt + shift - 0x1E	: yabai -m window --focus stack.next
        '';
      };
    };

    system = { keyboard = { enableKeyMapping = true; }; };
  };
}
