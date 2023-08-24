{ host, ... }:
let
	vars = import ../../../hosts/${host}/vars.nix;
in
{
	services.xremap = {
		serviceMode = "user";
		userName = vars.username;
		withHypr = true;
		config = {
			keymap = [
				# vim style navigation
				{
					name = "Go Left";
					remap = {
						"ALT-h" = "left";
					};
				}
				{
					name = "Go Down";
					remap = {
						"ALT-j" = "down";
					};
				}
				{
					name = "Go Up";
					remap = {
						"ALT-k" = "up";
					};
				}
				{
					name = "Go Right";
					remap = {
						"ALT-l" = "right";
					};
				}
			];
		};
	};
}
