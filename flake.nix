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
		system = "x86_64-linux";
		pkgs = import inputs.nixpkgs { inherit system; };

		customFirmware = pkgs.stdenv.mkDerivation {
			name = "custom-firmware";
			src = ./firmware;
			installPhase = ''
				mkdir -p $out/lib/firmware
				cp $src/TAS2XXX38BB.bin $out/lib/firmware/
				cp $src/TIAS2781RCA4.bin $out/lib/firmware/
			'';
		};
	in {
		nixosConfigurations.patpat = inputs.nixpkgs.lib.nixosSystem {
			inherit system;
			modules = [
				./configuration.nix
				{
					hardware.firmware = [ customFirmware ];
				}
				inputs.home-manager.nixosModules.home-manager
				{
					home-manager.useGlobalPkgs = true;
					home-manager.useUserPackages = true;
					home-manager.users.raphaelw = ./home.nix;
					home-manager.extraSpecialArgs = { inherit inputs; };
				}
			];
		};
	};
}

