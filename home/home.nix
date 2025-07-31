{ username, config, pkgs, lib, inputs, ... }:

{
	imports = [
		inputs.zen-browser.homeModules.twilight
	];

	home.username = username;
	home.homeDirectory = "/home/${username}";

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

	home.stateVersion = "25.05";
	programs.home-manager.enable = true;
}

