{ pkgs, gtk-theme, cursor-theme, cursor-size, ... }:
{
	home = {
		sessionVariables = {
			GTK_THEME = "Gruvbox-Dark-B-LB";
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
			name = "Gruvbox-Dark-B-LB";
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
