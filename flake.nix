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

  outputs =
    { ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        system = system;
        config = {
          allowUnfree = true;
        };
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

      mkSystem =
        pathToConfig:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          specialArgs = { inherit inputs username system; };
          modules = [
            pathToConfig
            inputs.self.outputs.nixosModules.default
            inputs.home-manager.nixosModules.home-manager
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem ./hosts/nixos/laptop/configuration.nix;
        desktop = mkSystem ./hosts/nixos/desktop/configuration.nix;
      };
      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;

      formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree;
    };
}
