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
    astal.url = "github:aylur/astal";
    ags.url = "github:aylur/ags";
    nvim-vague = {
      url = "github:vague2k/vague.nvim";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            android_sdk.accept_license = true;
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

      mkSystem =
        system: pathToConfig: username: isWork:
        nixpkgs.lib.nixosSystem {
          inherit system;
          pkgs = mkPkgs system;
          specialArgs = { inherit inputs username isWork; };
          modules = [
            pathToConfig
            self.outputs.nixosModules.default
            home-manager.nixosModules.home-manager
          ];
        };

      mkHome =
        system: pathToConfig: username: isWork:
        home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs system;
          extraSpecialArgs = { inherit inputs username isWork; };
          modules = [
            pathToConfig
            self.outputs.homeManagerModules.default
          ];
        };
    in
    {
      nixosConfigurations = {
        laptop = mkSystem "x86_64-linux" ./hosts/nixos/laptop/configuration.nix "raphaelw" false;
        desktop = mkSystem "x86_64-linux" ./hosts/nixos/desktop/configuration.nix "raphaelw" false;
      };

      homeConfigurations = {
        work = mkHome "aarch64-darwin" ./hosts/home-manager/work/home.nix "raphael.weis" true;
      };

      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;

      formatter.x86_64-linux = (mkPkgs "x86_64-linux").nixfmt-tree;
      formatter.aarch64-darwin = (mkPkgs "aarch64-darwin").nixfmt-tree;
    };
}
