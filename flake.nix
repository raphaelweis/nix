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
      system = "x86_64-linux"; # for now I only have this type of system.
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.nixgl.overlay ];
      };
    in
    {
      nixosConfigurations = {
        desktop = import ./hosts/desktop { inherit pkgs inputs; };
        laptop = import ./hosts/laptop { inherit pkgs inputs; };
      };
      homeConfigurations = {
        "orange" = import ./hosts/orange { inherit pkgs inputs; };
      };
    };
}
