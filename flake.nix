{
  description = "Nix configurations, Raphaël Weis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    xremap.url = "github:xremap/nix-flake";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib // inputs.home-manager.lib;
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.nixgl.overlay ];
      };
    in
    {
      # On nixos, I prefer to manage my home-manager as a nixos module
      # So the homeConfigurations are exclusively for non-nixos systems
      nixosConfigurations = {
        desktop = let path = ./hosts/nixos/desktop; in
          lib.nixosSystem {
            modules = [ (path + /configuration.nix) ];
            specialArgs = {
              inherit pkgs inputs;
              vars = import (path + /vars.nix);
            };
          };
      };
      homeConfigurations = {
        "orange" = let path = ./hosts/home-manager/orange; in
          lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [ (path + /home.nix) ];
            extraSpecialArgs = {
              inherit pkgs inputs;
              vars = import (path + /vars.nix);
            };
          };
      };
    };
}
