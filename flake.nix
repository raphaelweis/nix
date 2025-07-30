{
  description = "Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
    let
	system = "x86_64-linux";
	pkgs = import nixpkgs { inherit system; };

	# This derivation safely adds the firmware to the Nix store
	customFirmware = pkgs.stdenv.mkDerivation {
	  name = "custom-firmware";
	  src = ./firmware;
	  installPhase = ''
	    mkdir -p $out/lib/firmware
	    cp $src/TAS2XXX38BB.bin $out/lib/firmware/
	    cp $src/TIAS2781RCA4.bin $out/lib/firmware/
	  '';
	};
    in {
      nixosConfigurations.patpat = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          {
            hardware.firmware = [ customFirmware ];
          }
        ];
      };
    };
}

