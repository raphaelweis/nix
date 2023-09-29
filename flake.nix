{
  description = "Nix configurations, Raphaël Weis";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    xremap.url = "github:xremap/nix-flake";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { ... }@inputs:
    let
      system = "x86_64-linux"; # for now I only have this type of system.
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ ];
      };
    in
    {
      nixosConfigurations = {
        "desktop" = import ./hosts/desktop { inherit pkgs inputs; };
        "laptop" = import ./hosts/laptop { inherit pkgs inputs; };
        "vm" = import ./hosts/vm { inherit pkgs inputs; };
      };
      homeConfigurations = {
        "orange" = import ./hosts/orange { inherit pkgs inputs; };
      };
    };
}
