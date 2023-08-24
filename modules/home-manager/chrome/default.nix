{ pkgs, host, ... }:
{
	home.packages = with pkgs; [ google-chrome ];
	# More configuration if needed
	# ...
}
