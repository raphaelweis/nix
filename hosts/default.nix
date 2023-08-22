{ nixpkgs, user, home-manager, hyprland, ... }:
let 
	system = "x86_64-linux";
	pkgs = import nixpkgs {
    	inherit system;
    	config.allowUnfree = true;
  	};
	lib = nixpkgs.lib;
in
{
	desktop = lib.nixosSystem { # desktop configuration
		inherit system;
		specialArgs = {
			inherit pkgs user hyprland;
		};
		modules = [
			./configuration.nix
			./desktop
			home-manager.nixosModules.home-manager {
				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = true;
					extraSpecialArgs = {};
					users.${user} = {
						imports = [
							./home.nix
							./desktop/home.nix
						];
					};
				};
			}
		];
	};
}
