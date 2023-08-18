{ pkgs, ... }:
let
	gtk-theme = "Gruvbox-Dark-B-LB";
in
{
	home = {
		sessionVariables = {
			GTK_THEME = "${gtk-theme}";
		};
		pointerCursor = {
			gtk.enable = true;
			name = "Capitaine Cursors (Gruvbox)";
			package = pkgs.capitaine-cursors-themed;
			size = 24;
		};
	};

	gtk = {
		enable = true;
		theme = {
			name = "${gtk-theme}";
			package = pkgs.gruvbox-gtk-theme;
		};
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
		font = {
			name = "JetBrains Mono Medium";
		};
	};
}
