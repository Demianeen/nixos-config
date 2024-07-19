{ config, pkgs, lib, ... }:

let name = "Feliche-Demian Netliukh";
    user = "demian";
    email = "51330172+Demianeen@users.noreply.github.com"; in
{
	zoxide.enable = true;
	eza.enable = true;
	fd.enable = true;
	bat.enable = true;
	direnv.enable = true;

	fzf = {
		enable = true;
	};

  starship = {
    enable = true;
    settings = {
      palette = "catppuccin_frappe";

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

      palettes = {
        catppuccin_macchiato = {
          rosewater = "#f4dbd6";
          flamingo = "#f0c6c6";
          pink = "#f5bde6";
          mauve = "#c6a0f6";
          red = "#ed8796";
          maroon = "#ee99a0";
          peach = "#f5a97f";
          yellow = "#eed49f";
          green = "#a6da95";
          teal = "#8bd5ca";
          sky = "#91d7e3";
          sapphire = "#7dc4e4";
          blue = "#8aadf4";
          lavender = "#b7bdf8";
          text = "#cad3f5";
          subtext1 = "#b8c0e0";
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
          overlay1 = "#8087a2";
          overlay0 = "#6e738d";
          surface2 = "#5b6078";
          surface1 = "#494d64";
          surface0 = "#363a4f";
          base = "#24273a";
          mantle = "#1e2030";
          crust = "#181926";
        };

        catppuccin_frappe = {
          rosewater = "#f2d5cf";
          flamingo = "#eebebe";
          pink = "#f4b8e4";
          mauve = "#ca9ee6";
          red = "#e78284";
          maroon = "#ea999c";
          peach = "#ef9f76";
          yellow = "#e5c890";
          green = "#a6d189";
          teal = "#81c8be";
          sky = "#99d1db";
          sapphire = "#85c1dc";
          blue = "#8caaee";
          lavender = "#babbf1";
          text = "#c6d0f5";
          subtext1 = "#b5bfe2";
          subtext0 = "#a5adce";
          overlay2 = "#949cbb";
          overlay1 = "#838ba7";
          overlay0 = "#737994";
          surface2 = "#626880";
          surface1 = "#51576d";
          surface0 = "#414559";
          base = "#303446";
          mantle = "#292c3c";
          crust = "#232634";
        };

        catppuccin_latte = {
          rosewater = "#dc8a78";
          flamingo = "#dd7878";
          pink = "#ea76cb";
          mauve = "#8839ef";
          red = "#d20f39";
          maroon = "#e64553";
          peach = "#fe640b";
          yellow = "#df8e1d";
          green = "#40a02b";
          teal = "#179299";
          sky = "#04a5e5";
          sapphire = "#209fb5";
          blue = "#1e66f5";
          lavender = "#7287fd";
          text = "#4c4f69";
          subtext1 = "#5c5f77";
          subtext0 = "#6c6f85";
          overlay2 = "#7c7f93";
          overlay1 = "#8c8fa1";
          overlay0 = "#9ca0b0";
          surface2 = "#acb0be";
          surface1 = "#bcc0cc";
          surface0 = "#ccd0da";
          base = "#eff1f5";
          mantle = "#e6e9ef";
          crust = "#dce0e8";
        };

        catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };
  };

  # Shared shell configuration
  zsh = {
    enable = true;
		autocd = false;
		enableCompletion = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
      # {
      #     name = "powerlevel10k";
      #     src = pkgs.zsh-powerlevel10k;
      #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      # }
      # {
      #     name = "powerlevel10k-config";
      #     src = lib.cleanSource ./config;
      #     file = "p10k.zsh";
      # }
    ];

		shellAliases = {
			# zshrc="ce ~/.zshrc";
			# lazyvimjson="ce ~/.config/nvim/lazyvim.json";
			# ohmyzsh="$EDITOR ~/.oh-my-zsh";
			# zsh-plugins="~/.oh-my-zsh/custom/plugins";
			v="nvim -b";
			n="pnpm nx";
			nl="n lint";
			y="pbcopy";
			su="softwareupdate";
			opf="op-fuzzy";
			opfi="op-fuzzy-pbcopy-id";
			ls="ls --color=auto";
			l="eza -1 --long --icons --git";
			lsm="l --sort=modified";
			lgi="l --git-ignore";
			yr="yabai --restart-service";
			ys="yabai_sudoers";
      diff="difft";
			search="rg -p --glob '!node_modules/*'  $@";
		};

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "vim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

	go = {
		enable = true;
		packages = {};
	};

	wezterm = {
		enable = true;
		# extraConfig = builtins.readFile ./wezterm/wezterm.lua;
		extraConfig = ''
local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action

return {
	color_scheme = "Catppuccin Frappe",

	font = wezterm.font_with_fallback({
		{ family = "FiraCode Nerd Font", weight = "Medium" },
		"Noto Emoji",
		"SF Pro",
	}),

	adjust_window_size_when_changing_font_size = false,
	-- line_height = 1.4,
	font_size = 13,

	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,

	cursor_blink_rate = 0,
	default_cursor_style = "SteadyBar",

	-- removes title bar
	window_decorations = "RESIZE",
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_background_opacity = 0.9,
	macos_window_background_blur = 20,

	debug_key_events = false,
	use_ime = true,
	use_dead_keys = false,
	scrollback_lines = 5000,

	window_close_confirmation = "NeverPrompt",

	-- make both left and right alt behave in the same, normal, way
	-- wezfurlong.org/wezterm/config/keyboard-concepts.html?highlight=right%20option#macos-left-and-right-option-key
	send_composed_key_when_left_alt_is_pressed = true,
	send_composed_key_when_right_alt_is_pressed = true,

	cursor_thickness = "50%",
	underline_thickness = "250%",

	keys = {
		{ key = "Enter", mods = "CMD", action = act.ActivateCopyMode },
		{ key = "l", mods = "CMD|SHIFT", action = act.ActivateTabRelative(1) },
		{ key = "h", mods = "CMD|SHIFT", action = act.ActivateTabRelative(-1) },
		{ key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = false }) },
		{ key = "q", mods = "CMD", action = act.QuitApplication },
		{
			key = "Tab",
			mods = "ALT|SHIFT",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
}
		'';
	};

  # alacritty = {
  #   enable = true;
  #   settings = {
  #     cursor = {
  #       style = "Block";
  #     };
  #
  #     window = {
  #       opacity = 1.0;
  #       padding = {
  #         x = 24;
  #         y = 24;
  #       };
  #     };
  #
  #     font = {
  #       normal = {
  #         family = "MesloLGS NF";
  #         style = "Regular";
  #       };
  #       size = lib.mkMerge [
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isLinux 10)
  #         (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin 14)
  #       ];
  #     };
  #
  #     dynamic_padding = true;
  #     decorations = "full";
  #     title = "Terminal";
  #     class = {
  #       instance = "Alacritty";
  #       general = "Alacritty";
  #     };
  #
  #     colors = {
  #       primary = {
  #         background = "0x1f2528";
  #         foreground = "0xc0c5ce";
  #       };
  #
  #       normal = {
  #         black = "0x1f2528";
  #         red = "0xec5f67";
  #         green = "0x99c794";
  #         yellow = "0xfac863";
  #         blue = "0x6699cc";
  #         magenta = "0xc594c5";
  #         cyan = "0x5fb3b3";
  #         white = "0xc0c5ce";
  #       };
  #
  #       bright = {
  #         black = "0x65737e";
  #         red = "0xec5f67";
  #         green = "0x99c794";
  #         yellow = "0xfac863";
  #         blue = "0x6699cc";
  #         magenta = "0xc594c5";
  #         cyan = "0x5fb3b3";
  #         white = "0xd8dee9";
  #       };
  #     };
  #   };
  # };

  ssh = {
    enable = true;
		compression = true;
		addKeysToAgent = "yes";
		forwardAgent = true;
    # includes = [
    #   (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
    #     "/home/${user}/.ssh/config_external"
    #   )
    #   (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
    #     "/Users/${user}/.ssh/config_external"
    #   )
    # ];
		matchBlocks = {
      "kaiku-dev" = {
        hostname = "34.139.95.131";
        user = "demian_kaiku_co";
        identityFile = "dev-machine-key";
      };

			"github.com" = {
        identitiesOnly = true;
				#     identityFile = [
				#       (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
				#         "/home/${user}/.ssh/id_github"
				#       )
				#       (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
				#         "/Users/${user}/.ssh/id_github"
				#       )
				#     ];
			};

      "*" = {
				extraOptions = {
					identityAgent = "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
				};
      };
		};
  };

  # tmux = {
  #   enable = true;
  #   plugins = with pkgs.tmuxPlugins; [
  #     vim-tmux-navigator
  #     sensible
  #     yank
  #     prefix-highlight
  #     {
  #       plugin = power-theme;
  #       extraConfig = ''
  #          set -g @tmux_power_theme 'gold'
  #       '';
  #     }
  #     {
  #       plugin = resurrect; # Used by tmux-continuum
  #
  #       # Use XDG data directory
  #       # https://github.com/tmux-plugins/tmux-resurrect/issues/348
  #       extraConfig = ''
  #         set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
  #         set -g @resurrect-capture-pane-contents 'on'
  #         set -g @resurrect-pane-contents-area 'visible'
  #       '';
  #     }
  #     {
  #       plugin = continuum;
  #       extraConfig = ''
  #         set -g @continuum-restore 'on'
  #         set -g @continuum-save-interval '5' # minutes
  #       '';
  #     }
  #   ];
  #   terminal = "screen-256color";
  #   prefix = "C-x";
  #   escapeTime = 10;
  #   historyLimit = 50000;
  #   extraConfig = ''
  #     # Remove Vim mode delays
  #     set -g focus-events on
  #
  #     # Enable full mouse support
  #     set -g mouse on
  #
  #     # -----------------------------------------------------------------------------
  #     # Key bindings
  #     # -----------------------------------------------------------------------------
  #
  #     # Unbind default keys
  #     unbind C-b
  #     unbind '"'
  #     unbind %
  #
  #     # Split panes, vertical or horizontal
  #     bind-key x split-window -v
  #     bind-key v split-window -h
  #
  #     # Move around panes with vim-like bindings (h,j,k,l)
  #     bind-key -n M-k select-pane -U
  #     bind-key -n M-h select-pane -L
  #     bind-key -n M-j select-pane -D
  #     bind-key -n M-l select-pane -R
  #
  #     # Smart pane switching with awareness of Vim splits.
  #     # This is copy paste from https://github.com/christoomey/vim-tmux-navigator
  #     is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
  #       | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
  #     bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
  #     bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
  #     bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
  #     bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
  #     tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
  #     if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
  #       "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
  #     if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
  #       "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"
  #
  #     bind-key -T copy-mode-vi 'C-h' select-pane -L
  #     bind-key -T copy-mode-vi 'C-j' select-pane -D
  #     bind-key -T copy-mode-vi 'C-k' select-pane -U
  #     bind-key -T copy-mode-vi 'C-l' select-pane -R
  #     bind-key -T copy-mode-vi 'C-\' select-pane -l
  #     '';
  #   };
}
