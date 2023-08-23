{ pkgs, ... }:
{
	programs.swaylock = {
		enable = true;
		package = pkgs.swaylock-effects;
		settings = {
			color = "000000f0";
		};
	};
}
