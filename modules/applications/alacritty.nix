{ pkgs, ... }:
{
	programs.alacritty = {
		enable = true; 
		settings = {
			colors = {
				primary = {
					background = "0x282828";
					foreground = "0xe5e5e5";
				};
				normal = {
					black = "0x282828";
					red = "0xcc241d";
					green = "0x98971a";
					yellow = "0xd79921";
					blue = "0x458588";
					magenta = "0xb16286";
					cyan = "0x689d6a";
					white = "0xa89984";
				};
				bright = {
					black = "0x928374";
					red = "0xfb4934";
					green = "0xb8bb26";
					yellow = "0xfabd2f";
					blue = "0x83a598";
					magenta = "0xd3869b";
					cyan = "0x8ec07c";
					white = "0xebdbb2";
				};
			};
			cursor = {
				style = {
					blinking = "Off";
					shape = "Block";
				};
			};
			draw_bold_text_with_bright_colors = true;
			font = {
				bold = {
					family = "JetBrainsMonoNL NF";
					style = "Bold";
				};
				bold_italic = {
					family = "JetBrainsMonoNL NF";
					style = "BoldItalic";
				};
				italic = {
					family = "JetBrainsMonoNL NF";
					style = "MediumItalic";
				};
				normal = {
					family = "JetBrainsMonoNL NF";
					style = "Regular";
				};
				size = 14;
			};
			window = {
				opacity = 0.8;
				padding = {
					x = 10;
					y = 10;
				};
			};
			env = {
				WINIT_X11_SCALE_FACTOR = "1";
				TERM = "xterm-256color";
			};
		};
	};
}