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
	let
		mkSystem = config:
			inputs.nixpkgs.lib.nixosSystem {
				specialArgs = { inherit inputs; };
				modules = [ config inputs.self.outputs.nixosModules.default ];
			};
	in
	{
		nixosConfigurations = {
			desktop = mkSystem ./hosts/desktop/configuration.nix;
		};

    nixosModules.default = ./nixosModules;
		homeManagerModules.default = ./homeManagerModules;
	};
}
