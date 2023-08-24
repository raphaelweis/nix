{ pkgs, home-manager, host, ... }:
let
	vars = import ./vars.nix;
in
{
	imports = [
		(import ../../assets) 
		(import ../../modules/home-manager/alacritty) 
		(import ../../modules/home-manager/chrome)
		(import ../../modules/home-manager/firefox)
		(import ../../modules/home-manager/fzf) 
		(import ../../modules/home-manager/gh) 
		(import ../../modules/home-manager/git) 
		(import ../../modules/home-manager/gtk) 
		(import ../../modules/home-manager/hyprpaper) 
		(import ../../modules/home-manager/starship) 
		(import ../../modules/home-manager/tmux) 
		(import ../../modules/home-manager/zsh) 
		(import ../../modules/home-manager/waybar)
		(import ../../modules/home-manager/swaylock)
		(import ../../modules/home-manager/hyprland)
	];

	home = {
		stateVersion = "22.11";
		packages = with pkgs; [ # desktop specific user packages
			bluetuith
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
