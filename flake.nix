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
        desktop = let host = "desktop"; in lib.nixosSystem {
          modules = [ ./hosts/nixos/${host}/configuration.nix ];
          specialArgs = { inherit pkgs host inputs; };
        };
      };
      homeConfigurations = {
        "orange" = let host = "orange"; in lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/home-manager/${host}/home.nix ];
          extraSpecialArgs = { inherit pkgs host inputs; };
        };
      };
    };
}
