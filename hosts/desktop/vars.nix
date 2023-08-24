{
	username = "raphaelw";
	programs = { # these need to be the name of the executables
		editor = "nvim";
		browser = "google-chrome-stable";
		terminal = "alacritty";
		file-explorer = "nautilus";
	};
	display = {
		wayland = true;
		vm = "Hyprland";
		refresh-rate = 165;
		resolution = "3440x1440";
		monitor1 = "DP-3";
		scale = "1";
	};
	theme = {
		gtk-theme = "Gruvbox-Dark-B-LB";
		icon-theme = "Papirus-Dark";
		cursor = {
			theme = "Bibata-Modern-Ice";
			package = "bibata-cursors";
			size = 20;
		};
	};
	fonts = {
		system-font = "JetBrainsMonoNL NF";
	};
}
