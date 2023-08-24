{ pkgs, ... }:
let
	vars = import ./vars.nix;
in
{
	imports = [
		(import ../../modules/nixos/xremap)
		(import ../../modules/nixos/fonts)
		(import ../../modules/nixos/hyprland)
		(import ./hardware-configuration.nix)
	]; 

    boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
            systemd-boot = {
                enable = true;
                configurationLimit = 3;
            };
            efi.canTouchEfiVariables = true;
            timeout = 5;
        };
    };

    hardware = {
		bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
		opengl.enable = true;
	};

	services.blueman.enable = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Enable flakes and the nix command

	environment.pathsToLink = [ "/share/zsh" ]; # Enable completion for system packages

    users.users.${vars.username} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "camera" "networkmanager" "kvm" "libvirtd" "input" ];
        shell = pkgs.zsh;
    };
    security.sudo.wheelNeedsPassword = false;
    time.timeZone = "Europe/Brussels";
    i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
		    LC_ADDRESS = "fr_FR.UTF-8";
            LC_IDENTIFICATION = "fr_FR.UTF-8";
            LC_MEASUREMENT = "fr_FR.UTF-8";
            LC_MONETARY = "fr_FR.UTF-8";
            LC_NAME = "fr_FR.UTF-8";
            LC_NUMERIC = "fr_FR.UTF-8";
            LC_PAPER = "fr_FR.UTF-8";
            LC_TELEPHONE = "fr_FR.UTF-8";
            LC_TIME = "fr_FR.UTF-8";
        };
    };
    security.rtkit.enable = true;
    security.polkit.enable = true;

    networking.networkmanager.enable = true;
	services = {
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
	    };
	    gvfs.enable = true;
    };

    environment.systemPackages = with pkgs; [
		home-manager
        vim
        gcc
        alsa-utils
        killall
        ripgrep
        curl
		zsh
    ];
	programs.dconf.enable = true;
	programs.zsh.enable = true;
	
    system.stateVersion = "23.05";
}
