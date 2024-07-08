{
  description = "Raphaël's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim.url = "github:nix-community/nixvim";
    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
  };

  outputs = { ... }@inputs:
    let
      vars = rec {
        username = "raphaelw";
        homeDir = "/home/${username}";
        picturesDir = "${homeDir}/Pictures";
        screenshotsDir = "${picturesDir}/Screenshots";
      };

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      rUtils = import ./rUtils.nix;
      mkSystem = config:
        inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs vars rUtils; };
          modules = [ config inputs.self.outputs.nixosModules.default ];
        };
      mkHome = config:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs vars rUtils; };
          modules = [ config inputs.self.outputs.homeManagerModules.default ];
        };
    in {
      nixosConfigurations = {
        desktop = mkSystem ./hosts/nixos/desktop/configuration.nix;
        laptop = mkSystem ./hosts/nixos/laptop/configuration.nix;
      };
      homeConfigurations = {
        desktop = mkHome ./hosts/home-manager/desktop/home.nix;
        laptop = mkHome ./hosts/home-manager/laptop/home.nix;
      };

      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;
    };
}
