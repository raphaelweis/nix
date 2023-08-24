{
	description = "Nix configurations, Raphaël Weis";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";	
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland.url = "github:hyprwm/Hyprland";
		xremap.url = "github:xremap/nix-flake";
	};

	outputs = inputs @ { self, nixpkgs, home-manager, hyprland, xremap, ... }:
		let
			inherit (self) outputs;
			lib = nixpkgs.lib;
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
			desktopVars = import ./hosts/desktop/vars.nix;
		in
		{
			nixosConfigurations = {
				desktop = let host = "desktop"; in lib.nixosSystem {
					modules = [
						./hosts/desktop/configuration.nix
						home-manager.nixosModules.home-manager {
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.extraSpecialArgs = {
								inherit pkgs host;
							};
							home-manager.users.${desktopVars.username} = {
								imports = [ ./hosts/desktop/home.nix ];
							};
						}
						xremap.nixosModules.default
					];
					specialArgs = {
						inherit pkgs hyprland host;
					};
				};
			};
		};
}
