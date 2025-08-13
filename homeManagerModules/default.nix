{ pkgs, lib, inputs, ... }:

{
	imports = [
		inputs.zen-browser.homeModules.twilight
		./devenv.nix
		./nvim.nix
		./sway.nix
		./ghostty.nix
		./tofi.nix
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
			pavucontrol
			chntpw

			# fonts
			dejavu_fonts
			nerd-fonts.jetbrains-mono
			nerd-fonts.fira-code

			# gnome extensions
			gnomeExtensions.hide-top-bar
		];
	};

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			serif = ["DejaVu Serif"];	
			sansSerif = ["DejaVu Sans"];	
			monospace = ["JetBrainsMonoNL Nerd Font"];	
		};
	};

	programs = {
		vscode = {
			enable = true;
			package = pkgs.vscode.fhs;
		};
		alacritty = {
			enable = true;
		};
		nix-index = {
			enable = true;
			enableZshIntegration = true;
		};
		zen-browser.enable = true;
	};

	services = {
		gnome-keyring.enable = true;
	};

	rw = {
		devenv.enable = lib.mkDefault true;
		nvim.enable = lib.mkDefault true;
		sway.enable = lib.mkDefault true;
		ghostty.enable = lib.mkDefault true;
		tofi.enable = lib.mkDefault true;
	};

	home.stateVersion = "25.05";
	programs.home-manager.enable = true;
}

