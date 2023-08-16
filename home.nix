{ config, pkgs, ... }:

{
	home.username = "raphaelw";
	home.homeDirectory = "/home/raphaelw";

	home.packages = [];

	home.file = {};

	home.sessionVariables = {
		EDITOR = "nvim";
	};

	programs.home-manager.enable = true;
}
