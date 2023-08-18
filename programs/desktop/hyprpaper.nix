{ pkgs, ... }:
let
	wallpaper = "golden-state-bridge.jpg";
in
{
	home = {
		packages = [ pkgs.hyprpaper ];
		file = {
			".config/hypr/hyprpaper.conf" = {
				text = ''
					preload = ~/.local/share/wallpapers/${wallpaper}
					wallpaper = ,~/.local/share/wallpapers/${wallpaper}
					ipc = off
				'';
			};
		};
	};
}
