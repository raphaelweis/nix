{ pkgs, hyprland, ... }:
{
  	nix.settings = { # So we don't need to build hyprland and it's dependencies ourselves.
    	substituters = ["https://hyprland.cachix.org"];
    	trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  	};

    hardware.opengl.enable = true; # this is required
	programs = {
		xwayland.enable = true;
		hyprland = {
			enable = true;
			xwayland.enable = true;
		};
	};

	# Autostart Hyprland on login if on tty1
	environment = {
		loginShellInit = ''
			if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
				exec dbus-launch Hyprland
			fi
		'';      

		variables = {
			XDG_CURRENT_DESKTOP="Hyprland";
			XDG_SESSION_TYPE="wayland";
			XDG_SESSION_DESKTOP="Hyprland";
		};
		sessionVariables = {
			GDK_BACKEND = "wayland";
			WLR_NO_HARDWARE_CURSORS = "1";
			MOZ_ENABLE_WAYLAND = "1";
		};

		systemPackages = with pkgs; [
			grim
			slurp
			wl-clipboard
			wlr-randr
			rofi-wayland
			dunst
			xwayland
			qt6.qtwayland
			libsForQt5.qt5.qtwayland
		];
	};

	xdg.portal = { # Required for flatpak with window managers and for file browsing
		enable = true;
		wlr.enable = true;
		extraPortals = [
			pkgs.xdg-desktop-portal-gtk 
			pkgs.xdg-desktop-portal-wlr 
		];
	};

	security.pam.services.swaylock = {}; # required for swaylock to work
}
