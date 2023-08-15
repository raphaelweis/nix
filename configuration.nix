# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
	imports = [ ./hardware-configuration.nix ];

# Bootloader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.systemd-boot.configurationLimit = 5;  
	boot.loader.efi.canTouchEfiVariables = true;

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

# bluetooth
	hardware.bluetooth.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.

	networking.hostName = "nixos"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
		networking.networkmanager.enable = true;

# Set your time zone.
	time.timeZone = "Europe/Paris";

# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
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

# Configure keymap in X11
	services.xserver = {
		layout = "us";
		xkbVariant = "intl";
	};
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
		jack.enable = true;
	};

# Configure console keymap
	console.keyMap = "us-acentos";

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.defaultUserShell = pkgs.zsh;
	users.users.raphaelw = {
		isNormalUser = true;
		description = "Raphaël Weis";
		extraGroups = [ "networkmanager" "wheel" "input" "video" ];
		packages = with pkgs; [];
	};

	security.sudo.wheelNeedsPassword = false;
	security.rtkit.enable = true; # recommended for pipewire

# Allow unfree packages
		nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim
		curl
		git
		gcc
		alacritty
		tmux
		firefox
		starship
		neovim
		rofi
		lsd
		wl-clipboard
		cliphist
		hyprpaper
		bluetuith
		pavucontrol
		vscode
		networkmanagerapplet
		acpi
		gh
	];

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
	];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
	programs.zsh.enable = true;
	programs.hyprland.enable = true;
	programs.hyprland.xwayland.enable = true;
	xdg.portal.enable = true;
	xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

# List services that you want to enable:

# Enable the OpenSSH daemon.
# services.openssh.enable = true;

# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "23.05"; # Did you read the comment?
}
