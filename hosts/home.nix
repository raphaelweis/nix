{ pkgs, user, ... }:
let
	# TODO: Figure out how to pass in these damn variables to the other files
	gtk-theme = "Gruvbox-Dark-B-LB";
	cursor-theme = "Capitaine Cursors (Gruvbox)";
	cursor-size = 24;
in
{
	imports = 
		(import ../programs/shell) ++
		(import ../assets) ++
		(import ../programs/desktop);

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
			wl-clipboard
			cliphist
			hyprpaper
			bluetuith
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
