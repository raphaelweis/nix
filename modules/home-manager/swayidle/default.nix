{ pkgs, host, ... }:
let
	vars = import ../../../hosts/desktop/vars.nix;
	systemdTarget = if vars.display.vm == "Hyprland" then "hyprland-session.target" else "graphical-session.target";
	swaylock = "${pkgs.swaylock}/bin/swaylock";
	timeout = 10 * 60;
in
{
	services.swayidle = {
		enable = true;
    	systemdTarget = "${systemdTarget}";
		timeouts = [
			{
				timeout = timeout;
				command = "${swaylock} -f";
			}
		];
	};
}
