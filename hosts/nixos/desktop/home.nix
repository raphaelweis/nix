{ ... }:
let 
	username = "raphaelw";
in {
	home = {
		username = username;
		homeDirectory = "/home/${username}";
	};
}

