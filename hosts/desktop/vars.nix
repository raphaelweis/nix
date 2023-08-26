{
	username = "raphaelw";
	programs = {
		editor = {
			name = "nvim";
			command = "nvim";
		};
		browser = {
			name = "epiphany";
			command = "epiphany";
		};
		terminal = {
			name = "alacritty";
			command = "alacritty -e tmux";
		};
		file-explorer = {
			name = "nautilus";
			command = "nautilus";
		};
		application-launcher = {
			name = "rofi";
			command = "rofi -show drun";
		};
		program-launcher = {
			name = "rofi";
			command = "rofi -show run";
		};
		screenlocker = {
			name = "swaylock";
			command = "swaylock -f";
		};
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
