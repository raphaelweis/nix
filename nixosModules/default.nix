{ inputs, config, lib, pkgs, username, system, ... }:
{
	options.rw.homeManagerConfig = lib.mkOption {
		description = "Home manager config path for host specific settings.";
		type = lib.types.path;
	};

	config = {
		home-manager = {
			useUserPackages = true;
			useGlobalPkgs = true;
			users.${username}.imports = [
				(import config.rw.homeManagerConfig)
				inputs.self.outputs.homeManagerModules.default
			];
			extraSpecialArgs = { inherit inputs username system; };
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
				gnome-keyring.enable = true;
			};
			pipewire = {
				enable = true;
				alsa.enable = true;
				alsa.support32Bit = true;
				pulse.enable = true;
			};
			libinput.enable = true;
		};

		security = {
			polkit.enable = true;
			rtkit.enable = true;
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
			sway.enable = true;
		};

		environment.systemPackages = with pkgs; [ vim ];

		nix.settings.experimental-features = [ "nix-command" "flakes" ];
	};
}
