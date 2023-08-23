{ pkgs, ... }:
{
	home = {
		packages = with pkgs; [ firefox-wayland ];
		sessionVariables = {
			MOZ_ENABLE_WAYLAND = 1;
		};	
	};
}
