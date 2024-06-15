{
	description = "Raphaël's NixOS configurations";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, ... }@inputs:
	{
		nixosConfigurations = {
			desktop = nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [
					./hosts/desktop/configuration.nix
					./nixosModules
				];
			};
		};
		homeManagerModules.default = ./homeManagerModules;
	};
}
