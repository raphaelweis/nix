{ pkgs, user, ... }:
{
	imports = [
		(import ../assets) 
		(import ../modules/alacritty) 
		(import ../modules/firefox)
		(import ../modules/fzf) 
		(import ../modules/gh) 
		(import ../modules/git) 
		(import ../modules/gtk) 
		(import ../modules/hyprpaper) 
		(import ../modules/starship) 
		(import ../modules/tmux) 
		(import ../modules/zsh) 
	 	(import ../modules/hyprland/home.nix)
	];


	home = {
		stateVersion = "22.11";
		packages = with pkgs; [
			alacritty
			tmux
			starship
			neovim
			lsd
			cliphist
			hyprpaper
			pavucontrol
			vscode
			networkmanagerapplet
			acpi
			gnome.nautilus
			gnome.gnome-themes-extra
			gtk-engine-murrine
			gruvbox-dark-icons-gtk
		];
	};
	programs = {
		home-manager.enable = true;
	};
}
