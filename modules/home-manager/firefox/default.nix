{ pkgs, ... }:
{
	home = {
		packages = with pkgs; [ firefox-beta ];
		sessionVariables = {
			MOZ_ENABLE_WAYLAND = 1;
		};	
	};
}
