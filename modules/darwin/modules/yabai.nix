{ pkgs, ... }:

{
  config = {
    services = {
      yabai = {
        enable = true;
        package = pkgs.yabai;
        config = {
          layout = "bsp";
          auto_balance = "on";
          external_bar = "all:0:40";
          debug_output = "off";
          mouse_follows_focus = "on";
          focus_follows_mouse = "off";
          window_zoom_persist = "off";
          window_shadow = "off";
          window_opacity = "on";
          window_opacity_duration = 0.15;
          active_window_opacity = 1.0;
          normal_window_opacity = 0.95;
          insert_feedback_color = "0x00ffffff";
          split_ratio = 0.5;
          mouse_modifier = "fn";
          mouse_action1 = "move";
          mouse_action2 = "resize";
          mouse_drop_action = "swap";
          top_padding = 4;
          bottom_padding = 4;
          left_padding = 4;
          right_padding = 4;
          window_gap = 8;
        };
        extraConfig = # bash
          ''
            yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
            yabai -m signal --add event=window_focused action="sketchybar --trigger window_focus"
            yabai -m signal --add event=window_created action="sketchybar --trigger windows_on_spaces"
            yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"

            # -- Space preparing ---------------------------------------------------------------------------------------------------

            function space_destroy_amount {
            	for idx in $(yabai -m query --spaces | jq ".[].index | select(. > $1)" | sort -nr); do
            		yabai -m space --destroy "$idx"
            	done
            }

            function space_create {
            	local display=$(display_index_get $1)
            	local idx=$2
            	local name=$3
            	local space=$(yabai -m query --spaces | jq "first(.[] | select(.index == $idx) | .index)")

            	if [ -z "$space" ]; then
            		yabai -m space --create
            	fi

            	yabai -m space "$idx" --label "$name" --display "$display"
            }

            space_destroy_amount 10

            space_create 1 1 term
            space_create 1 2 social
            space_create 1 3 tasks
            space_create 1 4 design
            space_create 1 5 documents
            space_create 1 6 notes
            space_create 1 7 japanese
            space_create 1 8 email
            space_create 2 9 browser

            yabai -m rule --add space=term app="^(WezTerm|VSCode|Simulator)$"
            yabai -m rule --add space=browser app="^(Arc)$"
            yabai -m rule --add space=social app="^(Telegram|Toggl Track)$"
            yabai -m rule --add space=tasks app="^(Things|Notion Calendar|Rise|Amie)$"
            yabai -m rule --add space=design app="^(Figma|Miro)$"
            yabai -m rule --add space=documents app="^(Microsoft Word|Microsoft Excel|Microsoft PowerPoint|Acrobat)$"
            yabai -m rule --add space=japanese app="^(Obsidian)$"
            # yabai -m rule --add space=calls app="^(zoom.us|Teams)$"
            yabai -m rule --add space=japanese app="^(Anki)$"
            yabai -m rule --add space=email app="^(Mail|Microsoft Outlook)$"

            # resizes simulators on yabai restart
            ~/.config/yabai/scripts/allSimulatorsToDefaultSize.sh

            # disable specific apps
            yabai -m rule --add app="^Pika$" manage=off
            yabai -m rule --add app="^Calculator$" manage=off
            yabai -m rule --add app="^Karabiner-Elements$" manage=off
            yabai -m rule --add app="^1Password$" manage=off
            yabai -m rule --add app="^Spotify$" manage=off
            yabai -m rule --add app="^Bartender 5$" manage=off
            yabai -m rule --add app="^Finder$" manage=off
            yabai -m rule --add app="^Hazel$" manage=off
            yabai -m rule --add app="^CleanMyMac X$" manage=off
            yabai -m rule --add app="^Outlook$" manage=off
            yabai -m rule --add app="^Simulator$" manage=on
            yabai -m rule --add app="CleanShot X" manage=off mouse_follows_focus=off

            yabai -m signal --add app='^Ghostty$' event=window_created action='yabai -m space --layout bsp'
            yabai -m signal --add app='^Ghostty$' event=window_destroyed action='yabai -m space --layout bsp'

            # apply all yabai rules on yabai start to all apps
            yabai -m rule --apply
          '';
      };
    };
  };
}
