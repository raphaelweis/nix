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

		mkSystem = name: system: username:
			inputs.nixpkgs.lib.nixosSystem {
				inherit system pkgs;
				specialArgs = { inherit inputs username system; };
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
	};
}

