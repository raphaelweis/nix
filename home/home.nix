{ username, config, pkgs, lib, inputs, system, ... }:

{
	imports = [
		inputs.zen-browser.homeModules.twilight
	];

	home = {
		username = username;
		homeDirectory = "/home/${username}";
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

			# fonts
			dejavu_fonts

			# gnome extensions
			gnomeExtensions.hide-top-bar
		];
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
		extraConfig = ''
			set-option -sg escape-time 10
	      	set-option -g focus-events on
			set-option -g status-position top

			# style
			set -g status-position top
			set -g status-justify absolute-centre
			set -g status-style 'fg=color7 bg=default'
			set -g status-right ""
			set -g status-right '#(cd #{pane_current_path} && git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo " $(git rev-parse --abbrev-ref HEAD)") %H:%M'
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
						transparent = true
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
			background = "#1C1C1F";
			font-family = "DejaVu Sans Mono";
			font-size = 14;
			shell-integration-features = "no-cursor";
			cursor-style = "block";
			cursor-style-blink = "false";
			gtk-titlebar-hide-when-maximized = "true";
			maximize = true;
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
		wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps
			config = rec {
				modifier = "Mod4";
				terminal = "ghostty"; 
				keybindings = let
					modifier = config.wayland.windowManager.sway.config.modifier;
				in lib.mkOptionDefault {
					"${modifier}+Q" = "exec zen";
					"${modifier}+c" = "kill";
					"${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
				};
			};
	};

	services.gnome-keyring.enable = true;

	programs.zen-browser.enable = true;

	home.stateVersion = "25.05";
	programs.home-manager.enable = true;
}

