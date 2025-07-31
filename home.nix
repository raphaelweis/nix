{ config, pkgs, lib, inputs, ... }:

{
	imports = [
		inputs.zen-browser.homeModules.twilight
	];

	home.username = "raphaelw";
	home.homeDirectory = "/home/raphaelw";

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
			PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "
			'';
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

	programs.zen-browser.enable = true;

	# This value determines the Home Manager release that your
	# configuration is compatible with. This helps avoid breakage
	# when a new Home Manager release introduces backwards
	# incompatible changes.
	#
	# You can update Home Manager without changing this value. See
	# the Home Manager release notes for a list of state version
	# changes in each release.
	home.stateVersion = "25.05";

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}

