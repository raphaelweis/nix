{ pkgs, ... }:
let
	vars = import ../../hosts/vars.nix; # TODO: figure out how to import machine specific vars
in
{
	home = {
		sessionVariables = {
			GTK_THEME = "${vars.theme.gtk-theme}";
		};
		pointerCursor = {
			gtk.enable = true;
			package = pkgs.${vars.theme.cursor.package};
			name = "${vars.theme.cursor.theme}";
			size = vars.theme.cursor.size;
		};
	};

	gtk = {
		enable = true;
		theme = {
			name = "${vars.theme.gtk-theme}";
			package = pkgs.gruvbox-gtk-theme;
		};
		iconTheme = {
			name = "${vars.theme.icon-theme}";
			package = pkgs.papirus-icon-theme;
		};
		font = {
			name = "JetBrainsMono NL NF";
		};
	};
}
