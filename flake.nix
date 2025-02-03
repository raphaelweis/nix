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
  };

  outputs = {...} @ inputs: let
    vars = rec {
      username = "raphaelw";
      homeDir = "/home/${username}";
      picturesDir = "${homeDir}/Pictures";
      screenshotsDir = "${picturesDir}/Screenshots";
      base16Theme = {
        base00 = "010409";
        base01 = "0d1117";
        base02 = "151b23";
        base03 = "212830";
        base04 = "3d444d";
        base05 = "656c76";
        base06 = "9198a1";
        base07 = "f0f6fc";
        base08 = "ffa198";
        base09 = "79c0ff";
        base0A = "e3b341";
        base0B = "56d364";
        base0C = "ffa657";
        base0D = "e2c5ff";
        base0E = "ffbedd";
        base0F = "ffc2b2";
      };
    };

    pkgs = import inputs.nixpkgs {
      system = "x86_64-linux";
      overlays = [inputs.nixgl.overlay];
      config.allowUnfree = true;
    };

    rUtils = import ./rUtils.nix;
    mkSystem = config:
      inputs.nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {inherit inputs vars rUtils;};
        modules = [
          config
          inputs.self.outputs.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
        ];
      };
    mkHome = config:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs vars rUtils;};
        modules = [
          config
          inputs.self.outputs.homeManagerModules.default
          inputs.stylix.homeManagerModules.stylix
          inputs.ags.homeManagerModules.default
        ];
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
