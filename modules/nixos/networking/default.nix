{ host, ... }:
let
	vars = import ../../../hosts/${host}/vars.nix;
in
{
    networking = {
		hostName = vars.hostname;
		networkmanager.enable = true;
	};
}
