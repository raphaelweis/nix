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
			inherit (self) outputs;
			lib = nixpkgs.lib // home-manager.lib;
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
			desktopVars = import ./hosts/desktop/vars.nix;
		in
		{
			nixosConfigurations = {
				desktop = lib.nixosSystem {
					modules = [
						./hosts/desktop/configuration.nix
						home-manager.nixosModules.home-manager {
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = true;
							home-manager.extraSpecialArgs = {
								inherit pkgs;
								host = "desktop";
							};
							home-manager.users.${desktopVars.username} = {
								imports = [ ./hosts/desktop/home.nix ];
							};
						}
					];
					specialArgs = { inherit pkgs hyprland; };
				};
			};
		};
}
