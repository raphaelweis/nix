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
  };

  outputs = { ... }@inputs:
    let
      rUtils = import ./rUtils.nix;
      mkSystem = config:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs rUtils; };
          modules = [ config inputs.self.outputs.nixosModules.default ];
        };
    in {
      nixosConfigurations = {
        desktop = mkSystem ./hosts/desktop/configuration.nix;
      };

      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;
    };
}
