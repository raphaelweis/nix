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

  outputs = { nixpkgs, home-manager, hyprland, xremap, nixvim, ... }@inputs:
    let
      lib = nixpkgs.lib // home-manager.lib;
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        desktop = let host = "desktop"; in lib.nixosSystem {
          inherit pkgs;
          modules = [ ./hosts/desktop/configuration.nix ];
          specialArgs = { inherit host inputs; };
        };
      };
      homeConfigurations = {
        "hyprland" = let host = "hyprland"; in lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/home/${host}/home.nix ];
          extraSpecialArgs = { inherit pkgs host inputs; };
        };
        "minimal" = let host = "minimal"; in lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/home/${host}/home.nix ];
          extraSpecialArgs = { inherit pkgs host inputs; };
        };
      };
    };
}
