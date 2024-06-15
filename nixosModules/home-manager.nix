{ lib, config, inputs, outputs, pkgs, ... }: {
	options = {
		username = lib.mkOption {
			default = "raphaelw";
			description = "Username";
		};
		hmConfig = lib.mkOption {
			description = "Home manager config path";
			type = lib.types.path;
		};
	};

	config = {
		home-manager = {
			useUserPackages = true;
			useGlobalPkgs = true;
			extraSpecialArgs = { inherit inputs; };
			users = {
				"raphaelw" = {
					imports = [
						(import config.hmConfig)
						inputs.self.outputs.homeManagerModules.default
					];
				};
			};
		};
	};
}
