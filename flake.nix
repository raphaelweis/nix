{
	description = "Flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		zen-browser = {
			url = "github:0xc000022070/zen-browser-flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { ... }@inputs: 
	let
		pkgs = import inputs.nixpkgs { 
			system = "x86_64-linux"; 
			config = { allowUnfree = true; };
		};

		username = "raphaelw";

		mkSystem = name: system: username:
			inputs.nixpkgs.lib.nixosSystem {
				inherit system;
				specialArgs = { inherit inputs username; };
				modules = [
					./hosts/generic.nix
					./hosts/${name}/configuration.nix
					inputs.home-manager.nixosModules.home-manager
				];
			};
	in {
		nixosConfigurations = {
			patpat = mkSystem "patpat" "x86_64-linux" "raphaelw";
		};
		# nixosConfigurations.patpat = inputs.nixpkgs.lib.nixosSystem {
		# 	system = "x86_64-linux";
		# 	modules = [
		# 		./configuration.nix
		# 		{
		# 			hardware.firmware = [ customFirmware ];
		# 		}
		# 		inputs.home-manager.nixosModules.home-manager
		# 		{
		# 			home-manager.useGlobalPkgs = true;
		# 			home-manager.useUserPackages = true;
		# 			home-manager.users.raphaelw = ./home.nix;
		# 			home-manager.extraSpecialArgs = { inherit inputs; };
		# 		}
		# 	];
		# };
	};
}

