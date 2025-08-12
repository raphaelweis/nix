{ lib, ... }:
{
	options.rw = {
		ghostty.enable = lib.mkEnableOption "ghostty configuration.";
	};
	config = {
		programs.ghostty = {
			enable = true;
			settings = {
				theme = "Adwaita Dark";
				background = "#141415";
				font-family = "JetBrainsMonoNL Nerd Font";
				font-size = 14;
				shell-integration-features = "no-cursor";
				cursor-style = "block";
				cursor-style-blink = false;
				gtk-titlebar-hide-when-maximized = true;
				maximize = true;
				gtk-single-instance = true;
				keybind = [
					"ctrl+enter=unbind"
				];
			};
		};
	};
}

