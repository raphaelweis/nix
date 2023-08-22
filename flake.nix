{
	description = "Nix configurations, Raphaël Weis";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";	
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland.url = "github:hyprwm/Hyprland";
	};

	outputs = inputs @ { self, nixpkgs, home-manager, hyprland, ... }:
		let
			user = "raphaelw";
		in
		{
			nixosConfigurations = (
				import ./hosts {
					inherit (nixpkgs) lib;
					inherit nixpkgs user home-manager hyprland;
				}
			);
		};
}
