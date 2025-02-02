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
    nixgl.url = "github:nix-community/nixGL";
  };

  outputs = {...} @ inputs: let
    vars = rec {
      username = "raphaelw";
      homeDir = "/home/${username}";
      picturesDir = "${homeDir}/Pictures";
      screenshotsDir = "${picturesDir}/Screenshots";
      base16Theme = {
        base00 = "1f2329";
        base01 = "282c34";
        base02 = "30363f";
        base03 = "323641";
        base04 = "565c64";
        base05 = "abb2bf";
        base06 = "b6bdca";
        base07 = "c8ccd4";
        base08 = "e06c75";
        base09 = "d19a66";
        base0A = "e5c07b";
        base0B = "98c379";
        base0C = "56b6c2";
        base0D = "61afef";
        base0E = "c678dd";
        base0F = "be5046";
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
          # inputs.nixvim.homeManagerModules.nixvim
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
