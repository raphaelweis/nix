{
  description = "Raphaël's NixOS configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
    nixgl.url = "github:nix-community/nixGL";
    nixvim.url = "github:nix-community/nixvim";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { ... }@inputs:
    let
      vars = rec {
        username = "raphaelw";
        homeDir = "/home/${username}";
        picturesDir = "${homeDir}/Pictures";
        screenshotsDir = "${picturesDir}/Screenshots";
        base16Theme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      };

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [ inputs.nixgl.overlay ];
        config.allowUnfree = true;
      };

      rUtils = import ./rUtils.nix;
      mkSystem =
        config:
        inputs.nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit inputs vars rUtils; };
          modules = [
            config
            inputs.self.outputs.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
          ];
        };
      mkHome =
        config:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs vars rUtils; };
          modules = [
            config
            inputs.self.outputs.homeManagerModules.default
            inputs.stylix.homeManagerModules.stylix
            inputs.nixvim.homeManagerModules.nixvim
            inputs.ags.homeManagerModules.default
          ];
        };
    in
    {
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
