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
		nvim-vague = {
			url = "github:vague2k/vague.nvim";
			flake = false;
		};
	};

	outputs = { ... }@inputs: 
	let
		pkgs = import inputs.nixpkgs { 
			system = "x86_64-linux"; 
			config = { allowUnfree = true; };
			overlays = [
				(final: prev: {
					vimPlugins = prev.vimPlugins // {
						nvim-vague = prev.vimUtils.buildVimPlugin {
							name = "nvim-vague";
							src = inputs.nvim-vague;
						};
					};
				})
			];
		};

		username = "raphaelw";

		mkSystem = pathToConfig: system:
			inputs.nixpkgs.lib.nixosSystem {
				inherit system pkgs;
				specialArgs = { inherit inputs username system; };
				modules = [
					pathToConfig
					inputs.self.outputs.nixosModules.default
					inputs.home-manager.nixosModules.home-manager
				];
			};
	in {
		nixosConfigurations = {
			laptop = mkSystem ./hosts/nixos/laptop/configuration.nix "x86_64-linux";
		};
		nixosModules.default = ./nixosModules;
		homeManagerModules.default = ./homeManagerModules;
	};
}

