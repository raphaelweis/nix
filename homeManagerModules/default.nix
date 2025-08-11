{ username, config, pkgs, lib, inputs, system, ... }:

{
	imports = [
		inputs.zen-browser.homeModules.twilight
	];

	home = {
		pointerCursor = {
			name = "macOS";
			package = pkgs.apple-cursor;
			size = 24;
		};
		packages = with pkgs; [
			discord
			spotify
			wl-clipboard
			xclip
			ripgrep
			fd
			gcc
			nodejs
			tree-sitter
			playerctl
			brightnessctl
			pavucontrol
			rlwrap
			chntpw
			hyprpicker
			wl-clipboard

			# fonts
			dejavu_fonts

			# gnome extensions
			gnomeExtensions.hide-top-bar
		];
	};

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};

	programs.git = {
		enable = true;
		userEmail = "raphael.weis.g@gmail.com";
		userName = "Raphaël Weis";
		extraConfig.pull.rebase = true;
	};

	programs.gh = {
		enable = true;
		gitCredentialHelper.enable = true;
	};

	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		historySubstringSearch.enable = true;
		enableCompletion = true;
		defaultKeymap = "emacs";
		initContent = lib.mkOrder 500 ''
			autoload -U colors && colors
			PS1="%{$fg[yellow]%}%~%{$fg[red]%} %{$reset_color%}$%b "

			alias ta="tmux attach"
			alias la="ls -la"
			'';
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.tmux = {
		enable = true;
		keyMode = "vi";
		disableConfirmationPrompt = true;
		clock24 = true;
		terminal = "screen-256color";
		newSession = true;
		plugins = with pkgs.tmuxPlugins; [
			vim-tmux-navigator
		];
		extraConfig = ''
			set-option -sg escape-time 10
	      	set-option -g focus-events on
			set-option -g status-position top

			# keybinds
			bind c new-window -c "#{pane_current_path}"
			bind '"' split-window -c "#{pane_current_path}"
			bind % split-window -h -c "#{pane_current_path}"

			# style
			set -g status-position top
			set -g status-justify absolute-centre
			set -g status-style 'fg=color7 bg=default'
			set -g status-right ""
			set -g status-right '#(cd #{pane_current_path} && git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo " $(git rev-parse --abbrev-ref HEAD)")'
			set -g status-left '[#S]'
			set -g status-left-style 'fg=color8'
			set -g status-right-length 0
			set -g status-left-length 100
			setw -g window-status-current-style 'fg=colour6 bg=default bold'
			setw -g window-status-current-format '#I:#W '
			setw -g window-status-style 'fg=color8'
		'';
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		withNodeJs = false;
		withPython3 = false;
		withRuby = false;
		plugins = with pkgs.vimPlugins; [
			{ 
				plugin = nvim-autopairs;
				type = "lua";
				config = ''
					require("nvim-autopairs").setup()
				'';
			}
			{
				plugin = nvim-vague;
				type = "lua";
				config = ''
					require("vague").setup({
						transparent = false
					})
					vim.cmd("colorscheme vague")
				'';
			}
			{
				plugin = telescope-nvim;
				type = "lua";
				config = ''
					local builtin = require("telescope.builtin")
					vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
				'';
			}
			{
				plugin = telescope-fzf-native-nvim;
				type = "lua";
				config = ''
					require('telescope').load_extension('fzf')
				'';
			}
			{
				plugin = nvim-treesitter;
				type = "lua";
				config = ''
					require("nvim-treesitter.configs").setup({
						auto_install = false,
						highlight = {
							enable = true,
						},
					})
				'';
			}
			nvim-treesitter.withAllGrammars
			{
				plugin = vim-fugitive;
				type = "lua";
				config = ''vim.keymap.set("n", "<leader>;", "<CMD>tab Git<CR>", { desc = "Open Fugitive in a new tab" })'';
			}
			vim-tmux-navigator
		];
		extraLuaConfig = ''
			vim.g.mapleader = " " 
			vim.opt.number = true
			vim.opt.relativenumber = true
			vim.opt.tabstop = 4
			vim.opt.shiftwidth = 4
			vim.opt.clipboard:append("unnamedplus")
			vim.opt.swapfile = false
			vim.opt.signcolumn = "yes"

			vim.keymap.set("n", "<ESC>", "<CMD>noh<CR>", { desc = "Remove highlight after search"})
			vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Go up 1 screen line" })
			vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Go down 1 screen line" }) 
		'';
	};

	programs.ghostty = {
		enable = true;
		settings = {
			theme = "Adwaita Dark";
			background = "#141415";
			font-family = "DejaVu Sans Mono";
			font-size = 14;
			shell-integration-features = "no-cursor";
			cursor-style = "block";
			cursor-style-blink = false;
			gtk-titlebar-hide-when-maximized = true;
			maximize = true;
			gtk-single-instance = true;
			keybind = [
				"ctrl+enter=unbind"
			];
		};
	};

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			serif = ["DejaVu Serif"];	
			sansSerif = ["DejaVu Sans"];	
			monospace = ["DejaVu Sans Mono"];	
		};
	};

	programs.vscode = {
		enable = true;
	  	package = pkgs.vscode.fhs;
	};

	wayland.windowManager.sway = {
		enable = true;
		wrapperFeatures.gtk = true;
		config = rec {
			modifier = "Mod4";
			terminal = "ghostty"; 
			gaps.smartBorders = "on";
			defaultWorkspace = "workspace number 1";
			window = {
				border = 1;
				titlebar = false;
			};
			input = {
				"type:keyboard" = {
					xkb_layout = "us(intl)";
				};
				"type:touchpad" = {
					dwt = "enabled";
					tap = "enabled";
					natural_scroll = "enabled";
					scroll_factor = "0.5";
				};
				"type:pointer" = {
					accel_profile = "flat";
					pointer_accel = "0.5";
				};
			};
			startup = [
				{ command = "ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false"; }
			];
			keybindings = let
				modifier = config.wayland.windowManager.sway.config.modifier;
				terminal = config.wayland.windowManager.sway.config.terminal;
				browser = "zen";
				run = "tofi-run | xargs swaymsg exec --";
				drun = "tofi-drun | xargs swaymsg exec --";
			in lib.mkOptionDefault {
				# Window and app controls
				"${modifier}+q" = "exec ${browser}";
				"${modifier}+c" = "kill";
				"${modifier}+Return" = "exec ${terminal}";
				"ALT+TAB" = "workspace back_and_forth";
				"ALT+SPACE" = "exec ${run}";
				"--release Super_L" = "exec ${drun}";
				"${modifier}+Shift+c" = "exec hyprpicker -a";

				# XF86 controls
				"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
				"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
				"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
				"XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
				"XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
				"XF86MonBrightnessUp" = "exec brightnessctl set 10%+";
				"XF86AudioPlay" = "exec playerctl play-pause";
				"XF86AudioNext" = "exec playerctl next";
				"XF86AudioPrev" = "exec playerctl previous";
			};
		};
	};

	programs.tofi = {
		enable = true;
		settings = {
			# Directly providing the path to the font file massively improves startup time.
			font = "${pkgs.dejavu_fonts}/share/fonts/truetype/DejaVuSansMono.ttf";
			width = "100%";
			height = "100%";
			border-width = 0;
			outline-width = 0;
			padding-left = "35%";
			padding-top = "35%";
			result-spacing = "25";
			num-results = "5";
			selection-color = "#ffffff";
			selection-background = "#285577";
			selection-background-padding = "4,10";
			background-color = "#000A";
			text-color = "#888888";
			input-color = "#ffffff";
		};
	};

	services.gnome-keyring.enable = true;

	programs.zen-browser.enable = true;

	home.stateVersion = "25.05";
	programs.home-manager.enable = true;
}

