{ config, lib, pkgs, ... }:

{
  imports = [
		./hardware-configuration.nix
	];

	hmConfig = ./home.nix;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

	services.xserver = {
		enable = true;
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				dmenu
				alacritty
				i3status
				i3lock
				i3blocks
			];
		};
	};
	services.displayManager = {
		defaultSession = "none+i3";
	};

	services.onedrive.enable = true;
	
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.variant = "intl";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
		enable = true;
  	powerOnBoot = true;
	};

  users.users.raphaelw = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
  ];

  system.stateVersion = "24.05";
}

