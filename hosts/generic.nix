{ inputs, pkgs, username, ... }:
{

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		users.${username} = ../home/home.nix;
		extraSpecialArgs = { inherit inputs pkgs username; };
	};

	networking = {
		hostName = "patpat";
		networkmanager.enable = true;
	};

	time.timeZone = "Europe/Paris";

	i18n.defaultLocale = "en_US.UTF-8";

	services = {
		xserver.enable = true;
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		gvfs.enable = true;
		gnome = {
			core-apps.enable = true;
			gnome-online-accounts.enable = true;
		};
		pipewire = {
			enable = true;
			pulse.enable = true;
		};
		libinput.enable = true;
	};


	users.users.${username} = {
		isNormalUser = true;
		extraGroups = [ "wheel" ];
		shell = pkgs.zsh;
	};

	programs = {
		firefox.enable = true;
		zsh.enable = true;
		geary.enable = false;
	};

	environment.systemPackages = with pkgs; [ vim ];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;
}

