{ pkgs, user, ... }:
{
	imports = 
		(import ../assets) ++
		(import ../modules/cli) ++
		(import ../modules/applications) ++
		(import ../modules/desktop);

	home = {
		stateVersion = "22.11";
		packages = with pkgs; [
			alacritty
			tmux
			firefox
			starship
			neovim
			rofi
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
