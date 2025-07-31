{ username, config, pkgs, lib, inputs, ... }:

{
	imports = [
		inputs.zen-browser.homeModules.twilight
	];

	home = {
		username = username;
		homeDirectory = "/home/${username}";
		packages = [
			pkgs.discord
			pkgs.spotify

			# fonts
			pkgs.dejavu_fonts

			# gnome extensions
			pkgs.gnomeExtensions.hide-top-bar
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
			'';
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.neovim = {
		enable = true;
		defaultEditor = true;
		vimAlias = true;
		withNodeJs = false;
		withPython3 = false;
		withRuby = false;
		extraLuaConfig = ''
			vim.opt.number = true
			vim.opt.relativenumber = true
			vim.opt.tabstop = 4
			vim.opt.shiftwidth = 4
			vim.opt.clipboard:append("unnamedplus")
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

	programs.zen-browser.enable = true;

	home.stateVersion = "25.05";
	programs.home-manager.enable = true;
}

