{
  description = "Nix configurations, Raphaël Weis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    xremap.url = "github:xremap/nix-flake";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, hyprland, xremap, nixvim, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      desktopVars = import ./hosts/desktop/vars.nix;
    in
    {
      nixosConfigurations = {
        desktop = let host = "desktop"; in lib.nixosSystem {
          modules = [
            ./hosts/desktop/configuration.nix
            xremap.nixosModules.default
          ];
          specialArgs = {
            inherit pkgs hyprland host;
          };
        };
      };
      homeConfigurations = {
        "raphaelw@desktop" = let host = "home"; in lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/home/home.nix
            hyprland.homeManagerModules.default
          ];
          extraSpecialArgs = {
            inherit pkgs host hyprland;
          };
        };
      };
    };
}
