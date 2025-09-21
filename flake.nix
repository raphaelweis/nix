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
    prisma-language-server = {
      url = "github:prisma/language-tools";
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
          (final: prev: {
            prisma-language-server = prev.buildNpmPackage (finalAttrs: {
              pname = "prisma-language-server";
              version = "6.16.2";

              src = pkgs.fetchFromGitHub {
                owner = "prisma";
                repo = "language-tools";
                tag = "${finalAttrs.version}";
                hash = "sha256-UZP0pLcbMeaYI0ytOJ68l/ZEC9dBhohJZyTU99p+1QM=";
              };

              sourceRoot = "${finalAttrs.src.name}/packages/language-server";

              nativeBuildInputs = [ pkgs.pkg-config ];
              buildInputs = [ pkgs.libsecret ];

              npmDepsHash = "sha256-UAGz/qCYf+jsgCWqvR52mW6Ze3WWP9EHuE4k9wCbnH0=";

              npmPackFlags = [ "--ignore-scripts" ];

              NODE_OPTIONS = "--openssl-legacy-provider";

              meta = {
                description = "Language server for Prisma";
                homepage = "https://github.com/prisma/language-tools";
                license = inputs.nixpkgs.lib.licenses.asl20;
                mainProgram = "prisma-language-server";
              };
            });
          })
        ];
      };

      mkSystem =
        pathToConfig: username:
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
        laptop = mkSystem ./hosts/nixos/laptop/configuration.nix "raphaelw";
        desktop = mkSystem ./hosts/nixos/desktop/configuration.nix "raphaelw";
      };
      nixosModules.default = ./nixosModules;
      homeManagerModules.default = ./homeManagerModules;

      formatter.${system} = inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree;
    };
}
